use Northwind
select *
from Employees

--2.Firmam�zda iki �al��an i�e ba�lam��t�r. �al��anlar�n bilgileri a�a��daki gibi olup kay�tlar�n�n yap�lmas� gerekmektedir

insert into Employees(LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,City,Country)
values('Brown','James','Sales Representative','Mr.','1970-01-01','1999-01-01','London','UK')
insert into Employees(LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,City,Country)
values('Dark','Annie','Sales Manager','Ms.','1966-01-27','1999-01-01','Seattle','USA')

--3.Annie bir s�re sonra oturdu�u �ehirden ta��n�p New York�a yerle�ti. Annie Dark �al��an�m�z�n bilgilerini g�ncelleyiniz.
update Employees
set Country = 'USA', City ='New York'
where EmployeeID =13 --employeeId Annie Dark �n 
select *
from Employees

--4.�al��anlar�mdan Nancy, bug�n, Alfreds Futterkiste �irketine Chai ve Chang �r�n�nden be�er adet satm��t�r. Bu �r�nlerin Federal Shipping kargo �irketi ile �� g�n sonra g�nderilmesi gerekmektedir. Bu sipari�in kayd�n� olu�turunuz

select EmployeeID
from Employees
where FirstName ='Nancy' ---> EmployeeID 1
--CustomerID ALFKI
--ShipVia 3
--PID2 15,20 CHANG
--PID1 14,40 CHAI
select*
from Orders -- 1 Insert
insert into Orders (CustomerID,EmployeeID,OrderDate,RequiredDate,ShipVia,ShipName)
values ('ALFKI',1,'2021-12-20','2021-12-23',3,'Alfreds Futterkiste') ----OrderID 11078


select*from [Order Details] --- Insert 2
insert into [Order Details] (OrderID,ProductID,UnitPrice,Quantity)
values (11078,1,14.40,5) --5 Tane Chai
insert into [Order Details] (OrderID,ProductID,UnitPrice,Quantity)
values (11078,2,15.20,5) -- 5 Tane Chang

select*from Products --- Update 2
update Products
set UnitsInStock =34, UnitsOnOrder=5
where ProductID=1
update Products
set UnitsInStock =12, UnitsOnOrder=45
where ProductID=2
-------------------------------------------------------------------------------------------------------
--5. Speedy Express veya United Package ile ta��nan, Steven Buchanan adl� �al��an�n rapor verdi�i �al��anlar�n ilgilendi�i ve Amerika'ya g�nderilen sipari�lerimin �r�nlerinden, tedarik s�resinde pazarlama m�d�rleriyle ileti�im kurulanlar�n kategorileri nelerdir?

select *
from Employees
where FirstName ='Steven' --employee�d = 5

select *
from Employees
where ReportsTo =5

select *
from Shippers
where CompanyName in('Speedy Express' ,'United Package') --shipvia 1 ve 2 

select *
from Employees
where ReportsTo =5

select distinct CategoryName
from Orders o join Employees e
			  on o.EmployeeID = e.EmployeeID
			  join [Order Details] od
			  on od.OrderID = o.OrderID
			  join Products p
			  on p.ProductID = od.ProductID
			  join Suppliers s
			  on s.SupplierID =p.SupplierID
			  join Categories c
			  on c.CategoryID =p.CategoryID
where ShipVia in(1,2) and ReportsTo =5 and ShipCountry ='USA'and  ContactTitle ='Marketing Manager' 

select *
from Suppliers
--6.Do�u b�lgesinden sorumlu �al��anlar taraf�ndan onaylanan sipari�lerdeki �irket ad� �F� ile ba�layan kargo �irketi ile ta��nan �r�nleri, sipari�i veren m��teri ad�yla birlikte kategorilerine g�re s�ralayarak raporlay�n�z.
select distinct ca.CategoryName,c.CompanyName,ProductName
from Region r join Territories t
			  on t.RegionID =r.RegionID
			  join EmployeeTerritories et
			  on et.TerritoryID =t.TerritoryID
			  join Employees e
			  on e.EmployeeID =et.EmployeeID
			  join Orders o
			  on o.EmployeeID = e.EmployeeID
			  join Shippers s 
			  on s.ShipperID =o.ShipVia
			  join [Order Details] od
			  on od.OrderID = o.OrderID
			  join Products p
			  on p.ProductID =od.ProductID
			  join Customers c
			  on c.CustomerID =o.CustomerID
			  join Categories ca
			  on ca.CategoryID =p.CategoryID
			  
