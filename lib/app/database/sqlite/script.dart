final createTable = """
  CREATE TABLE cadastroAluno(
  id INT PRIMARY KEY
  ,nome VARCHAR(200) NOT NULL
  ,email VARCHAR(200) NOT NULL
  ,telefone CHAR(11) NOT NULL
  ,idade INT NOT NULL
)
""";

final insert = """
insert into cadastroAluno(nome, email, telefone, idade)
values('Renan','renan@.com', '44999999999', 20)
""";

final insert2 = """
insert into cadastroAluno(nome, email, telefone, idade)
values('Emily','Emely@.com', '44999999991', 21)
""";

final insert3 = """
insert into cadastroAluno(nome, email, telefone, idade)
values('Vitor','vitor@.com', '44999999993', 34)
""";
