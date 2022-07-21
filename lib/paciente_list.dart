import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projeto_flutter/conexao/dao/paciente_dao_impl.dart';
import 'package:sqflite/sqflite.dart';

import 'entidades/paciente.dart';

class ListaPaciente extends StatelessWidget {
  Future<List<Paciente>> buscarDados() async {
    return PacienteDAOImpl().consultar();

    // Future<List<Map<String, Object?>>> buscarDados() async {
    // await Future.delayed(const Duration(seconds: 2));
    // List<Map<String, Object?>> pacientes = [
    //   {'nome': 'Projeto', 'telefone': 'Projeto WEB'},
    //   {'nome': 'Apresentação', 'telefone': 'Apresentação Grupo'},
    //   {'nome': 'Lista', 'telefone': 'Lista de Exercícios'}
    // ];
    // return pacientes;
    // // print(dados.length);
    // // print(dados.keys);
    // // print(dados.values);
    // // print(dados['nome']);
  }

  Future<List<Map<String, Object?>>> buscarDadosBanco() async {
    String caminhoBD = join(await getDatabasesPath(), 'banco.db');
    Database banco =
        await openDatabase(caminhoBD, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE paciente(
          id INTEGER PRIMARY KEY,
          nome TEXT NOT NULL,
          telefone TEXT NOT NULL
        )
      ''');
      // db.execute(
      //     'INSERT INTO paciente (nome, telefone) VALUES ("Projeto", "Projeto WEB")');
      // db.execute(
      //     'INSERT INTO paciente (nome, telefone) VALUES ("Projeto", "Projeto WEB")');
      // db.execute(
      //     'INSERT INTO paciente (nome, telefone) VALUES ("Projeto", "Projeto WEB")');
    });
    List<Map<String, Object?>> pacientes =
        await banco.rawQuery('SELECT * FROM paciente');
    return pacientes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pacientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/patiente-form'),
          )
        ],
      ),
      body: FutureBuilder(
        future: buscarDadosBanco(),
        builder:
            (context, AsyncSnapshot<List<Map<String, Object?>>> dadosFuturos) {
          if (!dadosFuturos.hasData) return CircularProgressIndicator();
          var pacientes = dadosFuturos.data!;
          return ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, contador) {
                var paciente = pacientes[contador];
                return ListTile(
                  title: Text(paciente['nome'].toString()),
                  subtitle: Text(paciente['telefone'].toString()),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                      ],
                    ),
                  ),
                  // trailing: Container(
                  //     width: 100,
                  //     child: Row(
                  //       children: [
                  //         IconButton(
                  //             icon: Icon(Icons.edit), onPressed: () => {}),
                  //         IconButton(
                  //             icon: Icon(Icons.delete), onPressed: () => {}),
                  //       ],
                  //     )),
                );
              });
        },
      ),
    );
  }
}
