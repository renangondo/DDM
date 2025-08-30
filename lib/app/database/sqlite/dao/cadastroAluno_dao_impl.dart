import 'package:projeto_ddm/app/database/sqlite/conexao.dart';
import 'package:projeto_ddm/app/dominios/entidades/cadastroAluno.dart';
import 'package:projeto_ddm/app/dominios/interface/cadastroAluno_dao.dart';
import 'package:sqflite/sqflite.dart';

class CadastroalunoDAOImpl implements CadastroalunoDAO {
  late Database db;

  @override
  Future<List<Cadastroaluno>> find() {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  remove(int id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  save(Cadastroaluno cadatroAluno) async {
    db = await Conexao.get();
    var sql;

    if (cadastroAluno.id = null) {
      sql = 'INSERT INTO cadastroAluno(nome, email, telefone, idade) VALUES('Renan','renan@.com', '44999999999', 20)',
    }
    
  }
}
