use projectecommerce;

desc clients; 
select * from clients;

-- idClient, SocialName, Fname, Minit, Lname, CNPJ, CPF, Address, CityState
insert into Clients (SocialName, Fname, Minit, Lname, CNPJ, CPF, Address, CityState) 
	   values( null,'Carlos','S','da Hora', null, 12346789, 'Rua B 17, Barra', 'SSA - BA'),
			('Alcateia Soluções',  null, null, null, 123456789123456, null,'Rua 3 99, Itapua','SSA - BA'),
			( null,'Mônica','M','Feitosa', null, 987654321, 'Ala E 79, Ondina', 'LF - BA'),
            ('LA Escritório', null, null, null, 098745632101245, null, 'Praça M, 23, Pituaçú','LF - BA'),
			(null,'Ana','C','Santos', null, 45678913, 'Avenida Gremio 77, Centro', 'POA - RS'),
            ('Foxboro Serviços', null, null, null, 859674157896547, null, 'Beco Jurere 7, Praia', 'FLO - SP'),
			(null,'Antônio ','T','Moreira', null, 789123456, 'Ala Pao 14, Lapa', 'BH - MG'),
            ('Control Digital', null, null, null, 830236584967153, null, '25 de março 25, Centro', 'SP - SP'),
			(null,'Roberty','K','Rico', null, 98745631, 'Praia do pele 10, Bola', 'SAN - SP'),
            ('7 Financeira', null, null, null, 201236526354784, null, 'Lagoa Verde 14, Lago', 'ARA - SE'),
			(null,'Rodrigo','S','Santoro', null, 654789123, 'Estrada N 35, Centro','EST - SE'),
            ('Amazon Apple', null, null, null, 456789874563250, null, 'Rocinha 75, Rocinha','RJ - RJ');

select idClient as numberofClient, concat(Fname,' ', Minit,' ', Lname) as PF, SocialName as Empresa from clients 
		order by idClient;

-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, rating, size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elza',true,'Brinquedos','3',null),
                              ('Bola de Futebol infantil',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestuario','5',null),
                              ('Fantasia da Wandiinha',true,'Vestuario','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                               ('Feijão Japonês',False,'Alimentos','3',null),
                                ('Poltrona da Vovó',False,'Móveis','3','2x30x60'),
                              ('coleira PP',False,'Pet','3',null),
                              ('Colageno',False,'Medicamentos','3',null),
								('Omega 3',False,'Medicamentos','3',null),
							  ('base neutra facial',False,'Cosmeticos','3',null),
                               ('Relogio Garmin',False,'Eletrônico','3',null);
                               
select idProduct, Pname from product order by idProduct;   

desc orders;                  

ALTER TABLE orders
MODIFY paymentCash enum('Boleto', 'Pix', 'Cartão de Débito', 'Cartão de Credito', 'Dois Cartões') not null;     

ALTER TABLE orders
change paymentCash typePaymentOfOrders enum('Boleto', 'Pix', 'Cartão de Débito', 'Cartão de Credito', 'Dois Cartões') not null;     
                               
insert into orders (idOrderClient, orderStatus, trackingCode, orderDescription, sendValue, typePaymentOfOrders) values 
							 (1,'Finalizado', 98765432101234567890, 'compra via aplicativo',null,'Pix'),
                             (2, default, 23456789012345678901, 'compra via aplicativo',50,'Cartão de Credito'),
                             (3,'Confirmado', 54321012345678901234,'televendas',null,'Dois Cartões'),
                             (4, default, 89012345678901234567,'compra via web site',150,'Cartão de Credito'),  
							 (5, default, 21012345678901234568,'compra via aplicativo',null,'Pix'),
                             (6, default, 56789012345678901234,'compra via aplicativo',50,'Pix'),
                             (2,'Confirmado', 01234567890123456789, 'televendas',null,'Cartão de Credito'),
                             (1, default, 98765432101234567890,'compra via web site',150,'Cartão de Credito'),    
							 (8, default, 23456789012345678901, 'compra via aplicativo',null,'Boleto'),
                             (10,'Cancelado', 54321012345678901234, 'compra via aplicativo',50,'Cartão de Credito'),
                             (1,'Confirmado', 89012345678901234567, 'televendas',null,'Cartão de Credito'),
                             (8, default, 21012345678901234568, 'compra via web site',150,'Boleto');   
                             

select * from Clients, orders;

alter table payments
add constraint fk_payments_orders foreign key (idclient) references orders (idOrderClient); 

show tables; 

select * from payments;

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,1,1,null),
                         (3,2,1,null);
                         
insert into productStorage (storageLocation,quantity) values 
						('Salvador - BA',100),
						('Rio de Janeiro - RJ',6000),
						('São Paulo - SP',10),
						('Salvador - BA', 1200),
						('São Paulo - SP',30),
						('Maceio - AL', 80);
                        

SET SQL_SAFE_UPDATES = 0;

UPDATE productStorage
SET storageLocation = 'Rio de Janeiro - RJ'
WHERE storageLocation = 'Rio de Janeiro' AND quantity = 6000;

SET SQL_SAFE_UPDATES = 1;

insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'SP'),
                         (2,6,'AL'),
                         (3,3,'RJ'),
                         (4,4,'BA');
                         

