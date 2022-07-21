final createTablePaciente = '''
    CREATE TABLE paciente(
      id INTEGER PRIMARY KEY,
      nome TEXT NOT NULL,
      telefone TEXT NOT NULL
    )
''';

final insert1 = '''
  INSERT INTO paciente (nome, telefone) VALUES ("Projeto", "(44)91234-5678")
''';
