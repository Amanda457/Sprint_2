CREATE SCHEMA IF NOT EXISTS `ex_2_pizzeria` DEFAULT CHARACTER SET utf8mb4 ;
USE `ex_2_pizzeria` ;

CREATE TABLE IF NOT EXISTS client (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
  nom VARCHAR(60) NOT NULL,
  cognoms VARCHAR(60) NOT NULL,
  adreça VARCHAR(60) NULL DEFAULT NULL,
  codi_postal INT(5) NOT NULL,
  localitat VARCHAR(30) NOT NULL,
  provincia VARCHAR(30) NOT NULL,
  telèfon INT(12) NOT NULL
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;



CREATE TABLE IF NOT EXISTS botiga (
id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY , 
adreça VARCHAR(45) NOT NULL, 
localitat VARCHAR(35) NOT NULL,
provincia VARCHAR(35) NOT NULL,
codi_postal INT(5) NOT NULL 
) 
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE IF NOT EXISTS categoria (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
  nom VARCHAR(45) NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE IF NOT EXISTS productes (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
  tipo ENUM ('pizza', 'hamburguesa', 'beguda'),
  nom VARCHAR(45) NOT NULL,
  descripció TEXT NOT NULL,
  imatge BLOB NULL DEFAULT NULL,
  preu DECIMAL(4,2) NOT NULL,
  categoria INT (11) UNSIGNED NULL DEFAULT NULL,
  FOREIGN KEY (categoria) REFERENCES categoria(id)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS comanda (
   id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
   data_hora DATETIME NOT NULL,
   modalitat ENUM ('repartiment a domicili', 'recollida a botiga') NOT NULL,
   preu_total DECIMAL(4,2) NOT NULL,
   id_client INT (11) UNSIGNED NOT NULL,
   id_botiga INT (11) UNSIGNED NOT NULL,
   FOREIGN KEY (id_client) REFERENCES client(id),
   FOREIGN KEY (id_botiga) REFERENCES botiga(id)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS empleat (
 id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY , 
 nom VARCHAR(60) NOT NULL,
 cognoms VARCHAR(60) NOT NULL, 
 NIF VARCHAR(9) UNIQUE NOT NULL,
 telefon INT(11) NOT NULL,
 lloc_de_feina ENUM ('cuiner/a', 'repartidor/a'),
 botiga INT (11) UNSIGNED NULL DEFAULT NULL,
FOREIGN KEY (botiga) REFERENCES botiga(id)
) 
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE IF NOT EXISTS repartiment_domicili (
lliurament DATETIME NOT NULL , 
id_comanda INT (11) UNSIGNED NOT NULL PRIMARY KEY,
id_repartidor INT (11) UNSIGNED NULL DEFAULT NULL,
FOREIGN KEY (id_comanda) REFERENCES comanda(id),
FOREIGN KEY (id_repartidor) REFERENCES empleat(id)
) 
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS comanda_has_productes (
  id INT(11) NOT NULL,
  comanda_id INT(11) UNSIGNED NOT NULL,
  productes_id INT(11) UNSIGNED NOT NULL,
  quantity INT (3) NOT NULL, 
  PRIMARY KEY (id, comanda_id, productes_id),
  FOREIGN KEY (productes_id) REFERENCES productes (id),
  FOREIGN KEY (comanda_id) REFERENCES comanda (id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


INSERT INTO client (nom, cognoms, adreça, codi_postal, localitat, provincia, telèfon) VALUES
('Pedro', 'Martínez Ruiz', 'Calle Gran Vía 456', 08002, 'Barcelona', 'Barcelona', 34934567890),
('Sergio', 'González Martínez', 'Carrer Major 10', 43830, 'Torredembarra', 'Tarragona', 34987654321),
('David', 'Rodríguez Pérez', 'Calle Sevilla 101', 41001, 'Sant Cugat del Vallès', 'Barcelona', 34956789012),
('Laura', 'Sánchez Martínez', 'Paseo del Parque 202', 29001, 'Molins de Rei', 'Barcelona', 34978901234),
('Javier', 'Gómez Rodríguez', 'Calle Mayor 303', 28002, 'Girona', 'Girona', 34990123456),
('Carmen', 'López Martínez', 'Avenida Libertad 404', 46001, 'Tarragona', 'Tarragona', 34901234567),
('Daniel', 'Pérez Sánchez', 'Plaza España 505', 50001, 'Tiana', 'Barcelona', 34912345678),
('Elena', 'Martín Gómez', 'Calle Alcalá 606', 28003, 'Barcelona', 'Barcelona', 34934567890);

INSERT INTO botiga (adreça, localitat, provincia, codi_postal) VALUES
('Carrer Gran de Gràcia 123', 'Barcelona', 'Barcelona', 08012),
('Avinguda Diagonal 456', 'Barcelona', 'Barcelona', 08034),
('Carrer Major 789', 'Girona', 'Girona', 17001),
('Plaça del Rei 1011', 'Tarragona', 'Tarragona', 43001),
('Carrer Sant Magí 1213', 'Tarragona', 'Tarragona', 43002);

INSERT INTO categoria (nom) VALUES
('Sin lactosa'),
('Veggie'),
('Sin gluten');

INSERT INTO productes (tipo, nom, descripció, imatge, preu, categoria) VALUES
('pizza', 'Carbonara', 'Massa fina amb ceps, bacó, nata i un punt trufat','imatge_01.jpg', 9.60, 3),
('pizza', 'Carnica', 'Massa gruixuda amb carn picada TEXMEX','imatge_02.jpg', 12.00, 1),
('pizza', '4 estacions verdes', 'Massa normal amb surtit de pebrots escalivats, ceba caramel·litzada, xampinyons i no-queso','imatge_03.jpg', 11.50, 2),
('hamburguesa', 'Clàssica', '200gr de vedella amb ou, bacó i formatge fos','imatge_04.jpg', 8.40, NULL),
('hamburguesa', 'Noruega', 'Filet de salmó amb anet i formatge suís','imatge_05.jpg', 9.50, NULL),
('hamburguesa', 'TodoAlPollo', 'Filets crunchy de pollaste de corral amb ceba caramel·litzada i medalló de formatge de cabra ','imatge_06.jpg', 8.90, NULL),
('beguda', 'Coca-cola', 'Beguda amb cafeina refrescant de 2L','imatge_07.jpg',2.50, NULL),
('beguda', 'Aigua', 'Aigua envasada, 1.5L','imatge_08.jpg',2.00, NULL),
('beguda', 'Estrella Damm', 'Beguda alcohòlica, llauna de 33cl','imatge_09.jpg',2.20, NULL);

INSERT INTO comanda (data_hora, modalitat, id_producte, quantitat, preu_total, id_client, id_botiga)
VALUES 
('2024-04-16 10:00:00', 'recollida a botiga', 2, 2, 24.00, 3, 1),
('2024-04-16 11:30:00', 'repartiment a domicili', 4, 4, 33.60, 3, 1),
('2024-04-16 12:45:00', 'repartiment a domicili', 9, 3, 6.60, 1, 1),
('2024-04-16 13:15:00', 'recollida a botiga', 5, 5, 47.50, 1, 2),
('2024-04-16 14:30:00', 'repartiment a domicili', 5, 2, 19.00, 5, 2),
('2024-04-16 15:45:00', 'recollida a botiga', 1, 2, 19.20, 6, 3),
('2024-04-16 16:20:00', 'repartiment a domicili', 7, 1, 2.50, 8, 4),
('2024-04-16 17:00:00', 'recollida a botiga', 6, 3, 26.70, 7, 4),
('2024-04-16 18:10:00', 'repartiment a domicili', 2, 2, 24.00, 2, 5),
('2024-04-16 19:30:00', 'repartiment a domicili', 6, 1, 8.90, 3, 2);

INSERT INTO empleat (nom, cognoms, NIF, telefon, lloc_de_feina, botiga)
VALUES 
('Carlos', 'García Pérez', '12345678E', 666112233, 'cuiner/a', 5),
('Laura', 'Martínez López', '98765432R', 677223344, 'repartidor/a', 1),
('Juan', 'Sánchez Rodríguez', '13579246H', 688334455, 'cuiner/a', 2),
('María', 'González Fernández', '24681357V', 699445566, 'repartidor/a', 3),
('Ana', 'Díaz García', '36925814G', 611556677, 'cuiner/a', 5),
('Pedro', 'Ruiz Martínez', '97531864A', 622667788, 'repartidor/a', 5),
('Sara', 'López Sánchez', '86429753A', 633778899, 'cuiner/a', 4),
('Lucía', 'Hernández Gómez', '75395182D', 644889900, 'repartidor/a', 1),
('Pablo', 'Fernández Pérez', '58246913P', 655990011, 'repartidor/a', 2),
('Elena', 'García Rodríguez', '49682375R', 666001122, 'repartidor/a', 3),
('Diego', 'Martín López', '31824759E', 677112233, 'repartidor/a', 4),
('Marina', 'Sánchez Martínez', '62413579R', 688223344, 'repartidor/a', 5);

INSERT INTO repartiment_domicili (lliurament, id_comanda, id_repartidor) VALUES 
('2024-04-16 10:25:00', 1, 2),
('2024-04-16 12:10:00', 2, 8),
('2024-04-16 13:25:00', 3, 2),
('2024-04-16 13:55:00', 4, 9),
('2024-04-16 15:20:00', 5, 9),
('2024-04-16 16:25:00', 6, 11),
('2024-04-16 17:02:00', 7, 11),
('2024-04-16 17:29:00', 8, 11),
('2024-04-16 18:48:00', 9, 6),
('2024-04-16 19:58:00', 10, 9);

-- Consultes de control:

SELECT productes.nom, botiga.localitat, SUM(comanda.quantitat) AS quantitat FROM productes INNER JOIN comanda ON productes.id = comanda.id_producte INNER JOIN botigA ON comanda.id_botiga = botiga.id WHERE  productes.tipo = 'beguda' AND botiga.localitat = 'Barcelona' GROUP BY localitat;
SELECT empleat.nom, COUNT(repartiment_domicili.id_comanda) FROM empleat INNER JOIN repartiment_domicili ON repartiment_domicili.id_repartidor = empleat.id WHERE empleat.id = 9 GROUP BY empleat.nom;