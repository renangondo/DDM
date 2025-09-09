import 'package:projeto_ddm/app/database/sqlite/conexao.dart';
import 'package:projeto_ddm/app/dominios/entidades/cadastroAluno.dart';
import 'package:projeto_ddm/app/dominios/interface/cadastroAluno_dao.dart';
import 'package:projeto_ddm/pages/login.dart';
import 'package:sqflite/sqflite.dart';

class CadastroalunoDAOImpl implements CadastroalunoDAO {
  late Database db;

  @override
  Future<List<Cadastroaluno>> find() async {
    db = await Conexao.get();
    db.query('CadastroAluno');
    List<Map<String, dynamic>> resultado = await db.query('cadastroAluno');
    List<Cadastroaluno> lista = List.generate(resultado.length, (i) {
      var linha = resultado[i];

      return Cadastroaluno(
          id: int.parse(['id'].toString()),
          nome: linha['nome'],
          email: linha['email'],
          telefone: linha['telefone'],
          idade: linha['idade']);
    });
    return lista;
  }

  @override
  remove(int id) async {
    db = await Conexao.get();

    var sql = 'DELETE FROM cadastroAluno WHERE id = ?';
    db.rawDelete(sql, [id]);
  }

  @override
  save(Cadastroaluno cadatroAluno) async {
    db = await Conexao.get();
    var sql;

    if (cadatroAluno.id == null) {
      sql =
          'INSERT INTO cadastroAluno(nome, email, telefone, idade) VALUES(?,?, ?, ?)';
      db.rawInsert(sql, [
        cadatroAluno.nome,
        cadatroAluno.email,
        cadatroAluno.telefone,
        cadatroAluno.idade
      ]);
    } else {
      sql =
          'UPDATE cadastroAluno SET nome = ?, email = ?, telefone = ?, idade = ?';
      db.rawUpdate(sql, [
        cadatroAluno.nome,
        cadatroAluno.email,
        cadatroAluno.telefone,
        cadatroAluno.idade
      ]);
    }
  }
}
