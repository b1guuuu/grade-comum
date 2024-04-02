CREATE TABLE IF NOT EXISTS disciplina(
    id SERIAL,
    nome TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS aluno (
    id SERIAL,
    nome TEXT NOT NULL,
    matricula VARCHAR(10) NOT NULL UNIQUE,
    senha TEXT NOT NULL,
    senhaSalt TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS professor(
    id SERIAL,
    nome TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS presenca(
    id SERIAL,
    presente BOOLEAN NOT NULL,
    observacao TEXT DEFAULT '',
    idProfessor INT NOT NULL,
    ultimaAtualizacao DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idProfessor) REFERENCES professor(id)
);

CREATE TABLE IF NOT EXISTS turma (
    id INT NOT NULL,
    codigo INT NOT NULL,
    numero INT NOT NULL,
    idDisciplina INT NOT NULL,
    idProfessor INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(id),
    FOREIGN KEY (idProfessor) REFERENCES professor(id)
);

CREATE TABLE IF NOT EXISTS horario (
    id INT NOT NULL,
    diaSemana VARCHAR(30) NOT NULL,
    inicio VARCHAR(5) NOT NULL,
    fim VARCHAR(5) NOT NULL,
    sala VARCHAR(5) NOT NULL,
    idTurma INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idTurma) REFERENCES turma(id)
);

CREATE TABLE IF NOT EXISTS inscricao (
    idTurma INT NOT NULL,
    idAluno INT NOT NULL,
    FOREIGN KEY (idTurma) REFERENCES turma(id),
    FOREIGN KEY (idAluno) REFERENCES aluno(id),
    PRIMARY KEY (idTurma, idAluno)
);

