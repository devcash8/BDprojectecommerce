-- criação do banco de dados para ao cenário de E-Commerce

-- drop database projectecommerce;
create database  if not exists projectecommerce; 
use projectecommerce;

-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key,
    SocialName varchar (255), 
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CNPJ char(15),
	CPF char(9),
    Address varchar (30),
    CityState varchar (30),
    constraint unique_cpf_client unique(CPF),
    constraint unique_cnpj_client unique(CNPJ)

);

alter table clients auto_increment = 1; 
-- criar tabela produto

-- size = dimensão do produto

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(30) not null,
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos','Móveis', 'Pet', 'Medicamentos', 'Cosmeticos') not null,
    rating float default 0, 
    size varchar (30)

);

-- criar tabela de formas de pagamento
-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessarias
-- além disso, reflita essa modificação no diagrama esquema relacional

create table payments(
	idclient int,
    idpayment int,
    typePayment enum('Boleto', 'Pix', 'Cartão de Débito', 'Cartão de Credito', 'Dois Cartões') not null,
    complementPayment enum('Boleto', 'Pix', 'Cartão de Débito', 'Cartão de Credito', 'Dois Cartões'),
    limitAvailable float,
    primary key(idClient, idpayment)
        
);

-- criar tabela pedido

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'em processamento', 'Finalizado') default 'em processamento',
    trackingCode varchar (20)not null default 'Código Indisponivel',
    orderDescription varchar (255),
    sendValue float default 10,
    typePaymentOfOrders enum('Boleto', 'Pix', 'Cartão de Débito', 'Cartão de Credito', 'Dois Cartões') not null,
	constraint fk_orders_client foreign key (idOrderClient) references clients (idClient)
		on update cascade
);
alter table orders auto_increment=1;
-- criar tabela estoque

create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar (255),
    quantity int default 0

);    	

-- criar tabela fornecedor

create table supplier(
	idsupplier int auto_increment primary key,
	 SocialName varchar (255) not null,
     CNPJSupplier char(15) not null,
    contact char(11) not null,
	constraint unique_supplier unique(CNPJSupplier)
);

-- criar tabela vendedor

create table Seller(
	idseller int auto_increment primary key,
	SocialName varchar (255) not null,
	AbstName varchar(255),
	CNPJSeller char(15),
	CPFSeller char(9),
    location varchar (255),
	contact char(11) not null,
	constraint unique_cnpj_seller unique(CNPJSeller),
    constraint unique_cpf_seller unique(CPFSeller)
);       

-- criar tabela Produto Vendedor

create table productSeller(
	idPseller int,
    idProduct int,
    prodQuantity int default 1, 
    primary key(idPseller, idProduct),  
	constraint fk_product_seller foreign key (idPseller) references seller (idseller),
    constraint fk_product_product foreign key (idProduct) references product (idProduct)
);       

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1, 
    poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
    primary key(idPOproduct, idPOorder),  
	constraint fk_POproduct_product foreign key (idPOproduct) references product (idProduct),
    constraint fk_POorder_orders foreign key (idPOorder) references orders (idOrder)
);   


create table storageLocation(
	idLproduct int,
    idLstorage int,
	location varchar (255) not null,
    primary key(idLproduct, idLstorage),  
	constraint fk_storage_location_product foreign key (idLproduct) references product (idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage (idProdStorage)
);   

create table productSupplier(
	idPsPsupplier int,
    idPsProduct int,
    quantity int not null,
	primary key(idPsPsupplier, idPsProduct),  
	constraint fk_product_supplier_supplier foreign key (idPsPsupplier) references supplier (idsupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);   

show tables; 

desc clients;