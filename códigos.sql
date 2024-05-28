
CREATE DATABASE IF NOT EXISTS universidade;

USE universidade;

CREATE TABLE IF NOT EXISTS areas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    area_id INT,
    FOREIGN KEY (area_id) REFERENCES areas(id)
);

CREATE TABLE IF NOT EXISTS alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

DELIMITER //

CREATE PROCEDURE inserir_curso(
    IN nome_curso VARCHAR(100),
    IN descricao_curso TEXT,
    IN area_id INT
)
BEGIN
    INSERT INTO cursos (nome, descricao, area_id) 
    VALUES (nome_curso, descricao_curso, area_id);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE selecionar_cursos_por_area(
    IN area_nome VARCHAR(100)
)
BEGIN
    SELECT c.nome, c.descricao
    FROM cursos c
    INNER JOIN areas a ON c.area_id = a.id
    WHERE a.nome = area_nome;
END //

DELIMITER ;

CALL inserir_curso('Nome do Curso', 'Descrição do Curso', 1);

CALL selecionar_cursos_por_area('Nome da Área');

DELIMITER //

CREATE PROCEDURE inserir_aluno(
    IN nome_aluno VARCHAR(100),
    IN sobrenome_aluno VARCHAR(100),
    IN curso_id INT
)
BEGIN
    DECLARE email_aluno VARCHAR(200);
    
    -- Gerando o e-mail com base no nome e sobrenome
    SET email_aluno = CONCAT(nome_aluno, '.', sobrenome_aluno, '@dominio.com');
    
    -- Inserindo o aluno na tabela de alunos
    INSERT INTO alunos (nome, email, curso_id) 
    VALUES (nome_aluno, email_aluno, curso_id);
END //

DELIMITER ;

CALL inserir_aluno('Nome', 'Sobrenome', 1);

DELIMITER //

CREATE PROCEDURE inserir_novo_curso(
    IN nome_curso VARCHAR(100),
    IN descricao_curso TEXT,
    IN area_nome VARCHAR(100)
)
BEGIN
    DECLARE area_id INT;
    
    SELECT id INTO area_id FROM areas WHERE nome = area_nome;
    
    IF area_id IS NULL THEN
        INSERT INTO areas (nome) VALUES (area_nome);
        SET area_id = LAST_INSERT_ID();
    END IF;
    
    -- Inserindo o novo curso
    INSERT INTO cursos (nome, descricao, area_id) 
    VALUES (nome_curso, descricao_curso, area_id);
END //

DELIMITER ;

CALL inserir_novo_curso('Nome do Novo Curso', 'Descrição do Novo Curso', 'Nome da Área');

DELIMITER //

CREATE FUNCTION obter_id_curso(
    nome_curso VARCHAR(100),
    nome_area VARCHAR(100)
)
RETURNS INT
BEGIN
    DECLARE curso_id INT;
    
    SELECT c.id INTO curso_id
    FROM cursos c
    INNER JOIN areas a ON c.area_id = a.id
    WHERE c.nome = nome_curso AND a.nome = nome_area;
    
    RETURN curso_id;
END //

DELIMITER ;

SELECT obter_id_curso('Nome do Curso', 'Nome da Área');

DELIMITER //

CREATE PROCEDURE matricular_aluno(
    IN nome_aluno VARCHAR(100),
    IN email_aluno VARCHAR(100),
    IN nome_curso VARCHAR(100),
    IN nome_area VARCHAR(100)
)
BEGIN
    DECLARE curso_id INT;
    DECLARE aluno_id INT;
    
    SELECT c.id INTO curso_id
    FROM cursos c
    INNER JOIN areas a ON c.area_id = a.id
    WHERE c.nome = nome_curso AND a.nome = nome_area;
    
    SELECT id INTO aluno_id
    FROM alunos
    WHERE nome = nome_aluno AND email = email_aluno;
    
    IF aluno_id IS NULL THEN
        INSERT INTO alunos (nome, email, curso_id) 
        VALUES (nome_aluno, email_aluno, curso_id);
    ELSE
    
        UPDATE alunos
        SET curso_id = curso_id
        WHERE id = aluno_id;
    END IF;
