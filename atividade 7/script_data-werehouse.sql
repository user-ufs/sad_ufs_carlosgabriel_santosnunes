-- DROP TABLE IF EXISTS dim_aluno;
-- DROP TABLE IF EXISTS dim_disciplina;
-- DROP TABLE IF EXISTS dim_tempo;
-- DROP TABLE IF EXISTS dim_curso;
-- DROP TABLE IF EXISTS fato_aulas;


CREATE TABLE dim_aluno(
	id_aluno SERIAL NOT NULL,
	nome VARCHAR(20),
	idade INTEGER,
	CONSTRAINT PK_ID_ALUNO PRIMARY KEY(id_aluno)
);

CREATE TABLE dim_disciplina(
	id_disciplina SERIAL NOT NULL,
	descricao VARCHAR(50) UNIQUE,
	CONSTRAINT PK_ID_DISCIPLINA PRIMARY KEY(id_disciplina)
);

CREATE TABLE dim_tempo(
	id_tempo SERIAL NOT NULL,
	semestre VARCHAR(5) NOT NULL,
	ano VARCHAR(5) NOT NULL,
	CONSTRAINT PK_ID_TEMPO PRIMARY KEY(id_tempo)
);

CREATE TABLE dim_curso(
	id_curso SERIAL NOT NULL,
	descricao VARCHAR(20),
	CONSTRAINT PK_ID_CURSO PRIMARY KEY(id_curso)
);

CREATE TABLE fato_aulas(
	id_tempo INT,
	id_aluno INT,
	id_disciplina INT,
	id_curso INT,
	quant_aprovados INT,
	quant_reprovados INT,
	quant_alunos_curso INT,
	quant_disc_cruso INT,
	CONSTRAINT FK_ID_TEMPO FOREIGN KEY(id_tempo) REFERENCES dim_tempo(id_tempo),
	CONSTRAINT FK_ID_ALUNO FOREIGN KEY(id_aluno) REFERENCES dim_aluno(id_aluno),
	CONSTRAINT FK_ID_DISCIPLINA FOREIGN KEY(id_disciplina) REFERENCES dim_disciplina(id_disciplina),
	CONSTRAINT FK_ID_CURSO FOREIGN KEY(id_curso) REFERENCES dim_curso(id_curso)
);