import 'package:db_qoutes_app/Models/db_model.dart';
import 'package:db_qoutes_app/helpers/api_helpher.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String iD = "id";
  final String Quots = "quote";
  final String Authors = "authors";
  final String Images = "images";

  Database? db;

  Future<void> iniDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, "quotes.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {});
    await db?.execute(
        "CREATE TABLE IF NOT EXISTS tableName ($iD INTEGER PRIMARY KEY AUTOINCREMENT, $Quots TEXT, $Authors TEXT, $Images BLOB)");
  }

  insertRecord() async {
    await iniDB();

    List<Quotes>? data =
        await APIHelper.apiHelper.fetchQuotes();
    for (int i = 0; i < data!.length; i++) {
      String query =
          "INSERT INTO tableName($Quots, $Authors,$Images) VALUES(?,?,?)";
      List args = [data[i].quotes, data[i].author, data[i].image];

      await db?.rawInsert(query, args);
    }
  }

  Future<List<DBQuotes>> fetchAllRecords() async {
    await insertRecord();

    String query = "SELECT * FROM tableName";

    List<Map<String, dynamic>> allQuotes = await db!.rawQuery(query);
    List<DBQuotes> quotes = allQuotes.map((e) => DBQuotes.fromMap(e)).toList();

    print(quotes);
    return quotes;
  }
}
