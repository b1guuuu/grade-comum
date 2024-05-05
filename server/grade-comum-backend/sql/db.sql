CREATE TABLE IF NOT EXISTS curso(
    id SERIAL,
    nome TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS disciplina(
    id SERIAL,
    nome TEXT NOT NULL,
    periodo INT NOT NULL,
    idCurso INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idCurso) REFERENCES curso(id)
);

CREATE TABLE IF NOT EXISTS requisito(
    idDisciplina INT NOT NULL,
    idDisciplinaRequisito INT NOT NULL,
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(id),
    FOREIGN KEY (idDisciplinaRequisito) REFERENCES disciplina(id),
    PRIMARY KEY (idDisciplina, idDisciplinaRequisito)
);

CREATE TABLE IF NOT EXISTS aluno (
    id SERIAL,
    nome TEXT NOT NULL,
    matricula VARCHAR(10) NOT NULL UNIQUE,
    senha TEXT NOT NULL,
    senhaSalt TEXT NOT NULL,
    idCurso INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idCurso) REFERENCES curso(id)
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
    ultimaAtualizacao DATE DEFAULT CURRENT_DATE,
    idProfessor INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idProfessor) REFERENCES professor(id)
);

CREATE TABLE IF NOT EXISTS turma (
    id SERIAL,
    codigo INT NOT NULL,
    numero INT NOT NULL,
    idDisciplina INT NOT NULL,
    idProfessor INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(id),
    FOREIGN KEY (idProfessor) REFERENCES professor(id)
);

CREATE TABLE IF NOT EXISTS horario (
    id SERIAL,
    diaSemana INT NOT NULL,
    inicio VARCHAR(5) NOT NULL,
    fim VARCHAR(5) NOT NULL,
    sala VARCHAR(5) NOT NULL,
    ordem INT NOT NULL,
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

CREATE TABLE IF NOT EXISTS anotacao(
    id SERIAL,
    conteudo TEXT NOT NULL,
    dataCalendario DATE,
    tituloCalendario TEXT,
    idAluno INT NOT NULL,
    idDisciplina INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idAluno) REFERENCES aluno(id),
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(id)
);

CREATE TABLE IF NOT EXISTS progresso (
    idDisciplina INT NOT NULL,
    idAluno INT NOT NULL,
    tentativas INT DEFAULT 1,
    concluido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(id),
    FOREIGN KEY (idAluno) REFERENCES aluno(id),
    PRIMARY KEY (idDisciplina, idAluno)
);