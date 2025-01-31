-- 1)
INSERT INTO empregado VALUES 
("Bruno", "2222");

-- 2)

INSERT INTO dependente VALUES
("2222", "1111");

-- 3)

INSERT INTO projeto VALUES
("Educacional", 1, NULL, 3);

-- 4)

UPDATE trabalha_no
SET proj = 2
WHERE emp = "56789";

-- 5)

UPDATE empregado
SET salario = (salario * 2)
WHERE cpf = "1111";

-- 6)

UPDATE empregado
SET superv = (
		SELECT gerente FROM departamento
		WHERE dnum = 2;
)
WHERE cpf = "56789";

-- 7)

UPDATE projeto
SET numdept = 1
WHERE pnum = 3;

-- 8)

DELETE FROM empregado
WHERE cpf = "56788";

-- 9)

DELETE FROM dependente
WHERE parentesco = "sobrinho" AND empregado.cpf = "12345";

-- 10)

SELECT nome, salario FROM empregados;

-- 11)

SELECT * FROM dependentes
WHERE sexo = "m";

-- 12)

SELECT nome, plocal FROM projeto;

-- 13)

SELECT * FROM empregados
WHERE departamentos.dnum = dept AND salario > 5000.0;

-- 14)

SELECT nome FROM empregados
WHERE salario > 5000 AND superv = (
		select * from empregados
		WHERE cpf = superv;
);

-- 15)

SELECT * from empregados
WHERE salario = 5000 AND cpf = superv
UNION
SELECT nome, salario FROM empregados
WHERE salario > (
		SELECT salario from EMPREGADOS
		WHERE superv = cpf;
);

-- 16) Não existe no arquivo, erro de digitação

-- 17)

SELECT nome FROM empregado
WHERE departamento.gerente = cpf;

-- 18)

SELECT pnome FROM projeto
WHERE empregado.CPF = (
		SELECT * FROM trabalha_no
		WHERE emp = (
				SELECT * FROM empregado
				WHERE nome = "Joao Silva";
		)
);

-- 19)

SELECT nome FROM empregado
LEFT JOIN trabalha_no ON trabalha_no.emp = empregado.cpf
WHERE TRABALHA_NO.EMP IS NULL;

-- 20)

SELECT nome FROM empregado
LEFT JOIN trabalha_no ON trabalha_no.emp = empregado.cpf
WHERE TRABALHA_NO.EMP IS NOT NULL;

-- 21)

SELECT nome FROM empregado
WHERE (
		SELECT COUNT(*) FROM projeto;
) = (
		SELECT count(*) FROM trabalha_no
		WHERE emp = empregado.cpf AND pnum = projeto.pnum;
);

-- 22)

SELECT nome, salario FROM empregados
WHERE cpf IS NOT superv
UNION
SELECT empregados.nome, empregados.salario, departamento.dnome FROM empregados, departamento
WHERE empregados.cpf = departamento.gerente;

-- 23)

SELECT nome FROM empregados
WHERE departamento.dnome = "TRANSPORTE"
ORDER BY salario DESC;

-- 24)

SELECT AVG(salario) from empregados;

-- 25)

SELECT empregado.nome, COUNT(trabalha_no.proj), trabalha_no.horas from empregados, trabalha_no;

-- 26)

SELECT count(nome) FROM empregado
LEFT JOIN trabalha_no ON trabalha_no.emp = empregado.cpf
WHERE TRABALHA_NO.EMP IS NOT NULL;

-- 27)

SELECT pnum, COUNT(PNUM), SUM(horas) FROM trabalha_no;

-- 28)

SELECT AVG(horas) FROM trabalha_no
WHERE proj = projeto.pnum
GROUP BY emp
HAVING COUNT(*) > 2;

-- 29)

SELECT * FROM trabalha_no
GROUP BY pnum
HAVING COUNT(*) > AVG(EMP);

-- 30)

UPDATE departamento
SET dlocal = "Caribe"
WHERE name = "D5";

-- 31)

SELECT * FROM empregados
WHERE salario > SUM((
		SELECT emp FROM trabalha_no
		WHERE projeto.name = "ALGORITMOS" AND proj = projeto.dnum;
));

-- 32)

SELECT * FROM empregados
WHERE salario > (
		SELECT emp FROM trabalha_no
		WHERE projeto.nome = "CONSTRUCOES" AND proj = projeto.dnum;
);

-- 33)

SELECT * FROM empregados
WHERE salario > (
		SELECT salario from empregados
		WHERE cpf = "1111";
);

-- 34)

SELECT * FROM empregados
GROUP BY dept;

-- 35)

SELECT * FROM dependentes
WHERE PARENTESCO IN ("FILHO", "FILHA");

-- 36)

SELECT cpf, nome, count(nomedepend) FROM empregados, dependentes
GROUP BY nomedepend 
HAVING COUNT(*) >= COUNT((
		SELECT * FROM empregados
		INNER JOIN dependentes ON empregados.cpf = dependentes.emp;
));

-- 37)

SELECT nome, count(nomedepend) FROM empregados, dependentes
GROUP BY nomedepend 
HAVING COUNT(*) >= COUNT((
		SELECT * FROM empregados
		INNER JOIN dependentes ON empregados.cpf = dependentes.emp;
));

-- 38)

SELECT empregado.nome, projeto.pnome, trabalha_no.horas FROM empregado, projeto, trabalha_no
WHERE trabalha_no.emp = empregado.nome AND trabalha_no.proj = projeto.dnum;
