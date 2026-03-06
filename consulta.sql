CREATE DATABASE "AlkeWallet";
SELECT current_database();

create table usuario(
user_id serial primary key,
nombre varchar(30) not null,
email varchar(60) not null unique,
contrasena varchar(30) not null,
saldo numeric(10,2) default 0.00
);

create table moneda (
currency_id serial primary key,
currency_name varchar(30) not null,
currency_symbol varchar(10) not null
);

create table transaccion (
transaction_id serial primary key,
sender_user_id int not null,
receiver_user_id int not null,
currency_id int not null,
importe numeric(10,2) not null,
transaction_date timestamp default current_timestamp,

constraint chk_diferente_usuario
check (sender_user_id <> receiver_user_id),

constraint fk_sender
foreign key (sender_user_id)
references usuario(user_id),

constraint fk_receiver
foreign key (receiver_user_id)
references usuario(user_id),

constraint fk_currency
foreign key (currency_id)
references moneda(currency_id)
);
select * from usuario;
select * from moneda;
select * from transaccion;

insert into usuario (nombre, email, contrasena, saldo)
values 
('Dalila', 'dali@email.com', '1234', 10000),
('Antonio', 'antonio@email.com', '1234', 8000),
('yessika', 'yessi@email.com', '1234', 12000),
('Aaron', 'aaron@email.com', '1234', 5000);

insert into moneda (currency_name, currency_symbol)
values
('Peso Chileno', 'CLP'),
('Dolar', 'USD');

--1° Consulta para obtener el nombre de la moneda elegida por un usuario específico.

select u.nombre, m.currency_name
from transaccion t
join usuario u on t.sender_user_id = u.user_id
join moneda m on t.currency_id = m.currency_id
where u.user_id = 1;

--2° Consulta para obtener todas las transacciones registradas

select 
t.transaction_id,
u1.nombre as remitente,
u2.nombre as receptor,
m.currency_name as moneda,
t.importe,
t.transaction_date
from transaccion t
join usuario u1 on t.sender_user_id = u1.user_id
join usuario u2 on t.receiver_user_id = u2.user_id
join moneda m on t.currency_id = m.currency_id;

---3° Consulta para obtener todas las transacciones realizadas por un usuario específico

select
t.transaction_id,
u1.nombre as remitente,
u2.nombre as receptor,
m.currency_name as moneda,
t.importe,
t.transaction_date
from transaccion t
join usuario u1 on t.sender_user_id = u1.user_id
join usuario u2 on t.receiver_user_id = u2.user_id
join moneda m on t.currency_id = m.currency_id
where u1.user_id = 1;

----4° Actualizar correo electrónico de un usuario

update usuario
set email = 'dalila_nuevo@email.com'
where user_id = 1;

select * from transaccion; ---para verificar

--5° Eliminar una transacción

delete from transaccion
where transaction_id = 1;

select * from transaccion; ---para verificar









