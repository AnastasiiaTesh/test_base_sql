CREATE DATABASE `test`;

CREATE TABLE test.product (
  `maker` varchar(255) DEFAULT NULL,
  `model` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL);

INSERT INTO test.product (`maker`, `model`, `type`) VALUES
('A', 1232, 'PC'),
('A', 1233, 'PC'),
('A', 1276, 'Printer'),
('A', 1298, 'Laptop'),
('A', 1401, 'Printer'),
('A', 1408, 'Printer'),
('A', 1752, 'Laptop'),
('B', 1121, 'PC'),
('B', 1750, 'Laptop'),
('C', 1321, 'Laptop'),
('D', 1288, 'Printer'),
('D', 1433, 'Printer'),
('E', 1260, 'PC'),
('E', 1434, 'Printer'),
('E', 2112, 'PC'),
('E', 2113, 'PC');

CREATE TABLE test.pc (
  `code` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  `ram` int(11) NOT NULL,
  `hd` int(11) NOT NULL,
  `cd` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL);

INSERT INTO test.pc (`code`, `model`, `speed`, `ram`, `hd`, `cd`, `price`) VALUES
(1, 1232, 500, 64, 5, '12x', 600),
(2, 1121, 750, 128, 14, '40x', 850),
(3, 1233, 500, 64, 5, '12x', 600),
(4, 1121, 600, 128, 14, '40x', 850),
(5, 1121, 600, 128, 8, '40x', 850),
(6, 1233, 750, 128, 20, '50x', 950),
(7, 1232, 500, 32, 10, '12x', 400),
(8, 1232, 450, 64, 8, '24x', 350),
(9, 1232, 450, 32, 10, '24x', 350),
(10, 1260, 500, 32, 10, '12x', 350),
(11, 1233, 900, 128, 40, '40x', 980),
(12, 1233, 800, 128, 20, '50x', 970);

CREATE TABLE test.laptop (
  `code` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  `ram` int(11) NOT NULL,
  `hd` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `screen` int(11) NOT NULL);

INSERT INTO test.laptop (`code`, `model`, `speed`, `ram`, `hd`, `price`, `screen`) VALUES
(1, 1298, 350, 32, 4, 700, 11),
(2, 1321, 500, 64, 8, 970, 12),
(3, 1750, 750, 128, 12, 1200, 14),
(4, 1298, 600, 64, 10, 1050, 15),
(5, 1752, 750, 128, 10, 1150, 14),
(6, 1298, 450, 64, 10, 950, 12);

CREATE TABLE test.printer (
  `code` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL);

INSERT INTO test.printer (`code`, `model`, `color`, `type`, `price`) VALUES
(1, 1276, 'n', 'Laser', 400),
(2, 1433, 'y', 'Jet', 270),
(3, 1434, 'y', 'Jet', 290),
(4, 1401, 'n', 'Matrix', 150),
(5, 1408, 'n', 'Matrix', 270),
(6, 1288, 'n', 'Laser', 400);

ALTER TABLE test.product
	ADD primary key (`model`);

ALTER TABLE test.pc
	ADD primary key (`code`);

ALTER TABLE test.printer
	ADD primary key (`code`);

ALTER TABLE test.laptop
	ADD primary key (`code`);

ALTER TABLE test.pc
	add foreign key (`model`)
		references sber.product (`model`);
        
ALTER TABLE test.printer
	add foreign key (`model`)
		references sber.product (`model`);
        
ALTER TABLE test.laptop
	add foreign key (`model`)
		references sber.product (`model`);
        
select * FROM test.product;
select * FROM test.pc;
select * FROM test.laptop;
select * FROM test.printer;

#1. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
SELECT test.product.model, test.laptop.price
FROM test.product
JOIN test.laptop ON laptop.model = product.model
WHERE product.maker = 'B'
UNION
SELECT test.product.model, test.pc.price
FROM test.product
JOIN test.pc ON pc.model = product.model
WHERE product.maker = 'B'
UNION
SELECT test.product.model, test.printer.price
FROM test.product
JOIN test.printer ON printer.model = product.model
WHERE product.maker = 'B';

#2. Найти производителей, которые выпускают только принтеры или только PC.
# При этом искомые производители PC должны выпускать не менее 3 моделей.

SELECT test.product.maker
FROM test.product
GROUP BY test.product.maker
HAVING COUNT(DISTINCT test.product.`type`) = 1 AND
       (MIN(test.product.`type`) = 'printer' OR
       (MIN(test.product.`type`) = 'PC' AND count(test.product.model) > 2));
      
   
#3. Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
SELECT test.product.maker, test.printer.price
FROM test.product
JOIN test.printer ON printer.model = product.model
WHERE test.printer.color = 'y'
ORDER BY test.printer.price;
        

