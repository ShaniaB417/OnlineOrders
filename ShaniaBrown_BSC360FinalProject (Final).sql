/******************************************************
Name: Shania Brown 

Assignment: BCS 360 Project: JCrew Online Orders 

Class: BCS 360  

Date 

***********************************************************/ 

/* SQL logic to implement the design in the database server */

/****************************************************** CREATE TABLES ***************************************************/

--Payment Table 

    Create table Payment_FP ( 
	PaymentID int not null identity (1,1) primary key, 
	PaymentType Char (6) not null, 
	CCNum int not null, CCExpMonth int not null, 
	CCExpYear int null, 
	CCsecNum int not null
    ) 


-- Passport_rewards Table 

	Create table Passport_rewards (
	PassportID  int not null identity (1,1) primary key,
	Points int not null, 
	Tier Varchar(10) not null, 
	JoinDate date null 
	)

-- store Table 

	Create table Store (
	storeID int not null identity (1,1) primary key,
	StoreName varchar (40) not null, 
	WebLink VarChar (50) not null 
	) 

-- customer table 

	Create table Customer_FP ( 
	CustomerID  int not null identity (1,1) Primary key, 
	FirstName varchar (60) not null, 
	LastName VARCHAR(60) not null, 
	Phone VARCHAR (25) not null, 
	Email VARCHAR (100) not null, 
	Username VARCHAR (20) NOT NULL, 
	Password VARCHAR(10) NOT NULL, 
	JCC CHAR (3) NOT NULL, 
	PaymentID int  foreign key references 
	Payment (paymentID), 
	PassportID int foreign key references 
	Passport_rewards(PassportID) 
	) 

-- order table 

	Create table [Order] (
	OrderID int not null identity (1,1) primary key,
	PurchaseDate date not null, 
	Taxes money null, 
	GrandTotal money not Null, 
	Status char (2) not null, 
	CustomerID int foreign key references customer (customerID), 
	PaymentID int  foreign key references payment (paymentID), 
	StoreID int foreign key references store (storeID), 
	Item_SKU int foreign key references item (Item_SKU)
	)

-- Shipping table 

	Create table Shipping (
	ShippingID int not null identity (1,1) primary key,
	ShippingDate date not null, 
	ArrivalDate date not null, 
	orderID int foreign key references [Order](orderID), 
	customerID int foreign key references customer (customerID) 
	) 

-- item table 

	Create table item (
	Item_SKU int not null primary key, 
	Size varchar (20) not null, 
	Price money not null, 
	ItemType varchar(50) not null 
	)

-- invoice 
	Create table invoice (
	invoiceID int not null identity (1,1) Primary key, 
	Quantity int not null, 
	TotalPrice money not null, 
	Item_Sku int foreign key references item (item_SKU), 
	OrderID int foreign key references [Order](orderID)
	)

-- order_history Table 

	Create table Order_HisID (
	OrderHisID int not null identity (1,1) primary key,
	DateOrdered date not null, 
	OrderID int foreign key references [Order](orderID), 
	customerID int foreign key references customer(customerID) 
	)


-- Tables 

Select * from Payment_FP

Select * from Passport_rewards

select * from store 

Select * from Customer_FP

Select * from [Order] -- issues explained in Issues and Errors section of document 

select * from Shipping

Select * from item 

select * from invoice

Select * from Order_HisID

/****************************** FIXING TABLES *************************/

Alter table payment_FP
add CCStatus char(2);

alter table Payment_FP
alter column CCNum  bigint;

alter table Passport_rewards 
alter column joindate varchar (40); 

delete from Payment_FP; 

alter table [order]
alter column PurchaseDate varchar(40);

alter table shipping 
alter column ShippingDate varchar(40);

/************************************************ LOADING DATA ************************************************************/ 

insert into Payment_FP (PaymentType, 	CCNum,	CCExpYear,	CCExpMonth,	CCSecNum, CCStatus)
values ( 'MC' ,	1234567823467837,	2045,	3,	576,	'A' ), 
	   ( 'V',	25368490876152436,	2023,	2,	456,	'I' ),
	   ('DIS',	2739373937261573,	2034,	12,	234,	'A'),
	   ('AMEX', 1937465893876352,	2025,	4,	123,	'I'),
		('MC',	1230987463521345,	2030,	5,	654,	'A'),
		('MC',	1238472837482938,	2022,	8,	788,	'I'),
		('V',	1223449754578965,	2030,	10,	765,	'A'),
		('DIS',	1230874737281927,	2020,	4,	987,	'A'),
		('AMEX',9764353342123456,	2022,	5,	977,	'A'),
		('V',	3454678965432678,	2023,	8,	654,	'A');


