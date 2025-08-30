import 'package:projeto_ddm/app/dto.dart';
import 'package:projeto_ddm/exception/validate_exception.dart';
import 'package:projeto_ddm/services/string_generator.dart';

class AlunoDto extends DTO {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String idade;

  AlunoDto({
    String? id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.idade,
  }) : id = id ?? stringGenerator();

  factory AlunoDto.empty() {
    return AlunoDto(
      nome: '',
      email: '',
      telefone: '',
      idade: '',
    );
  }

  AlunoDto copyWith({
    String? id,
    String? nome,
    String? email,
    String? telefone,
    String? idade,
  }) {
    return AlunoDto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      idade: idade ?? this.idade,
    );
  }
  
  @override
  void validate() {
    if (nome.isEmpty) {
      throw ValidateException('O nome é obrigatório');
    }
    if (email.isEmpty || !email.contains('@')) {
      throw ValidateException('Email inválido');
    }
    if (telefone.isEmpty) {
      throw ValidateException('Telefone é obrigatório');
    }
    if (idade.isEmpty || int.tryParse(idade) == null) {
      throw ValidateException('Idade deve ser um número');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'idade': idade,
    };
  }

  factory AlunoDto.fromMap(Map<String, dynamic> map) {
    return AlunoDto(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      idade: map['idade'],
    );
  }
}