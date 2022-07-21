import 'package:projeto_flutter/conexao/dao/paciente_dao_impl.dart';
import 'package:projeto_flutter/entidades/paciente.dart';

class PacienteControle {
  var pacienteModelo = PacienteDAOImpl();

  Future<List<Paciente>> litarDados() {
    return pacienteModelo.consultar();
  }
}
