-- criação do banco de dados para cenario E-comercial
-- drop database ecomerce;
create database if not exists ecomerce;
use ecomerce;

create table Clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit char(3),
Lname varchar(20),
CPF char(11) not null,
Address varchar(255),
constraint unique_cpf_cliente unique (CPF)
);
alter table Clients auto_increment=1;



create table product(
idProduct int auto_increment primary key,
Pname varchar(255) not null,
Classification boolean default false,
Category enum("Eletrônico","Vestimenta","Brinquedos","Alimentos","Móveis") not null,
Avaliação float default 0,
size varchar(10)
 );

 
 alter table product auto_increment=1;

 
 create table orders(
 idOrder int auto_increment primary key,
 idOrderClient int,
 OrderStatus enum('Cancelado','Confirmado','Em processamento','compra via web site','compra via aplicativo') default 'Em processamento',
 OrderDescription varchar(255),
 SendValue float default 10,
 paymentCah boolean default false,
 idOrderPayment int,
 -- constraint fk_orders_payment foreign key (idOrderPayment) references Payment(idPayemnt),
 constraint fk_orders_client foreign key(idOrderClient) references Clients(idClient)
 on update cascade
 );
 alter table orders auto_increment=1;
 
 
  create table productStorage(
 idprodStorage int auto_increment primary key,
 Location varchar(255),
 Quantity int default 0
 );
 alter table productStorage auto_increment=1;
 
 create table  supplier(
 idSupplier int auto_increment primary key,
 SocialName varchar(255) not null,
 CNPJ char(15) not null,
 contact char(11) not null,
 constraint unique_supplier unique (CNPJ)
 );
 
 alter table supplier auto_increment=1;
 
 
 create table  seller(
 idSeller int auto_increment primary key,
 SocialName varchar(255) not null,
 AbstName varchar(255),
 CNPJ char(15),
 CPF char(11),
 Location varchar(255),
 contact char(11) not null,
 constraint unique_cnpj_suller unique (CNPJ),
 constraint unique_cpf_suller unique (CPF)
 );
 
 alter table seller auto_increment=1;
 
 create table productSeller(
 idPseller int ,
 idPproduct int ,
 prodQuantity int default 1,
 primary key(idPseller, idPproduct),
 constraint fk_product_seller foreign key(idPseller) references seller(idSeller),
 constraint fk_product_product foreign key(idPproduct) references product(idProduct)
 );
 
 create table productOrder(
 idPOproduct int,
 idPOorder int,
 poQuantity int default 1,
 poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
 primary key (idPOproduct,idPOorder),
 constraint fk_productorder_seller foreign key(idPOproduct) references product(idProduct),
 constraint fk_productorder_product foreign key(idPOorder) references orders(idOrder)
 );
 
 create table storageLocation(
 idLproduct int,
 idLstorage int,
 location varchar(255) not null,
 primary key(idLproduct,idLstorage),
 constraint fk_storage_location_product foreign key(idLproduct) references product(idProduct),
 constraint fk_storage_location_storage foreign key(idLstorage) references productStorage(idprodStorage)
 );
 
  create table productSupplier(
 idPsSupplier int,
 idPsProduct int,
 Quantity int not null,
 primary key(idPsSupplier,idPsProduct),
 constraint fk_product_supplier_supplier foreign key(idPsSupplier) references supplier(idSupplier),
 constraint fk_product_supplier_product foreign key(idPsProduct) references product(idProduct)
 );
 
 show databases;
 use information_schema;
 show tables;
 desc referential_constraints;
 select * from referential_constraints where constraint_schema = 'ecomerce';
 
 select concat(Fname, ' ',Lname) as name_Client, Address from Clients;
 select concat(Fname, ' ',Lname) as nome_Cliente, Pname as Produto_Comprado from Clients, product where idClient = idProduct;
 select concat(Fname, ' ',Lname) as nome_Cliente, Pname as Produto_Comprado, count(*) from Clients, product where idClient = idProduct group by Fname; 
select prodQuantity, Pname from productSeller inner join product on prodQuantity > 1;
select  Pname, Category  from product order by Category;
select distinct  Category  from product order by Category;

show tables;
SELECT * FROM productStorage;
select  Location, Quantity from productStorage group by Location having Quantity>10;
