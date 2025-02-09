-- Questão A)

CREATE TRIGGER checar_dependentes
BEFORE INSERT ON dependentes
FOR EACH ROW
BEGIN
		DECLARE empregado_selecionado;
		SELECT COUNT(*) INTO empregado_selecionado FROM empregado
		WHERE empregado.id = NEW.emp;

		IF empregado_selecionado < 3 THEN
				INSERT INTO dependentes (emp, nomedepend, sexo, nasc, parentesco)
				VALUES (NEW.emp, NEW.nomedepend, NEW.sexo, NEW.nasc, NEW.parentesco);

		ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = "É proíbida a inserção de mais de 3 dependentes.";
		END IF;
END;




-- Questão B)

CREATE TRIGGER checar_num_empregados
BEFORE INSERT ON empregado
FOR EACH ROW
BEGIN 
		DECLARE num_empregados;
		
		SELECT COUNT(*) INTO num_empregados from empregado
		WHERE 
				(SELECT COUNT(*) FROM empregado
				WHERE dept != NEW.dept
				GROUP BY numdept) / 3 >= (
				SELECT COUNT(*) FROM empregado 
				WHERE dept = NEW.dept);

		IF num_empregados = 0 THEN
				INSERT INTO empregado (enome, cpf, nasc, endereco, sexo, salario, superv, dept)
				VALUES (NEW.enome, NEW.cpf, NEW.nasc, NEW.endereco, NEW.sexo, NEW.salario, NEW.superv, NEW.dept);
		ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT "O número de funcionários nesse departamento é 3x maior do que os outros."
		END IF;
END;




-- Questão C)

CREATE FUNCTION signo(fn_cpf CHAR(11), fn_nasc DATE)
RETURNS TEXT
BEGIN
		DECLARE var_nasc;
		DECLARE var_signo;

		SELECT nasc INTO var_nasc FROM empregado
		WHERE nasc = fn_nasc AND cpf = fn_cpf;

		-- Para simplificar a checagem de signos, vamos dizer que cada periodo de um mês é um signo.
		-- Janeiro = Áries, ...

		CASE
				WHEN var_nasc LIKE '____-01-__' THEN SET var_signo = 'Áries' 
				WHEN var_nasc LIKE '____-02-__' THEN SET var_signo = 'Touro'
				WHEN var_nasc LIKE '____-03-__' THEN SET var_signo = 'Gêmeos'
				WHEN var_nasc LIKE '____-04-__' THEN SET var_signo = 'Câncer'
				WHEN var_nasc LIKE '____-05-__' THEN SET var_signo = 'Leão'
				WHEN var_nasc LIKE '____-06-__' THEN SET var_signo = 'Virgem'
				WHEN var_nasc LIKE '____-07-__' THEN SET var_signo = 'Libra'
				WHEN var_nasc LIKE '____-08-__' THEN SET var_signo = 'Escorpião'
				WHEN var_nasc LIKE '____-09-__' THEN SET var_signo = 'Sagitário'
				WHEN var_nasc LIKE '____-10-__' THEN SET var_signo = 'Capricórnio'
				WHEN var_nasc LIKE '____-11-__' THEN SET var_signo = 'Aquário'
				WHEN var_nasc LIKE '____-12-__' THEN SET var_signo = 'Peixes'
				ELSE 
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT = "Valor de data inválido."
		END CASE;

		RETURN var_signo;
END;
		
		



-- Questão D)

CREATE FUNCTION signo(fn_data DATE) 
RETURNS TEXT 
BEGIN
		CASE
				WHEN var_nasc LIKE '____-01-__' THEN SET RETURN 'Áries' 
				WHEN var_nasc LIKE '____-02-__' THEN SET RETURN 'Touro'
				WHEN var_nasc LIKE '____-03-__' THEN SET RETURN 'Gêmeos'
				WHEN var_nasc LIKE '____-04-__' THEN SET RETURN 'Câncer'
				WHEN var_nasc LIKE '____-05-__' THEN SET RETURN 'Leão'
				WHEN var_nasc LIKE '____-06-__' THEN SET RETURN 'Virgem'
				WHEN var_nasc LIKE '____-07-__' THEN SET RETURN 'Libra'
				WHEN var_nasc LIKE '____-08-__' THEN SET RETURN 'Escorpião'
				WHEN var_nasc LIKE '____-09-__' THEN SET RETURN 'Sagitário'
				WHEN var_nasc LIKE '____-10-__' THEN SET RETURN 'Capricórnio'
				WHEN var_nasc LIKE '____-11-__' THEN SET RETURN 'Aquário'
				WHEN var_nasc LIKE '____-12-__' THEN SET RETURN 'Peixes'
				ELSE 
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT = "Valor de data inválido."
END CASE;


CREATE PROCEDURE checar_signo() 
BEGIN 
		SELECT empregado.enome, dependente.nomedepend FROM empregado, dependente
		WHERE empregado.cpf = dependente.emp AND signo(empregado.nasc) = signo(dependente.nasc);
END;





-- Questão E)



-- Questão F)

CREATE FUNCTION get_func_mes(fn_mes INT)
RETURNS TEXT
BEGIN
		DECLARE empregados_selecionados;

		SELECT nome INTO empregados_selecionados FROM empregado
		WHERE date_sub(CURRENT_DATE(), INTERVAL YEAR(empregado.nasc) YEAR) >= 65 AND fn_mes = MONTH(empregado.nasc);

		RETURN empregados_selecionados;
END;



-- Questão G)

CREATE TABLE empregado_historico (
		enome CHAR(200) NOT NULL,
		cpf CHAR(11) PRIMARY KEY,
		nasc DATE NOT NULL,
		endereco char(400) NOT NULL,
		sexo char(1) NOT NULL,
		salario INT NOT NULL,
		superv CHAR(11),
		dept INT,
		FOREIGN KEY dept REFERENCES departamento(dnum),
		FOREIGN KEY superv REFERENCES empregado(cpf)
);

CREATE TRIGGER arquivar_empregado
BEFORE DELETE ON empregado
FOR EACH ROW
BEGIN
		INSERT INTO empregado_historico (enome, cpf, nasc, endereco, sexo, salario, superv, dept)
		VALUES (
				SELECT enome, cpf, nasc, endereco, sexo, salario, superv, dept FROM empregado
				WHERE cpf = OLD.cpf
		);
END;




-- Questão H)

CREATE PROCEDURE alocar_proj_dept(proc_projeto INT, proc_departamento INT)
BEGIN
		UPDATE projeto
		SET numdept = proc_departamento
		WHERE projeto.pnum = proc_projeto;

END;
