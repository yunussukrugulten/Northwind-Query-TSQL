use Northwind

Select *
From Employees

Select CompanyName, Address, ContactName --kolonlar
From Customers -- tablo

Select OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
From Orders

--�al��anlar� Title Ad Soyad bilgileriyle listeleyiniz. Bu bilgiler tek bir kolonda bulunsun kolonun ad�da FullName olsun.

Select Title +' '+ FirstName +' '+ LastName AS FullName
From Employees

Select Title +' '+ FirstName +' '+ LastName FullName
From Employees

Select FullName = Title +' '+ FirstName +' '+ LastName
From Employees

Select CONCAT(Title,' ',FirstName,' ',LastName)
From Employees

Select CONCAT_WS(' ',Title, FirstName, LastName)
From Employees

-- �al��anlar�n hangi �ehirlerde ya��yor ? Her �ehirden bir defa listelensin?

Select distinct City AS Sehirler --distinct o kolondaki her veriden bir adet listelenmesini sa�lar.
From Employees

Select distinct Country, City
From Employees

-- Ka� �ehirden �al��an�m var?

Select COUNT (distinct City) AS CalisilanSehirAdeti
From Employees

--Count: Sat�r sayar

--�ehirlerdeki �al��an say�s� ka�t�r ? �ehir | �al��an adet?

Select City, Count(*)
From Employees
Group By City

Select City, Count(EmployeeID)
From Employees
Group By City

--Group By veri k�mesine grupland�r�lacak kolona g�re par�alamam�z� ve her par�aya ayn� i�i yapmam�z� sa�lar.

--Operatorler
--Kar��la�t�rma Operatorleri > < >= =< =
--Mant�ksal Operatorler AND OR

Select *
From Employees
Where City='Tacoma'

--�al��anlar�mdan do�um y�l� 1950 nin �zerinde olanlar� listeleyiniz

Select *
From Employees
Where BirthDate >= '19510101';

Select *
From Employees
Where YEAR(BirthDate) >= 1951;

--�al��anlar�mdan title bilgiisi Sales Representative veya Inside Sales Coordinator olanlardan Sehri London olanlar� listeleyiniz.

Select FirstName,Title,City
From Employees
Where (Title='Sales Representative' OR Title='Inside Sales Coordinator') AND City='London'

--M�sterimlerinden ileti�im kurdu�um firma �al��an�n�n title bilgisi "Sales Representative" veya "Accounting Manager" olanlar� listeleyiniz

Select ContactName, ContactTitle
From Customers
Where ContactTitle = 'Sales Representative' OR ContactTitle = 'Accounting Manager'

Select ContactName, ContactTitle
From Customers
Where ContactTitle IN ('Sales Representative' , 'Accounting Manager')

--Kargo �creti 50nin �zerinde olan sipari�lerin OrderId si 10254 ile 10348 aras�nda olanlar� listeleyiniz

Select OrderID, Freight
From Orders
Where Freight >50 AND OrderID > 10254 AND OrderID < 10348

Select OrderID, Freight
From Orders
Where Freight >50 AND OrderID Between 10254 AND 10348

--Almanyaya giden sipari�lerimden Kargo �creti 60dan k���k olanlar� listeleyiniz.

Select *
From Orders
Where ShipCountry = 'Germany' AND Freight <60

--�al��anlar�mdan benimle en uzun s�redir birlikte olan ilk ��� listeleyiniz.

Select TOP 3 FirstName + ' ' + LastName AS FullName, HireDate
From Employees
Where HireDate is not null
Order By HireDate ASC

Select TOP 3 FirstName + ' ' + LastName AS FullName, HireDate, DATEDIFF (Year,HireDate,GETDATE()) CalistigimizSure
From Employees
Where HireDate is not null
Order By HireDate ASC

--�al��anlar�m en ya�l�s� hangisidir ?

Select TOP 1 FirstName + ' ' + LastName AS FullName, DATEDIFF(YEAR, BirthDate, GETDATE()) yas
From Employees
Where BirthDate is not null
Order By BirthDate

--M�sterimlerin restoran sahibi olanlar hangileridir?

Select *
From Customers
Where CompanyName LIKE '%restaurant%' AND ContactTitle = 'Owner'

--�al��anlar�mdan japoncay� ak�c� bir �ekilde konu�anlar kimdir?

Select FirstName, LastName, Notes
From Employees
Where Notes LIKE '%japan%'

--Categori id de�erleri 1,4,6 olan �r�nlerimden hangi kategoride ka� �r�n oldu�unu listeleyin (categoryId | UrunAdet)

Select CategoryID, COUNT(ProductID)
From Products
Where CategoryID IN (1,4,6)
Group By CategoryID

Select CategoryID, SUM(UnitsInStock)
From Products
Group By CategoryID

--Ad�n�n ba� harfi b-k aras�nda olan �al��anlar�m� a'dan z'ye s�ral� listeleyiniz.

Select *
From Employees
Where FirstName LIKE '[b-k]%'

--Ad�n�n ba� harfi a ile ba�lamayanlar.

Select *
From Employees
Where FirstName LIKE '[^a]%'

--Hangi �al��an toplam ka� sipari� vermi�? (EmployeeID | SiparisAdeti)

Select EmployeeID, COUNT(OrderID)
From Orders
Group By EmployeeID