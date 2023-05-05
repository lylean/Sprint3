-- Deben crear un usuario con privilegios para crear, eliminar y modificar tablas, insertar registros.
create database telovendosprint;
create user 'sprint'@'localhost'identified by 'Lloveless9';
grant all privileges on telovendosprint.* to 'sprint'@'localhost' with grant option;
flush privileges;


-- se crean tablas solicitadas junto a sus datos :

create table categoria(
id_categoria int auto_increment not null primary key,
nombre varchar(100) not null
);

insert into categoria (nombre)
values
('Televisores'),
('Computadoras'),
('Celulares'),
('Cámaras'),
('Audífonos'),
('Tablets'),
('Consolas de videojuegos'),
('Altavoces'),
('Reproductores de música'),
('Accesorios electrónicos');

create table provedores(
id_provedores int auto_increment not null primary key,
nombre_representante varchar(100) not null,
nombre_corporativo varchar(100) not null,
telefono1 varchar(100) not null,
telefono2 varchar(100) not null,
secretaria varchar(100) not null,
categoria int not null ,
correo varchar(100) not null,
foreign key (categoria) references categoria (id_categoria)
);

insert into provedores(nombre_representante, nombre_corporativo, telefono1, telefono2, secretaria, categoria, correo)
values
('Lic. Juan Perez', 'Electrónica Total S.A.', '+1 123-456-7890', '+1 123-456-7891', 'Juan Perez', 1, 'juanperez@electronica.com'),
('Lic. Maria Gomez', 'Gadget World S.A.', '+1 234-567-8901', '+1 234-567-8902', 'Maria Gomez', 2, 'mariagomez@gadgetworld.com'),
('Ing. Pedro Gonzalez', 'Tech Zone S.A.', '+1 345-678-9012', '+1 345-678-9013', 'Pedro Gonzalez', 3, 'pedrogonzalez@techzone.com'),
('Ing. Ana Sanchez', 'Hi-Tech Systems S.A.', '+1 456-789-0123', '+1 456-789-0124', 'Ana Sanchez', 4, 'anasanchez@hitechsystems.com'),
('Ing. Luisa Fernandez', 'Innovative Electronics S.A.', '+1 567-890-1234', '+1 567-890-1235', 'Luisa Fernandez', 5, 'luisafernandez@innovativeelectronics.com');


select * from provedores;

create table clientes (
id_cliente int auto_increment not null primary key,
nombre_cliente varchar(100) not null,
apellido_cliente varchar(100) not null,
direccion_cliente varchar(100) not null
);

insert into clientes (nombre_cliente, apellido_cliente, direccion_cliente)
values
('Carlos', 'Ramirez', 'Calle 6, Ciudad F'),
('Sofia', 'Torres', 'Calle 7, Ciudad G'),
('Miguel', 'Vargas', 'Calle 8, Ciudad H'),
('Adriana', 'Castro', 'Calle 9, Ciudad I'),
('Diego', 'Guzman', 'Calle 10, Ciudad J');

select * from clientes;

create table productos(
id_productos int auto_increment not null primary key,
precio  double(5,2) not null,
categoria int not null,
provedor int not null,
color varchar(100) not null,
stock int not null,
foreign key (categoria) references categoria (id_categoria),
foreign key (provedor) references provedores (id_provedores)
);

insert into productos (precio, categoria , provedor, color, stock)
values
(150.00, 1, 2, 'Negro', 10),
(300.50, 1, 3,'Blanco',5),
(250.00, 2, 1,'Gris',15),
(100.99, 3, 3, 'Plateado',16),
(450.25, 2, 4,'Negro',30);

select * from productos;

-- Cuál es la categoría de productos que más se repite.
select categoria.nombre, count(*) as cantidad from productos join categoria on productos.categoria = categoria.id_categoria 
group by productos.categoria order by cantidad desc limit 1;
-- la categoria que mas se repite es televisores

-- Cuáles son los productos con mayor stock
select id_productos ,categoria.nombre as categoria, stock from productos join categoria on productos.categoria = categoria.id_categoria order by stock desc
limit 1;
-- Los productos con mayor stock son computadoras, con un stock total de 30


-- Qué color de producto es más común en nuestra tienda.
select color, count(*) as cantidad from productos group by color order by cantidad desc
limit 1;
-- El color que es mas comun en nuestra tienda es el negro

-- Cual o cuales son los proveedores con menor stock de productos.
select provedores.nombre_corporativo , sum(stock) as total from productos join provedores on productos.provedor = provedores.id_provedores group by provedor
order by total asc limit 1;
-- El provedor con menos stock es Gadget world S.A  con un valor total de 10


-- Por último:
-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.


-- la categoria mas popular es televisores ahora la cambiaremos a 'Electronica y computacion'
UPDATE categoria
SET nombre = 'Electrónica y computación'
WHERE id_categoria = (SELECT categoria FROM productos GROUP BY categoria ORDER BY COUNT(*) DESC LIMIT 1);


-- se revisa el cambio
select categoria.nombre, count(*) as cantidad from productos join categoria on productos.categoria = categoria.id_categoria 
group by productos.categoria order by cantidad desc limit 1;
