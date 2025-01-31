-- a)

select * from reservas
join professor on professor.cod_professor = reserva.cod_profesor
where professor.nm_professor = "Gustavo";

-- b)

select * from reservas
join professor on professor.cod_professor = reserva.cod_professor
join curso on professor.cod_curso = curso.cod_curso
where curso.nome = "Pedagogia";

-- c)

select equipamento.nome, reserva.data, reserva.horario, reserva.local from equipamento, reserva
where equipamento.cod_equipamento = reserva.cod_equipamento;

-- d)

select * from reservas
join equipamento on reservas.cod_equipamento = equipamento.cod_equipamento
join sala on sala.cod_sala = reserva.cod_sala
join professor on professor.cod_professor = reserva.cod_professor
join curso on curso.cod_curso = professor.cod_curso
where nm_equipamento = "E01" and curso.nome_curso = "Pedagogia" and sala.nome_sala = "L30";

-- e)

select * from equipamentos
join reserva on reserva.cod_equipamento = equipamento.cod_equipamento
join professor on professor.cod_professor = reserva.cod_professor
join curso on curso.cod_curso = professor.cod_curso
where curso.nome_curso = "Pedagogia";


-- f)

select max(count(nome_curso)) from curso
join professor on professor.cod_curso = curso.cod_cursojoin reserva on reserva.cod_professor = professor.cod_professor
join equipamento on equipamento.cod_equipamento = reserva.cod_equipamento
where equipamento.nm_equipamento = "E01";

-- g)

select count(nm_professor) from professor
join curso on curso.cod_curso = professor.cod_curso
where professor.salario > 2500
group by professor.cod_curso;
