import 'package:flutter/material.dart';
import 'package:projeto_flutter/Controller/paciente_controle.dart';
import 'package:projeto_flutter/entidades/paciente.dart';

class PacienteView extends StatelessWidget {
  var pacienteControle = PacienteControle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pacientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/patient-form'),
          )
        ],
      ),
      body: FutureBuilder(
        future: pacienteControle.litarDados(),
        builder: (context, AsyncSnapshot<List<Paciente>> dadosFuturos) {
          if (!dadosFuturos.hasData) return CircularProgressIndicator();
          List<Paciente> pacientes = dadosFuturos.data!;
          return ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, contador) {
                var paciente = pacientes[contador];
                return ListTile(
                  title: Text(paciente.nome!),
                  subtitle: Text(paciente.telefone!),
                );
              });
        },
      ),
    );
  }
}
