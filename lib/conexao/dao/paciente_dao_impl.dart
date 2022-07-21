import 'package:projeto_flutter/entidades/paciente.dart';
import 'package:projeto_flutter/interfaces/paciente_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../conexao.dart';

class PacienteDAOImpl implements PacienteDAO {
  Database? _db;

  @override
  Future<List<Paciente>> consultar() async {
    _db = await ConexaoBancoDados.conexao();
    List<Map<String, dynamic>> consulta = await _db!.query('paciente');
    List<Paciente> lista = List.generate(consulta.length, (i) {
      var linha = consulta[i];
      return Paciente(
          id: linha['id'], nome: linha['nome'], telefone: linha['telefone']);
    });

    return lista;
  }

  @override
  excluir(int id) async {
    _db = await ConexaoBancoDados.conexao();
    var sql = 'DELETE FROM paciente WHERE id = ?';
    _db!.rawDelete(sql, [id]);
  }

  @override
  salvar(Paciente paciente) async {
    _db = await ConexaoBancoDados.conexao();
    var sql;
    if (paciente.id == null) {
      sql = 'INSERT INTO paciente (nome, telefone) VALUES (?, ?)';
      _db!.rawInsert(sql, [paciente.nome, paciente.telefone]);
    } else {
      sql = 'UPATE paciente SET nome=?, telefone=? WHERE id=?';
      _db!.rawUpdate(sql, [paciente.nome, paciente.telefone, paciente.id]);
    }
  }
}
