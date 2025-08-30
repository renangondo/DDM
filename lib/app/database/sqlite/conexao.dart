import 'package:path/path.dart';
import 'package:projeto_ddm/app/database/sqlite/script.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static late Database db;

  static Future<Database> get() async {
    if (db == null) {
      var path = join(await getDatabasesPath(), "banco_cadastro");
      db = await openDatabase(
        path,
        version: 2,
        onCreate: (db, v) {
          db.execute(createTable);
          db.execute(insert);
          db.execute(insert2);
          db.execute(insert3);
        },
      );
    }
    return db;
  }
}