where RegionDescription ='Eastern' and s.CompanyName like 'F%'
order by 1	  

--7.Her bir sipari� kaleminde �r�n�n kategorisi, hangi kargo �irketi ile g�nderildi�i, m��teri bilgisi, tedarik�i bilgisi ve hangi �al��an taraf�ndan onayland���n� tek bir kolonda bir c�mle ile ifade ediniz.(10248 id�li sipari� Dairy Products kategorisindedir. Federal Shipping isimli kargo firmas�yla Vins et alcools Chevalier isimli m��teriye g�nderilmi�tir. Cooperativa de Quesos 'Las Cabras' �r�n�n tedarik edildi�i firmad�r.)


select concat_ws(' ',o.OrderID ,'li sipari�',CategoryName,'kategorisindedir',s.CompanyName,'isimli kargo firmas�yla',cu.CompanyName,'isimli m��teriye g�nderilmi�tir.',su.CompanyName,ProductName,'�r�n�n tedarik edildi�i firmad�r.') as General
from Orders o join [Order Details] od
			  on od.OrderID = o.OrderID
			  join Products p
			  on p.ProductID = od.ProductID
			  join Categories c
			  on c.CategoryID =p.CategoryID
			  join Shippers s
			  on s.ShipperID = o.ShipVia
			  join Customers cu
			  on cu.CustomerID = o.CustomerID
			  join Suppliers su
			  on su.SupplierID = p.SupplierID

--8.�al��anlar�m ka� b�lgeden sorumludur? Sorumlu oldu�u b�lge say�s� en �ok olan �al��an�m kimdir? (2 sorgu)
select e.FirstName ,COUNT (TerritoryDescription) Territory
from Territories t join EmployeeTerritories et
				   on et.TerritoryID =t.TerritoryID
				   join Employees e
				   on e.EmployeeID =et.EmployeeID
group by e.FirstName
order by 2


select top 1 e.FirstName ,COUNT (TerritoryDescription) Territory
from Territories t join EmployeeTerritories et
				   on et.TerritoryID =t.TerritoryID
				   join Employees e
				   on e.EmployeeID =et.EmployeeID
group by e.FirstName
order by 2 desc

--9.01-01-1996 ile 01.01.1997 tarihleri aras�nda en fazla(adet anlam�nda) hangi �r�n sat�lm��t�r?
select top 1 ProductName,COUNT(p.ProductID) TotalSalesProducts
from Orders o join [Order Details] od
			  on o.OrderID = od.OrderID
			  join Products p
			  on p.ProductID = od.ProductID
where OrderDate between '1996-01-01' and '1997-01-01'
group by ProductName
order by 2 desc

--10.En �ok hangi kargo �irketi ile g�nderilen sipari�lerde gecikme olmu�tur? �irketin ad� ve geciken sipari� say�s�n� listeleyiniz.
select top 1 s.CompanyName,COUNT(o.OrderID) [NUMBER OF DELAYED ORDERS]
from Orders o join Shippers s
			  on s.ShipperID = o.ShipVia
where ShippedDate-RequiredDate>0
group by s.CompanyName
order by 2 desc
----------------------------------------------------------------------------------------------------------------------

--11.Steven adl� personelim hangi tedarik�imin �r�nlerini sat�yor?
select s.CompanyName
from Suppliers s
where s.SupplierID in(select SupplierID
					  from Products p 
					  where p.ProductID in(select ProductID
										  from [Order Details] od
										  where od.OrderID in (select OrderID
																from Orders o
																where o.EmployeeID in(select EmployeeID
																					  from Employees e
																					  where FirstName = 'Steven' ))))

--12.�al��anlar�m�n ad soyad bilgileri ile ilgilendikleri b�lge adlar�n� listeleyiniz.
select (select e.FirstName+' '+e.LastName
		from Employees e
		where e.EmployeeID =et.EmployeeID) as FullName
		,
		(select t.TerritoryDescription
		from Territories t
		where t.TerritoryID = et.TerritoryID) as TerritoryDescription
from EmployeeTerritories et

--13.Almanya�ya Federal Shipping ile kargolanm�� sipari�leri onaylayan �al��anlar� ve bu �al��anlar�n hangi b�lgede olduklar�n� listeleyiniz