insert into supplier (SocialName, CNPJSupplier, contact) values 
							('ALL Master', 123456789123456,'99021985474'),
                            ('Santos Saint', 854519649143457,'99521985484'),
                            ('Tudo da China Eletronicos', 934567893934695,'98721976475'),
                            ('Foxboro Mix', 858919625543457,'96823200484'),
                            ('Corea Eletronics', 934512363934695,'96891976989');


insert into productSupplier (idPsPsupplier, idPsProduct, quantity) values
						 (1,15,500),
                         (1,1,400),
                         (2,4,633),
                         (3,5,5),
						(4,2,400),
                         (1,6,633),
                         (5,3,5),
                         (5,4,10);
                         


insert into seller (SocialName, AbstName, CNPJSeller, CPFSeller, location, contact) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);
                                         
                        
                        
insert into productSeller (idPseller, idProduct, prodQuantity) values 
(1,6,80),
(2,7,10),
(3,5,70);

-- 1 - Recuperações Simples com SELECT Statement:
    
-- Recuperação de todos os clientes
SELECT * FROM clients;

-- Filtros com WHERE Statement:

-- 2 - Recuperação de clientes de uma cidade específica
SELECT * FROM clients WHERE CityState = 'SSA - BA';

-- 3 - Expressões para Gerar Atributos Derivados:

-- Criar um atributo derivado 'Nome Completo' na tabela clients

SELECT idClient, CONCAT(Fname, ' ', Minit, ' ', Lname) AS NomeCompleto FROM clients;

-- 4 - Ordenações dos Dados com ORDER BY:

-- Ordenar clientes por nome
SELECT * FROM clients ORDER BY Lname, Fname;

-- 5 - Condições de Filtros aos Grupos – HAVING Statement:

-- Recuperar a quantidade de pedidos para cada cliente que fez mais de 1 pedido
SELECT idClient, CONCAT(Fname, ' ', Minit, ' ', Lname) AS NomeCompleto, COUNT(idOrderClient) AS QuantidadePedidos
FROM clients
JOIN orders ON clients.idClient = orders.idOrderClient
GROUP BY idClient
HAVING QuantidadePedidos > 1;


-- 6 -  Junções entre Tabelas para Fornecer uma Perspectiva mais Complexa dos Dados:

-- Recuperar informações sobre produtos em pedidos
SELECT clients.idClient, clients.SocialName AS Cliente, product.Pname AS Produto, productOrder.poQuantity AS Quantidade
FROM clients
JOIN orders ON clients.idClient = orders.idOrderClient
JOIN productOrder ON orders.idOrder = productOrder.idPOorder
JOIN product ON productOrder.idPOproduct = product.idProduct;

