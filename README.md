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

<p align="center">
  <img src="ipgAdmin_usuario.png=@pgAdmin_usuario,0" width="600">
</p>


insert into moneda (currency_name, currency_symbol)
values
('Peso Chileno', 'CLP'),
('Dolar', 'USD');

<p align="center">
  <img src="ipgAdmin_usuario.png=@pgAdmin_usuario,0" width="600">
</p>


insert into transaccion (
sender_user_id,
receiver_user_id,
currency_id,
importe
)

select
u1.user_id,
u2.user_id,
floor(random() * 2 + 1)::int,
round((random() * 5000 + 100)::numeric, 2)
from generate_series(1,15),
lateral (
select user_id from usuario order by random() limit 1
) u1,
lateral (
select user_id from usuario 
where user_id <> u1.user_id
order by random() limit 1
) u2;

<p align="center">
  <img src="pgAdmin_moneda.png=@pgAdmin_moneda,0" width="600">
</p>

select u.nombre, m.currency_name
from transaccion t
join usuario u on t.sender_user_id = u.user_id
join moneda m on t.currency_id = m.currency_id
where u.user_id = 1;