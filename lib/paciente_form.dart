import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PatienteForm extends StatelessWidget {
  var nome;
  var telefone;
  var id;
  cadastrar(int? id, String nome, String telefone) async {
    var caminho = join(await getDatabasesPath(), 'banco.db');
    var banco = await openDatabase(caminho);
    String sql;
    if (id == null) {
      sql = 'INSERT INTO paciente (nome, telefone) VALUES (?, ?)';
      banco.rawInsert(sql, [nome, telefone]);
    } else {
      sql = 'UPDATE paciente SET nome = ?, telefone = ? WHERE id = ?';
      banco.rawUpdate(sql, [nome, telefone, id]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de pacientes')),
      body: Form(
        child: Column(
          children: [
            TextField(
              onChanged: (nomePaciente) {
                nome = nomePaciente;
              },
              decoration: InputDecoration(
                  label: Text('Nome Completo'),
                  hintText: 'Digite o nome do Paciente'),
            ),
            TextField(
              onChanged: (telefonePaciente) {
                telefone = telefonePaciente;
              },
              decoration: InputDecoration(
                  label: Text('Telefone'), hintText: 'Telefone do Paciente'),
            ),
            ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {
                  cadastrar(id, nome, telefone);
                  Navigator.pushNamed(context, '/');
                }),
          ],
        ),
      ),
    );
  }
}
