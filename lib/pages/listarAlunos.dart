import 'package:flutter/material.dart';
import 'package:projeto_ddm/app/aluno_dto.dart';
import 'package:projeto_ddm/repositorios/alunoRepository.dart';
import 'package:projeto_ddm/pages/cadastro.dart';

class ListaAlunosScreen extends StatefulWidget {
  final AlunoRepository repository;

  const ListaAlunosScreen({required this.repository, Key? key}) : super(key: key);

  @override
  ListaAlunosScreenState createState() => ListaAlunosScreenState();
}

class ListaAlunosScreenState extends State<ListaAlunosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Alunos'),
      ),
      body: _buildLista(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirTelaCadastro(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLista() {
    final alunos = widget.repository.listarTodos();
    
    if (alunos.isEmpty) {
      return const Center(
        child: Text('Nenhum aluno cadastrado'),
      );
    }

    return ListView.builder(
      itemCount: alunos.length,
      itemBuilder: (context, index) {
        final aluno = alunos[index];
        return Card(
          child: ListTile(
            title: Text(aluno.nome),
            subtitle: Text(aluno.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _abrirTelaCadastro(aluno),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _confirmarRemocao(aluno),
                ),
              ],
            ),
            onTap: () => _mostrarDetalhes(aluno),
          ),
        );
      },
    );
  }

  void _abrirTelaCadastro(AlunoDto? aluno) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cadastro(
          repository: widget.repository,
          alunoParaEditar: aluno,
        ),
      ),
    );

    if (resultado == true) {
      setState(() {});
    }
  }

  void _mostrarDetalhes(AlunoDto aluno) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(aluno.nome),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${aluno.email}'),
              Text('Telefone: ${aluno.telefone}'),
              Text('Idade: ${aluno.idade}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmarRemocao(AlunoDto aluno) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Deseja realmente excluir ${aluno.nome}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                widget.repository.remover(aluno.id);
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}