select  FirstName, (select RegionDescription
					from Region r
					where r.RegionID in(select RegionID 
										from Territories t
										where t.TerritoryID in(select TerritoryID
																from EmployeeTerritories et
																where et.EmployeeID =e.EmployeeID)))Region
from Employees e
where EmployeeID in(select EmployeeID
					from Orders 
					where ShipCountry = 'Germany' and ShipVia in(select ShipperID
															     from Shippers
												                 where CompanyName ='Federal Shipping'))
--2.��z�m�			
select distinct (select FirstName
		from Employees e 
		where e.EmployeeID =et.EmployeeID and e.EmployeeID in(select EmployeeID
																from Orders 
																where ShipCountry = 'Germany' and ShipVia in(select ShipperID
																											from Shippers
																											where CompanyName ='Federal Shipping')))
																											,
																											(select RegionDescription
																											from Region r
																											where r.RegionID in(select RegionID
																																from Territories t
																																where																										t.TerritoryID=et.TerritoryID))Region 
from EmployeeTerritories et


--14.Seafood �r�nlerinden sipari� g�nderilen m��teriler kimlerdir?
select CompanyName
from Customers 
where CustomerID in(select CustomerID
					from Orders
					where OrderID in(select OrderID
									from [Order Details]
									where ProductID in(select ProductID
														from Products
														where CategoryID in(select	CategoryID
																			from Categories
																			where CategoryName ='seafood'))))
--15.1996 y�l�nda sipari� vermemi� m��teriler hangileridir?
select CompanyName
from Customers 
where CustomerID not in(select CustomerID		
					   from Orders
					   where OrderDate between '1996-01-01' and '1997-01-01')
--------------------------------------------------------------------------------------------------------
--16.En �ok hangi kargo �irketi ile g�nderilen sipari�lerde gecikme olmu�tur? �irketin ad� ve geciken sipari� say�s�n� listeleyen view�� olu�turunuz.
create view vw_NumberOfDelayedOrders as
select top 1 s.CompanyName,COUNT(o.OrderID) [NUMBER OF DELAYED ORDERS]
from Orders o join Shippers s
			  on s.ShipperID = o.ShipVia
where ShippedDate-RequiredDate>0
group by s.CompanyName
order by 2 desc

select *
from vw_NumberOfDelayedOrders

--17.T�m personelin satt��� �r�nlerin toplam sat�� adetinin, her bir �al��an�n kendi toplam sat�� adetine oran�n� �al��an ad� soyad�yla birlikte listeleyen view�� olu�turunuz.


Create View vw_Liste AS
select e.FirstName,e.LastName, ((Select SUM(Quantity) 
								From [Order Details]) / SUM(od.Quantity)) AS TOPLAM
from  Employees e join Orders o on  o.EmployeeID=e.EmployeeID
				  join [Order Details] od on od.OrderID =o.OrderID
group by e.FirstName,e.LastName

--18.�al��anlar� ve onlar�n y�neticilerini listeleyen view�� olu�turunuz.
create view vw_EmployeeRepostTo as
select FirstName,(select FirstName
				  from Employees em
				  where em.EmployeeID =e.ReportsTo)manager
from Employees e

--19.Bat� b�lgesinden sorumlu olan �al��anlar�m�n onaylad��� sipari�lerimi view olarak kaydediniz. �r�nlerimin tedarik�ilerini listeleyen bir view olu�turunuz. Bu viewleri kullanarak bat� b�lgesinden sorumlu olan �al��anlar�m�n onaylad��� sipari�lerimin tedarik�i bilgilerini listeleyiniz.
alter view vw_WesternOrders as 
select OrderID
from Orders o join Employees e
			  on e.EmployeeID =o.EmployeeID
			  join EmployeeTerritories et
			  on et.EmployeeID =e.EmployeeID
			  join Territories t
			  on t.TerritoryID =et.TerritoryID
			  join Region r
			  on r.RegionID =t.RegionID
where RegionDescription='Western'
group by OrderID

create view vw_ProductSupplier as
select ProductName,CompanyName
from Products p join Suppliers s
				on s.SupplierID = p.SupplierID

select w.Order�D,pro.CompanyName
from vw_WesternOrders w join [Order Details] od
					    on w.OrderID = od.OrderID
						join Products p
						on p.ProductID =od.ProductID
						join vw_ProductSupplier pro
						on p.ProductName =pro.ProductName
