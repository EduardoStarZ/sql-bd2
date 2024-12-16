-- 1)

-- a)
select * from professor
where salario > (select * from professor
		where nm_professor = "Gustavo");

-- b)

select count(*) from reserva
group by cod_sala;

-- c)

select count(*) from equipamento
where tipo = "IMPRESSORA";

-- d)

select max(count(nome_curso)) from curso
join professor on professor.cod_curso = curso.cod_curso
where professor.sexo = "f"
group by curso.cod_curso;

-- e)