insert into Passport_rewards (Points, tier, JoinDate)
values (1234,	'Green', 	'5/1/21'),
		(234,	'Navy',	'4/5/23'),
		(4536,	'Gold',	'3/5/23'),
		(239,	'Gold',	'2/3/22'),
		(6783,	'Navy',	'6/6/21'),
		(800,	'Green', 	'3/4/21'),
		(78,	'Green',	'9/7/22'),
		(100,	'Navy', 	'10/6/22'),
		(2000,	'Navy', 	'9/4/21'),
		(234,	'Navy', 	'8/7/20');


insert into store (StoreName,	WebLink)
values ( 'JCrew',	'https://www.jcrew.com/'),	
		('JCrew Factory', 	'https://factory.jcrew.com'),	
		('Madewell' ,	'https://www.madewell.com');	


insert into Customer_FP ( PaymentId, PassportId, FirstName, LastName, Phone, Email, Username, Password, JCC)
values ( 1,	21,	'Wade', 	'Riely', '681-389-6798', 'WRiely@gmail.com', 'WadeR',  1234,	'Yes'),
		(2,	22,	'Seth', 	'Brain', '234-567-7890', 'SB@yahoo.com', 'BSeth',	1235,	'Yes'),
		(3, 23,	'Miles', 	'Ramon', '456-987-5678', 'miles123@gmail.com', 'MilesRam123',	1236,	'No'),
		(4,	24,	'Alison',	'Mila',  '123-456-7890', 'aMil@outlook.com', 'Alimi',	1237,	'Yes'), 
		(5,	25,	'Valentina', 'Cooper', '534-876-4568', 'Val@icloud.com', 'Cooperval',	1238,	'No'),
		(6,	26,	'Martin',	'Smith', '273-487-9087', 'Martin12Smith@gamil.com', 'MSmith12',	1239,	'Yes'),
		(7,	27,	'Kelly', 	'Morgan', '273-678-7890', 'KellyMor@yahoo.com',	'KellyKel', 1210,	'Yes'), 
		(8,	28,	'Sam', 	'Harris', 	'879-098-7654',	'Sam@icloud.com', 'Sammy',   2345,	'No'),
		(9,	29,	'Sasha', 	'Brown', '243-567-3546', 'SashBr@aol.com', 'SashaBrown',	2346,	'No'),
		(10,30,	'Simon','Hall',	'435-768-0986',	'SiHall@aol.com', 'SiHall',   2347,	'No');





insert into item (Item_Sku, ItemType, Size, Price)
values --(103,	'T-shirt',	'M',	29.98);
		(226,	'jacket',	'S',	209.99),
		(323,	'Blazer',	'L',	301.98),
		(403,	'Skirt',	'XL',	47.97),
		(593,	'jean',	'XXS',	49.98),
		(683,	'Blazer',	'XXL',	340.96),
		(793,	'Pant', 	'M',	50.98),
		(812,	'Blazer',	'S',	98.5),
		(989,	'T-Shirt',	'L',	20.99),
		(105,	'Sweater',	'L',	60),
		(112,	'jacket',	'XXL',	200),
		(121,	'jean',	'XXS',	45.98),
		(131,	'Sweater',	'XL',	37.97),
		(147,	'Blazer',	'M',	490.54),
		(151,	'Dress',	'S',	50.98),
		(176,	   'Jacket',	'S',	45.88),
		(188,	'Pant',	'XL',	58.98),
		(198,	'Dress',	'XL',	60.59),
		(202,	'pants',	'L',	46.34),
		(217,	'Shirt',	'M',	19.76),
		(223,	'Dress',	'L',	20.98),
		(233,	'Dress',	'M',	107.97);
	  


insert into [order] (CustomerID,	PaymentID,	StoreID,	PurchaseDate,	Taxes,	GrandTotal,	Status)
values --(4, 5, 	2,	'2/12/23',	1.88,	410.87,	'C');
		(5, 6, 	1,	'1/23/23',	2.88,	2347.88,	'P'),
		(6, 7,	 2,	'5/12/23',	1.88,	236.75,	'C')
		(7, 8,	 3,	'5/6/23',	1.88,	125.86,	'C'),
		(8, 9,	3,	'4/12/23',	1.88,	1.88,	'C'),
		(9, 10,  1,	'5/5/23',	1.88,	2.88,	'C'),
		(10, 11,	2,	'10/25/23',	2.88,	2.88,	'C'),
		(11, 12,	1,	'3/24/23',	2.88,	237.64,	'P');
		(12, 13,	3,	'9/26/23',	2.88,	237.64,	'P'),
		

insert into Shipping ( OrderID,	CustomerID,	ShippingDate, 	ArrivalDate)
Values ( 15, 4, '4/22/23', GETDATE()),
		(22, 5,  '2/2/23', getdate()),
		(23, 6, '2/23/23', GETDATE()),
		(28, 7, '1/23/23', GETDATE()),
		(29, 8, '5/23/23', getdate()),
		(34, 9, '7/3/23', getdate());


