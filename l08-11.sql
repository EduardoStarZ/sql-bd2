-- Notar que o código escrito foi feito para rodar em SQLite, portanto 
-- alguns trechos de código não serão semelhantes ao MySQL

--1)

CREATE TABLE mercadoria (
		`cod_mer` INT4 NOT NULL PRIMARY KEY,
		`preco` FLOAT NOT NULL,
		`imcs` FLOAT NOT NULL 
);

CREATE TABLE cliente_rel (
		`cod_cli` INT4 NOT NULL PRIMARY KEY,
		`nome` VARCHAR(100) NOT NULL,
		`rua` VARCHAR(100) NOT NULL,
		`cidade` VARCHAR(100) NOT NULL,
		`estado` CHAR(2) NOT NULL,
		`cep` CHAR(10) NOT NULL,
		`FONE1` VARCHAR(20),
		`FONE2` VARCHAR(20),
		`FONE3` VARCHAR(20),
);

CREATE TABLE cliente_especial_rel (
		`cod_cli` INT4 PRIMARY KEY,
		`desconto_padrao` FLOAT NOT NULL,
		FOREIGN KEY (cod_cli) REFERENCES cliente_rel(cod_cli)
);

CREATE TABLE cliente_vip_rel (
		`cod_cli` INT4 PRIMARY KEY,
		`desconto_padrao` FLOAT NOT NULL,
		`pontos_bonificacao` INT4 NOT NULL,
		FOREIGN KEY (cod_cli) REFERENCES cliente_rel(cod_cli)
);

CREATE TABLE pedido_rel (
		`codped` INT4 PRIMARY KEY,
		`data_pedido` DATETIME NOT NULL,
		`rua` VARCHAR(100) NOT NULL,
		`cidade` VARCHAR(100) NOT NULL,
		`estado` CHAR(2) NOT NULL,
		`cep` CHAR(10) NOT NULL,
		`cod_cli` INT4 NOT NULL,
		FOREIGN KEY (rua) REFERENCES cliente_rel(rua),
		FOREIGN KEY (cidade) REFERENCES cliente_rel(cidade),
		FOREIGN KEY (estado) REFERENCES cliente_rel(estado),
		FOREIGN KEY (cep) REFERENCES cliente_rel(cep),
		FOREIGN KEY (cod_cli) REFERENCES cliente_rel(cod_cli),
);

CREATE TABLE item_pedido_rel (
		`codped` INT4 NOT NULL,
		`cod_cli` INT4 NOT NULL,
		PRIMARY KEY(codped, cod_cli),
		`quantidade` INT4 NOT NULL,
		`desconto` FLOAT NOT NULL,
		`codmer` INT4 NOT NULL,
		FOREIGN KEY (codped) REFERENCES pedido_rel(codped),
		FOREIGN KEY (cod_cli) REFERENCES cliente_rel(cod_cli),
		FOREIGN KEY (codmer) REFERENCES mercadoria(codmer)
);


-- 2)

-- A) 

INSERT INTO TABLE cliente_rel values 
(0, "João", "Rua dos matos altos", "Sobradinho", "DF", "1234567890", "33345678"),
(1, "Mateus", "Rua do sorvete", "Brazlândia", "DF", "0987654321", "22349987"),
(2, "Aline", "Rua do pixe", "Vicente Pires", "DF", "7893458531", "99986754"),
(3, "Gabriela", "Rua dos girassóis", "São Sebastião", "DF", "0986731245"),
(4, "Louie", "Rua das constâncias", "Paranoá", "DF", "7584638920");

-- B)

INSERT INTO TABLE cliente_especial_rel values (0, 34.5);
INSERT INTO TABLE cliente_vip_rel VALUES (3, 50.5, 75);

-- C)

INSERT INTO TABLE mercadoria values (0, 30.0, 34.253);
INSERT INTO TABLE mercadoria values (1, 40.30, 9.3874);
INSERT INTO TABLE mercadoria values (2, 12.75, 98.723);
INSERT INTO TABLE mercadoria values (3, 200.50, 23.874);
INSERT INTO TABLE mercadoria values (4, 12.00, 12.356);
INSERT INTO TABLE mercadoria values (5, 0.99, 07.809);
INSERT INTO TABLE mercadoria values (6, 30.54, 9.8754);
INSERT INTO TABLE mercadoria values (7, 40.00, 9.8743);
INSERT INTO TABLE mercadoria values (8, 30.00, 9.8732);
INSERT INTO TABLE mercadoria values (9, 23.00, 1.5489);

-- D)