END //

DELIMITER ;

CALL matricular_aluno('Nome do Aluno', 'email@dominio.com', 'Nome do Curso', 'Nome da Área');

DELIMITER //

CREATE PROCEDURE matricular_aluno(
    IN nome_aluno VARCHAR(100),
    IN email_aluno VARCHAR(100),
    IN nome_curso VARCHAR(100),
    IN nome_area VARCHAR(100)
)
BEGIN
    DECLARE curso_id INT;
    DECLARE aluno_id INT;
    
    SELECT c.id INTO curso_id
    FROM cursos c
    INNER JOIN areas a ON c.area_id = a.id
    WHERE c.nome = nome_curso AND a.nome = nome_area;
    
    SELECT id INTO aluno_id
    FROM alunos
    WHERE nome = nome_aluno AND email = email_aluno;
    
    IF aluno_id IS NULL THEN
        INSERT INTO alunos (nome, email, curso_id) 
        VALUES (nome_aluno, email_aluno, curso_id);
    ELSE

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O aluno já está matriculado em um curso.';
    END IF;
END //

DELIMITER ;

INSERT INTO alunos (nome, email, curso_id) VALUES
('João Silva', 'joao.silva@dominio.com', 1),
('Maria Santos', 'maria.santos@dominio.com', 2),
('Pedro Oliveira', 'pedro.oliveira@dominio.com', 3),
('Ana Pereira', 'ana.pereira@dominio.com', 1),
('Luiz Costa', 'luiz.costa@dominio.com', 2),
('Fernanda Martins', 'fernanda.martins@dominio.com', 3),
('Marcos Souza', 'marcos.souza@dominio.com', 1),
('Carla Almeida', 'carla.almeida@dominio.com', 2),
('Rafael Ferreira', 'rafael.ferreira@dominio.com', 3),
('Aline Gonçalves', 'aline.goncalves@dominio.com', 1),
('Bruno Vieira', 'bruno.vieira@dominio.com', 2),
('Mariana Lima', 'mariana.lima@dominio.com', 3),
('Gabriel Santos', 'gabriel.santos@dominio.com', 1),
('Patrícia Oliveira', 'patricia.oliveira@dominio.com', 2),
('Thiago Pereira', 'thiago.pereira@dominio.com', 3),
('Camila Costa', 'camila.costa@dominio.com', 1),
('Rodrigo Martins', 'rodrigo.martins@dominio.com', 2),
('Juliana Souza', 'juliana.souza@dominio.com', 3),
('Lucas Almeida', 'lucas.almeida@dominio.com', 1),
('Vanessa Ferreira', 'vanessa.ferreira@dominio.com', 2),
('Paulo Gonçalves', 'paulo.goncalves@dominio.com', 3),
('Carolina Vieira', 'carolina.vieira@dominio.com', 1),
('Diego Lima', 'diego.lima@dominio.com', 2),
('Isabela Santos', 'isabela.santos@dominio.com', 3),
('Leandro Oliveira', 'leandro.oliveira@dominio.com', 1),
('Beatriz Pereira', 'beatriz.pereira@dominio.com', 2),
('Luciana Costa', 'luciana.costa@dominio.com', 3),
('Mateus Martins', 'mateus.martins@dominio.com', 1),
('Amanda Souza', 'amanda.souza@dominio.com', 2),
('Marcelo Almeida', 'marcelo.almeida@dominio.com', 3),
('Gabriela Ferreira', 'gabriela.ferreira@dominio.com', 1),
('Fábio Gonçalves', 'fabio.goncalves@dominio.com', 2),
('Helena Vieira', 'helena.vieira@dominio.com', 3),
('Vinícius Lima', 'vinicius.lima@dominio.com', 1),
('Renata Santos', 'renata.santos@dominio.com', 2),
('Eduardo Oliveira', 'eduardo.oliveira@dominio.com', 3),
('Luiza Pereira', 'luiza.pereira@dominio.com', 1),
('Guilherme Costa', 'guilherme.costa@dominio.com', 2),
('Ana Paula Martins', 'ana.paula.martins@dominio.com', 3),
('Roberto Souza', 'roberto.souza@dominio.com', 1),
('Tatiane Almeida', 'tatiane.almeida@dominio.com', 2),
('Anderson Ferreira', 'anderson.ferreira@dominio.com', 3),
('Larissa Gonçalves', 'larissa.goncalves@dominio.com', 1),
('Ricardo Vieira', 'ricardo.vieira@dominio.com', 2),
('Jéssica Lima', 'jessica.lima@dominio.com', 3),
('Felipe Santos', 'felipe.santos@dominio.com', 1),
('Márcia Oliveira', 'marcia.oliveira@dominio.com', 2),
('Luciano Pereira', 'luciano.pereira@dominio.com', 3),
('André Costa', 'andre.costa@dominio.com', 1),
('Vivian Martins', 'vivian.martins@dominio.com', 2),
('Ronaldo Souza', 'ronaldo.souza@dominio.com', 3),
('Juliana Almeida', 'juliana.almeida@dominio.com', 1),
('Robson Ferreira', 'robson.ferreira@dominio.com', 2),
('Caroline Gonçalves', 'caroline.goncalves@dominio.com', 3),
('Marcela Vieira', 'marcela.vieira@dominio.com', 1),
('César Lima', 'cesar.lima@dominio.com', 2),
('Patrícia Santos', 'patricia.santos@dominio.com', 3),
('Alexandre Oliveira', 'alexandre.oliveira@dominio.com', 1),
('Débora Pereira', 'debora.pereira@dominio.com', 2),
('Sandra Costa', 'sandra.costa@dominio.com', 3),
('José Martins', 'jose.martins@dominio.com', 1),
('Elaine Souza', 'elaine.souza@dominio.com', 2),
('Rafaela Almeida', 'rafaela.almeida@dominio.com', 3),
('Cristiano Ferreira', 'cristiano.ferreira@dominio.com', 1),
('Isabela Gonçalves', 'isabela.goncalves@dominio.com', 2),
('Marcelo Vieira', 'marcelo.vieira@dominio.com', 3),
('Viviane Lima', 'viviane.lima@dominio.com', 1),
('Daniel Santos', 'daniel.santos@dominio.com', 2),
('Júlia Oliveira', 'julia.oliveira@dominio.com', 3),

