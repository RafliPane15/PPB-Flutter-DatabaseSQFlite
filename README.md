NAMA  : Rafli Syahputra Pane/
NRP   : 5025221038

# PPB-Flutter-DatabaseSQFlite

*Hanya upload folder lib saja karena folder project terlalu besar sizenya sehingga tidak bisa diupload semua ke github


Implementasi aplikasi Flutter yang menggunakan SQLite untuk menyimpan data produk menggunakan package `sqflite`. State management dilakukan menggunakan `Provider`.

## Fitur

- Menampilkan daftar produk dari database SQLite
- Menambahkan produk baru ke database
- Mengedit deskripsi produk dan menyimpannya ke database
- Menambahkan produk ke keranjang

## Tambahkan dependency ke `pubspec.yaml`

Tambahkan package berikut agar bisa menggunakan SQLite (`sqflite`) dan mengelola path database (`path`), serta `provider` untuk state management.

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.3
  provider: ^6.1.1
```

## Membuat model product

Model Product mendeskripsikan struktur data produk yang akan disimpan di database.

```
class Product {
  final int? id;
  final String name;
  final double price;
  final String description;
  final String imagePath;

  Product({this.id, required this.name, required this.price, required this.description, required this.imagePath});

  Map<String, dynamic> toMap() { ... }
  factory Product.fromMap(Map<String, dynamic> map) { ... }
}
```

`toMap()` mengubah data ke format yang bisa disimpan di SQLite.

`fromMap()` mengubah data hasil query SQLite ke bentuk objek Product.

## Membuat DatabaseHelper untuk Abstraksi Database

File ini berfungsi untuk membuka koneksi ke database, membuat tabel, dan menyediakan fungsi insert, update, fetch, serta delete.

```
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
```

- Membuat satu instance DatabaseHelper yang digunakan secara global dalam aplikasi agar hanya ada satu koneksi database aktif.

- `instance` adalah satu-satunya akses ke kelas ini.

- `_database` adalah cache dari koneksi database.

```
Future<Database> get database async {
  if (_database != null) return _database!;
  _database = await _initDB("shop.db");
  return _database!;
}
```
Getter database akan memeriksa apakah database sudah ada. Jika belum, akan dipanggil `_initDB()` untuk membuat database.

```
Future<Database> _initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, filePath);

  return await openDatabase(path, version: 1, onCreate: _createDB);
}
```
`_initDB()` menentukan path file database (`shop.db`) di direktori aplikasi, dan membuka koneksi database. Jika database belum ada, maka fungsi `_createDB()` akan dipanggil.

```
Future _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      price REAL NOT NULL,
      description TEXT,
      imagePath TEXT
    )
  ''');
}
```
Membuat tabel products sesuai dengan atribut yang diperlukan.

```
Future<void> insertProduct(Product product) async {
  final db = await instance.database;
  await db.insert('products', product.toMap());
}
```

Mengambil koneksi database, lalu menyisipkan data dari model Product ke tabel products.

```
Future<List<Product>> fetchAllProducts() async {
  final db = await instance.database;
  final maps = await db.query('products');

  return List.generate(maps.length, (i) {
    return Product.fromMap(maps[i]);
  });
}

Future<void> deleteAllProducts() async {
  final db = await instance.database;
  await db.delete('products');
}
```
Mengambil semua baris dari tabel `products`, dan mengubahnya menjadi daftar objek `Product` dengan `Product.fromMap`. fungsi delete untuk menghapus seluruh isi tabel products.

```
Future<void> updateProduct(Product product) async {
  final db = await database;
  await db.update(
    'products',
    product.toMap(),
    where: 'id = ?',
    whereArgs: [product.id],
  );
}
```

Memperbarui entri produk berdasarkan id menggunakan metode update.

## Membuat Provider Shop untuk State Management

Class ini berfungsi sebagai pengelola data untuk menampilkan produk di UI dan mengatur state keranjang.

```
class Shop extends ChangeNotifier {
  List<Product> _shop = [];
  final List<Product> _cart = [];

  Shop() {
    _loadProductsFromDB();
  }

  Future<void> _loadProductsFromDB() async {
    _shop = await DatabaseHelper.instance.fetchAllProducts();
    ...
    notifyListeners();
  }

  void addProduct(...) async { ... }
  void updateProductDescription(...) async { ... }
  void addItemToCart(...) { ... }
  void removeItemFromCart(...) { ... }
}
```

`_loadProductsFromDB()` akan mengisi daftar produk dari database. Fungsi `addProduct` dan `updateProductDescription` akan menyimpan perubahan ke database lalu memuat ulang data.

import database_helper.dart ke semua file page agar dapat diimplementasikan ke program.

## Lakukan penyesuain pada model

```

  List<Product> get shop => _shop;
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  Shop() {
    _loadProductsFromDB();
  }

  Future<void> _loadProductsFromDB() async {
    _shop = await DatabaseHelper.instance.fetchAllProducts();
```

pada model `shop.dart` menambahkan integrasi langsung dengan SQLite melalui DatabaseHelper, sehingga data produk kini dimuat dari database saat aplikasi dijalankan. Jika database kosong, dua produk dummy akan ditambahkan sebagai data awal. Fungsi  `addProduct` juga diperluas agar bisa menyisipkan produk baru ke database dan memperbarui daftar produk yang tersedia. Dengan ini, data produk menjadi persisten dan tetap tersedia meskipun aplikasi ditutup dan dibuka kembali.

Implementasi berhasil jika perubahan yang dilakukan pada saat aplikasi dijalankan tidak berubah saat aplikasi dilakukan restart.
