Atividade individual - Tema: Sistema Universidade (FUNCTIONS), é uma Atividade individual, feita para a matéria Banco de Dados da Facens.

Entidades:

Alunos:

Atributos: ID (PK), Nome, Email, Curso_ID (FK)

Cursos:

Atributos: ID (PK), Nome, Descrição, Área_ID (FK)

Áreas:

Atributos: ID (PK), Nome

Relacionamentos:

Um aluno está matriculado em um único curso. (Relacionamento 1 para N entre Alunos e Cursos)
Um curso pertence a uma única área. (Relacionamento N para 1 entre Cursos e Áreas)



Diagrama:

+---------------------+     +---------------------+     +---------------------+
|      Alunos         |     |       Cursos        |     |        Áreas        |
+---------------------+     +---------------------+     +---------------------+
| PK: ID              |     | PK: ID              |     | PK: ID              |
| Nome                |     | Nome                |     | Nome                |
| Email               |     | Descrição           |     +---------------------+
| FK: Curso_ID        |     | FK: Área_ID         |
+---------------------+     +---------------------+


Neste modelo:

A tabela de Alunos contém informações sobre os alunos, incluindo seu nome, e-mail e o ID do curso em que estão matriculados.
A tabela de Cursos armazena informações sobre os cursos, como nome, descrição e o ID da área à qual pertencem.
A tabela de Áreas mantém os detalhes sobre as diferentes áreas disponíveis na universidade.
Os relacionamentos são estabelecidos por meio das chaves estrangeiras (FK), garantindo a integridade referencial entre as tabelas.