insert into invoice (Item_SKU,	OrderID,	Quantity,	TotalPrice)
values ( 103, 15, 4, 408.99),
		(105, 22, 1, 2345),
		(112, 23, 1, 234.87),
		(121, 28, 2, 123.98),
		(131, 29, 4, 2343.98),
		(147, 34, 4, 56.98);
		
insert into Order_HisID (orderID,	CustomerID,	DateOrdered)
values ( 15,4, getdate()),
		(22,5, getdate()),
		(23,6, getdate()),
		(28,7, getdate()),
		(29,8, getdate()),
		(34,9,  getdate()); 


/********************************** USE CASES *******************************************************/

select * from Customer_FP

-- create a new customer 
create proc spNewCustomer 
(@customerID int,
 @FirstName varchar (60), 
 @LastName varchar (60), 
 @Phone varchar (25), 
 @Email varchar (100), 
 @Username varchar(20), 
 @Password Varchar (20), 
 @JCC char (3),
 @PaymentID int, 
 @PassportID int 

 ) 

 As 

 begin try 
  
  Begin 
    if not exists (select 1 from Payment_FP where PaymentID = @paymentID)
    --check if customer is using payment id 
	   insert into Customer_FP
	   values (@FirstName , @LastName, @Phone, @Email, @username, @password, @JCC, @paymentID ) 

	   print 'record added' 
	  end 

 begin 

    if not exists (select 1 from Customer_FP where paymentid = @paymentID)
--create new payment record 
	 print'this record already exits '
	end

  end try 
  begin catch 
		
		throw 50001 , 'error found adding record ', 1

  end catch 

  -- adding a new Passport rewards

  Create Proc spAddPassportReward
    ( @PassportID int,  
	 @points char(5),
	 @tier Varchar (50),
	 @joindate Varchar(50)
	
	)

 As 

  begin try 

  declare @ID int 
  -- check if points exist  
   if not exists (select 1 from Passport_rewards where Points = @points)
  
  begin 
	  insert into Passport_rewards 
	  Values(@points, @tier, @joindate) 

	  set @ID = SCOPE_IDENTITY(); 
	  print 'record added' + convert(varchar, @ID)
  end 
  else 
	print 'this Passport rewards account already exists'

  end try 
  begin catch 
		
		throw 50001 , 'error found adding pass port rewards  ', 1

  end catch 

  -- function to get the total amount of the order  
  
create function fnTotalAmountofOrder()
  returns money

as 

  begin 

	return (select sum(taxes + grandtotal) 
	from [Order]
	where status = 'C'
	) 

  end; 

  -- trigger for updatng the JCC if they are approved. 
  select * from [Order]

 Alter trigger tCustomerUpdate 
on customer 
after update 

as 

begin try 
	if (select JCC from Customer_FP
				where CustomerID = (select CustomerID from inserted)) = 'Yes' 
				
			



-- check total amount values > 0 and < 500 

-- if true 
	--update the JCC

begin 
	update Customer_FP
	set JCC = 'no'
	where CustomerID = (select CustomerID from inserted)

end
	else 
-- if false 
-- display value 
		print ' you were denied a JCrew Credit Card. Please try Again Another Time.  '

end try 

begin catch 
	print 'error occured' + error_message()
end catch 

select * from Customer_FP



-- get the customer total 

create function fnCustomerTotal 
	(@MaxAmount money = 0 )
   returns table 


	return (select concat(firstname, ' ', lastname) as 'Customer Name' , sum(Grandtotal + taxes) as 'Total Amount' 
	from Customer_FP c 
	join [order] o 
	on c.CustomerID = o.CustomerID
	where status = 'c'
	group by concat(firstname, ' ', lastname)
	having sum(GrandTotal) >= @MaxAmount )


/*********************************** TEST ******************************************/ 

-- test 1 
  exec spNewCustomer @customerID = 10,
						@firstname = 'Sandra', 
						@LastName = 'Brown',
						@Phone = '6321234567', 
						@Email = 'SB@gmail.com', 
						@username = 'Sb', 
						@password = '1782',
						@JCC = 'yes',
						@paymentID = 11, 
						@passportID = 11

-- test 2 
exec spAddPassportReward @PassportID = 4,
						@points = 2345,
						@tier = 'Green',
						@joindate = '5/21/23'
						

select * from Passport_rewards

--test 3 

select 'Customer billing ' as 'Department', dbo.fnFullTotalAmount() as 'total amount for order' 

print 'Hello customer your total for the order is :  ' + convert(varchar, dbo.fnFullTotalAmount())

-- test 4 

select * from Customer_FP

insert into Customer_FP
values('test', 'one', '243-345-5678', 'test@ymail.com', '123', 2345, 'no', 4, 31)

--test 5 
select * from dbo.fnCustomerTotal(3)