-----------------------------------------------------------------------------------------------------------------------------------
--20.Tedarik�i id�sini parametre alan ve o tedarik�inin sa�lad��� �r�nlerin yer ald��� sipari�leri listeleyen stored procedure yap�s�n� olu�turunuz
alter proc sp_SuppliersOrders(@Supplierid int =0) as
begin
	select o.OrderID
	from Orders o join [Order Details] od
				on od.OrderID = o.OrderID
				join Products p
				on od.ProductID =p.ProductID
				join Suppliers s
				on s.SupplierID =p.SupplierID
				where @Supplierid =s.SupplierID
end
exec sp_SuppliersOrders 4 --�rdek

--21.Girilen iki tarih aras�ndaki g�nler i�in g�nl�k ciromu veren bir stored procedure olu�turunuz.
create proc sp_DailyTotalPrice(@date1 datetime ,@date2 datetime) as
begin
select o.OrderID, SUM(Quantity*UnitPrice*(1-Discount))
from [Order Details] od join Orders o
						on o.OrderID =od.OrderID
where OrderDate between @date1 and @date2
group by o.OrderID
end


exec sp_DailyTotalPrice '1996-01-01','1998-01-01'

--22.Girilen �lke ad�na g�re hangi tedarik�i firmadan ka� adet �r�n al�nd���n� listeleyen stored procedure yap�s�n� olu�turunuz.
alter proc sp_SupplierProductsCount(@Country nvarchar(15)) as
begin
select s.CompanyName,COUNT(ProductID) TotalProductCount
from Products p join Suppliers s
				on p.SupplierID =s.SupplierID
				where @Country =s.Country
group by CompanyName
end

exec sp_SupplierProductsCount 'Germany'--�rdek

--23.M��terinin en �ok sipari� etti�i 3 �r�n� listeleyen stored procedure yap�s�n� olu�turun. Parametre olarak m��teri numaras�n� al�n�z.
alter proc sp_Top3Products(@customerid nvarchar(5) =0) as
begin
select TOP 3 p.ProductName, COUNT(p.ProductID)
from Products p join [Order Details] od
				on p.ProductID =od.ProductID
				join Orders o
				on od.OrderID =o.OrderID 
				join Customers c
				on c.CustomerID =o.CustomerID
				where @customerid =c.CustomerID
group by p.ProductName
ORDER BY 2 DESC
end

exec sp_Top3Products 'ANTON'
select *
from Products
---------------------------------------------------------------------------------------------------------------------------------------
--24.Parametre olarak ad soyad ve do�um tarihi bilgisini al�p �al��anlara mail adresi olu�turacak fonksiyonu olu�turunuz.
alter function fn_Email(@FirstName nvarchar(10),@LastName nvarchar(20),@Birtdate datetime)
returns table
as 
return
select CONCAT( FirstName,'.',LastName,YEAR(BirthDate),'@northwind.com' )Email
from Employees 
where FirstName = @FirstName and LastName=@LastName and BirthDate =@Birtdate

select *
from fn_Email('Nancy','Davolio','1948-12-08 00:00:00.000')


--25.Parametre olarak al�nan m��teri numaras�na g�re m��terinin toplam vermi� oldu�u sipari� say�s�n� geri d�nd�ren fonksiyonu yaz�n�z.
create function fn_CustomersOrders(@customerid nchar(5))
returns table
as 
return
select COUNT(OrderID) CountOrders
from Orders o join Customers c
			  on c.CustomerID =o.CustomerID
where c.CustomerID =@customerid
GROUP BY c.CustomerID

select *
from fn_CustomersOrders('ALFKI')


--26.Girdi olarak sipari� numaras� al�p sipari�in hangi m��teriye, hangi kargo �irketiyle, hangi �al��an taraf�ndan g�nderildi�ini ve g�nderilen �r�nlerin ka�ar adet oldu�unu �r�nlerin ad� ile birlikte listeleyen fonksiyonu yaz�n�z.

select o.OrderID,c.CompanyName,s.CompanyName,e.FirstName,p.ProductName,sum(od.Quantity) as Amount
from Orders o join Customers c
			  on c.CustomerID =o.CustomerID
			  join Shippers s
			  on s.ShipperID =o.ShipVia
			  join Employees e
			  on e.EmployeeID =o.EmployeeID
			  join [Order Details] od
			  on od.OrderID = o.OrderID
			  join Products p
			  on p.ProductID =od.ProductID
group by o.OrderID,c.CompanyName,s.CompanyName,e.FirstName,p.ProductName