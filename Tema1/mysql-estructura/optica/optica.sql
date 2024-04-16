CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 ;

USE `optica` ;

CREATE TABLE IF NOT EXISTS client(
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
  nom VARCHAR(60) NOT NULL,
  adreça_postal VARCHAR(60) NULL DEFAULT NULL,
  telefon INT(11) NOT NULL,
  correu_electronic VARCHAR(60) NOT NULL,
  data_registre DATE NOT NULL,
  id_recomendador INT(11) UNSIGNED,
  FOREIGN KEY (id_recomendador) REFERENCES client(id)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE IF NOT EXISTS proveidor (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(60) NOT NULL,
  carrer VARCHAR(60) NOT NULL,
  numero INT(11) NOT NULL,
  pis INT(11) NULL DEFAULT NULL,
  porta INT(11) NULL DEFAULT NULL,
  ciutat VARCHAR(40) NOT NULL,
  codi_postal INT(11) NOT NULL,
  pais VARCHAR(30) NOT NULL,
  telefon INT(11) NOT NULL,
  fax INT(11) NOT NULL,
  NIF VARCHAR(9) UNIQUE
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE IF NOT EXISTS  ulleres (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  marca VARCHAR(45) NOT NULL,
  graduacio_Left INT(11) NOT NULL,
  graduacio_Right INT(11) NOT NULL,
  tipo_montura ENUM ('flotant', 'pasta', 'metàl·lica') NOT NULL,
  color VARCHAR(45) NOT NULL,
  color_vidre_Esq VARCHAR(45) NOT NULL,
  color_vidre_Dreta VARCHAR(45) NOT NULL,
  preu DECIMAL(6) NOT NULL,
  proveidor INT (11) UNSIGNED NOT NULL,
  FOREIGN KEY (proveidor) REFERENCES proveidor(id)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;



CREATE TABLE IF NOT EXISTS venedors (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR (45) NOT NULL
   )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS any_vendes (
  id INT(11)UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  any ENUM ('2022', '2023', '2024') NOT NULL
   )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS vendes (
  id_venta INT(11) UNSIGNED AUTO_INCREMENT ,
  id_client INT (11) UNSIGNED NOT NULL ,
  id_venedor INT(11) UNSIGNED NOT NULL ,
  id_ulleres INT(11) UNSIGNED NOT NULL ,
  id_periode INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (id_venta, id_client, id_venedor, id_ulleres, id_periode),
  FOREIGN KEY (id_venedor) REFERENCES venedors(id),
  FOREIGN KEY (id_ulleres) REFERENCES ulleres(id),
  FOREIGN KEY (id_client) REFERENCES client(id),
  FOREIGN KEY (id_periode) REFERENCES any_vendes(id)
 )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


INSERT INTO client (nom, adreça_postal, telefon, correu_electronic, data_registre, id_recomendador) VALUES 
('Juan Pérez', 'Calle Principal 123', 123456789, 'juan@example.com', '2023-05-15', NULL),
('María López', 'Avenida Central 456', 987654321, 'maria@example.com', '2024-02-10', 1),
('Pedro García', 'Plaza Mayor 789', 567890123, 'pedro@example.com', '2022-11-20', 2),
('Ana Martínez', 'Calle Secundaria 234', 234567890, 'ana@example.com', '2023-09-08', 3),
('Laura Sánchez', 'Paseo del Parque 567', 876543210, 'laura@example.com', '2024-01-30', 4);


INSERT INTO proveidor (nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, NIF) VALUES 
('OptiLens', 'Calle Mayor', 58, NULL, NULL, 'Barcelona', 08001, 'España', 912345678, 912345679, 'B2345678'),
('GafasPlus', 'Avenida Diagonal', 654, 1, 2, 'Madrid', 28002, 'España', 934567890, 934567891, 'C3456789'),
('LentesDirect', 'Calle Sevilla', 54, NULL, NULL, 'Valencia', 46001, 'España', 956789012, 956789013, 'D4567890'),
('VisionCare', 'Plaza España', 34, NULL, NULL, 'Sevilla', 41001, 'España', 978901234, 978901235, 'N5678901'),
('EyesFirst', 'Calle Gran Vía', 477, NULL, NULL, 'Bilbao', 48001, 'España', 990123456, 990123457, 'F6789012');

INSERT INTO ulleres (marca, graduacio_Left, graduacio_Right, tipo_montura, color, color_vidre_Esq, color_vidre_Dreta, preu, proveidor) VALUES 
('Ray-Ban', -2, -1.75, 'pasta', 'Negro', 'Transparente', 'Transparente', 150.00, 1),
('Oakley', -1.5, -1.25, 'metàl·lica', 'Gris', 'Gris', 'Gris', 200.00, 2),
('Prada', -3, -2.75, 'flotant', 'Marrón', 'Marrón', 'Marrón', 300.00, 3),
('Gucci', -2.25, -2, 'pasta', 'Azul', 'Azul', 'Azul', 250.00, 4),
('Dior', -1.75, -1.5, 'metàl·lica', 'Plata', 'Plata', 'Plata', 350.00, 5);

INSERT INTO venedors (nom) VALUES 
('Carlos'),
('Ana'),
('David'),
('Elena'),
('Javier');

INSERT INTO any_vendes (any) VALUES 
('2022'),
('2023'),
('2024');

INSERT INTO vendes (`id_client`, `id_venedor`, `id_ulleres`, `id_periode`) VALUES 
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 1),
(5, 5, 5, 2);

SELECT COUNT(id_venta) AS compras, nom FROM client INNER JOIN vendes ON vendes.id_client = client.id WHERE client.id=3 GROUP BY vendes.id_venta;
SELECT ulleres.marca, venedors.nom, any_vendes.any  FROM vendes INNER JOIN venedors ON venedors.id = vendes.id_venedor INNER JOIN ulleres ON ulleres.id = vendes.id_ulleres INNER JOIN any_vendes ON any_vendes.id = vendes.id_periode WHERE vendes.id_venedor=5;
SELECT DISTINCT proveidor.nom AS proveïdor FROM vendes INNER JOIN ulleres ON vendes.id_ulleres = ulleres.id INNER JOIN proveidor ON ulleres.proveidor = proveidor.id;