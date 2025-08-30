import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projeto_ddm/app/aluno_dto.dart';
import 'package:projeto_ddm/app/database/sqlite/conexao.dart';
import 'package:projeto_ddm/repositorios/alunoRepository.dart';
import 'package:sqflite/sqflite.dart';

class Cadastro extends StatefulWidget {
  final AlunoRepository repository;
  final AlunoDto? alunoParaEditar;

  const Cadastro({
    required this.repository,
    this.alunoParaEditar,
    Key? key,
  }) : super(key: key);

  @override
  CadastroScreenState createState() => CadastroScreenState();
}

class CadastroScreenState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  late AlunoDto _aluno;

  Future<List<Map<String, dynamic>>> _buscar() async {
    Database db = await Conexao.get();
    return db.query('cadastroAluno');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _buscar(),
        builder: (context, futuro) {
          if (futuro.hasData) {
            var lista = futuro.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.alunoParaEditar == null
                    ? 'Cadastrar Aluno'
                    : 'Editar Aluno'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _aluno.nome,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _aluno = _aluno.copyWith(nome: value);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: _aluno.email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _aluno = _aluno.copyWith(email: value);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: _aluno.telefone,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o telefone';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _aluno = _aluno.copyWith(telefone: value);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: _aluno.idade,
                        decoration: const InputDecoration(
                          labelText: 'Idade',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null) {
                            return 'Por favor, insira uma idade válida';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _aluno = _aluno.copyWith(idade: value);
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _salvarAluno,
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold();
          }
        });
  }

  @override
  void initState() {
    super.initState();
    _aluno = widget.alunoParaEditar?.copyWith() ?? AlunoDto.empty();
  }

  void _salvarAluno() {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.alunoParaEditar == null) {
          widget.repository.adicionar(_aluno);
        } else {
          widget.repository.atualizar(_aluno);
        }
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: ${e.toString()}')),
        );
      }
    }
  }
}
