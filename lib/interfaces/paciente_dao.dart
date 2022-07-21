import 'package:projeto_flutter/entidades/paciente.dart';

abstract class PacienteDAO {
  salvar(Paciente paciente);

  Future<List<Paciente>> consultar();
  // Future<List<Map<String, Object?>>> consultar();

  excluir(int id);
}
