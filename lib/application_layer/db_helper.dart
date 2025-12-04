import 'package:google_contact/domain_layer/contacts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("contacts.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        email TEXT,
        isFavorite INTEGER
      )
    ''');
  }

  Future<int> insertContact(Contact contact) async {
    final db = await instance.database;
    return db.insert('contacts', contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    final db = await instance.database;
    final result = await db.query('contacts', orderBy: "name ASC");
    return result.map((e) => Contact.fromMap(e)).toList();
  }

  Future<List<Contact>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('contacts', where: "isFavorite = 1");
    return result.map((e) => Contact.fromMap(e)).toList();
  }

  Future<int> updateContact(Contact contact) async {
    final db = await instance.database;
    return db.update('contacts', contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    final db = await instance.database;
    return db.delete('contacts', where: "id = ?", whereArgs: [id]);
  }
}
