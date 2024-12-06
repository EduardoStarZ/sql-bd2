select nome from piloto
join pais on piloto.siglaPais = pais.siglaPais
where pais.nomePais = "Brasil";


-- brasil <= o' nomePais = "Brasil" (pais)
-- brasileiros <= brasil |X| siglaPais = siglaPais piloto
-- II nome (brasileiros)
