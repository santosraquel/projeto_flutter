import 'package:path/path.dart';
import 'package:projeto_flutter/conexao/script_sqflite.dart';
import 'package:sqflite/sqflite.dart';

class ConexaoBancoDados {
  static Database? _db;

  static Future<Database> conexao() async {
    if (_db == null) {
      String caminhoBD = join(await getDatabasesPath(), 'banco.db');
      _db = await openDatabase(caminhoBD, version: 1, onCreate: (db, version) {
        db.execute(createTablePaciente);
        db.execute(insert1);
      });
    }
    return _db!;
  }
}
