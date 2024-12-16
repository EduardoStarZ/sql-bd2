-- a)

select dependente.nome, dependente.sexo, dependente.parentesco from dependente
join empregado on dependente.id_empregado = empregado.id
join trabalha_no on empregado.id = trabalha_no.empregado
join projeto on trabalha_no.projeto = projeto.id
where projeto.nome = "Aquarius";

-- projeto_selecionado <= α nome = "Aquarius" (projeto)
-- trabalha_aonde <= projeto_selecionado |X| id = projeto trabalha_no
-- empregados_aquarius <= trabalha_aonde |X| empregado = id empregado
-- dependentes_aquarius <= empregados_aquarius |X| id = id_empregado dependentes
-- π nome, sexo, parentesco (dependentes_aquarius) 



-- b)

select local_departamento from local
join departamento on departamento.id = local.departamento
join projeto on departamento.id = projeto.departamento
where projeto.nome = "Aquarius";

-- aquarius <= α nome = "Aquarius" (projeto)
-- departamento_aquarius <= aquarius |X| departamento = id departamento
-- local_aquarius <= departamento_aquarius |X| id = departamento local
-- π local_departamento (local_aquarius)



-- c)

select nome from empregado
join departamento on departamento.id = empregado.departamento
where departamento.nome = "financeiro";

-- financeiro <= α nome = "financeiro" (departamento)
-- supervis <= financeiro |X| id = departamento empregado
-- π nome (supervis)



-- d)

select nome, data_nascimento from empregado
join dependente on empregado.cpf = dependente.empregado
join trabalha_no on empregado.cpf = trabalha_no.empregado
where trabalha_no.horas > 40;

-- produtivos <= α  horas > 40 (trabalha_no)
-- nomes <= produtivos |X| empregados = cpf empregado
-- dependentes <= nomes |X| cpf = empregado dependente
-- π nome, data_nascimento (dependentes)



-- e)

select nome, gerente from departamento
join empregado on empregado.departamento = departamento.id
where avg(empregado.salario) > 10000;

-- ricos <= α  average(salario) > 1000 (empregado)
-- departamentos <= ricos |X| departamento = id departamento
-- π nome, gerente (departamento)


-- f)

select nome from projeto
join departamento on projeto.departamento = departamento.id
join local on departamento.id = local.departamento
where local.local_departamento is not projeto.local;

-- divergentes <= α  local is not (α  local_departamento (local)) (projeto)
-- localizações <= divergentes |X| departamento = id departamento
-- atribuições <= localizações |X| id = departamento projeto
-- π nome (atribuições)
