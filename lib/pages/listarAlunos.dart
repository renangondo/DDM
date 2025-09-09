import 'package:flutter/material.dart';
import 'package:projeto_ddm/app/dominios/entidades/cadastroAluno.dart';
import 'package:projeto_ddm/app/database/sqlite/dao/cadastroAluno_dao_impl.dart';
import 'package:projeto_ddm/pages/cadastro.dart';

class ListaAlunosScreen extends StatefulWidget {
  @override
  _ListaAlunosScreenState createState() => _ListaAlunosScreenState();
}

class _ListaAlunosScreenState extends State<ListaAlunosScreen> {
  // Método para buscar os alunos de forma assíncrona
  Future<List<Cadastroaluno>> _buscarAlunos() async {
    return await CadastroalunoDAOImpl().find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Alunos'),
      ),
      body: FutureBuilder<List<Cadastroaluno>>(
        future: _buscarAlunos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum aluno cadastrado'));
          }

          List<Cadastroaluno> alunos = snapshot.data!;

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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirTelaCadastro(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Função para abrir a tela de cadastro de aluno (para edição ou novo)
  void _abrirTelaCadastro(Cadastroaluno? aluno) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cadastro(
          alunoParaEditar: aluno,
        ),
      ),
    );

    if (resultado == true) {
      setState(() {});
    }
  }

  // Função para mostrar os detalhes do aluno
  void _mostrarDetalhes(Cadastroaluno aluno) {
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

  // Função para confirmar a remoção de um aluno
  void _confirmarRemocao(Cadastroaluno aluno) {
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
                // Remover o aluno do banco de dados
                CadastroalunoDAOImpl().remove(aluno.id);
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
