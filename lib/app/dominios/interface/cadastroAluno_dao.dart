import 'package:projeto_ddm/app/dominios/entidades/cadastroAluno.dart';

abstract class CadastroalunoDAO {

  
  save(Cadastroaluno cadatroAluno);

  remove(int id);

  Future<List<Cadastroaluno>> find();
}