INSERT INTO cursos (nome, descricao, area_id) VALUES
('Engenharia Civil', 'Curso de Engenharia Civil', 1),
('Medicina', 'Curso de Medicina', 2),
('Direito', 'Curso de Direito', 3),
('Administração', 'Curso de Administração', 4),
('Ciência da Computação', 'Curso de Ciência da Computação', 5),
('Psicologia', 'Curso de Psicologia', 6),
('Educação Física', 'Curso de Educação Física', 7),
('Arquitetura', 'Curso de Arquitetura', 8),
('Economia', 'Curso de Economia', 9),
('Enfermagem', 'Curso de Enfermagem', 10),
('Biologia', 'Curso de Biologia', 11),
('História', 'Curso de História', 12),
('Matemática', 'Curso de Matemática', 13),
('Física', 'Curso de Física', 14),
('Química', 'Curso de Química', 15),
('Letras', 'Curso de Letras', 16),
('Geografia', 'Curso de Geografia', 17),
('Design Gráfico', 'Curso de Design Gráfico', 18),
('Engenharia Elétrica', 'Curso de Engenharia Elétrica', 19),
('Jornalismo', 'Curso de Jornalismo', 20),
('Marketing', 'Curso de Marketing', 21),
('Farmácia', 'Curso de Farmácia', 22),
('Contabilidade', 'Curso de Contabilidade', 23),
('Nutrição', 'Curso de Nutrição', 24),
('Música', 'Curso de Música', 25);
