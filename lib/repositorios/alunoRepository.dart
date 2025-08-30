import 'package:projeto_ddm/app/aluno_dto.dart';

class AlunoRepository {
  final List<AlunoDto> _alunos = [];

  // Criação
  void adicionar(AlunoDto aluno) {
    aluno.validate();
    _alunos.add(aluno);
  }

  // Listar
  List<AlunoDto> listarTodos() {
    return List.from(_alunos);
  }

  AlunoDto? buscarPorId(String id) {
    try {
      return _alunos.firstWhere((aluno) => aluno.id == id);
    } catch (e) {
      return null;
    }
  }

  // Update
  void atualizar(AlunoDto alunoAtualizado) {
    alunoAtualizado.validate();
    final index = _alunos.indexWhere((aluno) => aluno.id == alunoAtualizado.id);
    if (index >= 0) {
      _alunos[index] = alunoAtualizado;
    }
  }

  // Delete
  void remover(String id) {
    _alunos.removeWhere((aluno) => aluno.id == id);
  }
}