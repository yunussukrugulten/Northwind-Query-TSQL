# Northwind_DML
Questions with Northwind database in MSSQL T-SQL answers

use Northwind

Select *
From Employees

Select CompanyName, Address, ContactName --kolonlar
From Customers -- tablo

Select OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
From Orders

--Çalışanları Title Ad Soyad bilgileriyle listeleyiniz. Bu bilgiler tek bir kolonda bulunsun kolonun adıda FullName olsun.

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

-- Çalışanların hangi şehirlerde yaşıyor ? Her şehirden bir defa listelensin?

Select distinct City AS Sehirler --distinct o kolondaki her veriden bir adet listelenmesini sağlar.
From Employees

Select distinct Country, City
From Employees

-- Kaç şehirden çalışanım var?

Select COUNT (distinct City) AS CalisilanSehirAdeti
From Employees

--Count: Satır sayar

--Şehirlerdeki çalışan sayısı kaçtır ? Şehir | Çalışan adet?

Select City, Count(*)
From Employees
Group By City

Select City, Count(EmployeeID)
From Employees
Group By City

--Group By veri kümesine gruplandırılacak kolona göre parçalamamızı ve her parçaya aynı işi yapmamızı sağlar.

--Operatorler
--Karşılaştırma Operatorleri > < >= =< =
--Mantıksal Operatorler AND OR

Select *
From Employees
Where City='Tacoma'

--Çalışanlarımdan doğum yılı 1950 nin üzerinde olanları listeleyiniz

Select *
From Employees
Where BirthDate >= '19510101';

Select *
From Employees
Where YEAR(BirthDate) >= 1951;

--Çalışanlarımdan title bilgiisi Sales Representative veya Inside Sales Coordinator olanlardan Sehri London olanları listeleyiniz.

Select FirstName,Title,City
From Employees
Where (Title='Sales Representative' OR Title='Inside Sales Coordinator') AND City='London'

--Müsterimlerinden iletişim kurduğum firma çalışanının title bilgisi "Sales Representative" veya "Accounting Manager" olanları listeleyiniz

Select ContactName, ContactTitle
From Customers
Where ContactTitle = 'Sales Representative' OR ContactTitle = 'Accounting Manager'

Select ContactName, ContactTitle
From Customers
Where ContactTitle IN ('Sales Representative' , 'Accounting Manager')

--Kargo ücreti 50nin üzerinde olan siparişlerin OrderId si 10254 ile 10348 arasında olanları listeleyiniz

Select OrderID, Freight
From Orders
Where Freight >50 AND OrderID > 10254 AND OrderID < 10348

Select OrderID, Freight
From Orders
Where Freight >50 AND OrderID Between 10254 AND 10348

--Almanyaya giden siparişlerimden Kargo ücreti 60dan küçük olanları listeleyiniz.

Select *
From Orders
Where ShipCountry = 'Germany' AND Freight <60

--Çalışanlarımdan benimle en uzun süredir birlikte olan ilk üçü listeleyiniz.

Select TOP 3 FirstName + ' ' + LastName AS FullName, HireDate
From Employees
Where HireDate is not null
Order By HireDate ASC

Select TOP 3 FirstName + ' ' + LastName AS FullName, HireDate, DATEDIFF (Year,HireDate,GETDATE()) CalistigimizSure
From Employees
Where HireDate is not null
Order By HireDate ASC

--Çalışanlarım en yaşlısı hangisidir ?

Select TOP 1 FirstName + ' ' + LastName AS FullName, DATEDIFF(YEAR, BirthDate, GETDATE()) yas
From Employees
Where BirthDate is not null
Order By BirthDate

--Müsterimlerin restoran sahibi olanlar hangileridir?

Select *
From Customers
Where CompanyName LIKE '%restaurant%' AND ContactTitle = 'Owner'

--Çalışanlarımdan japoncayı akıcı bir şekilde konuşanlar kimdir?

Select FirstName, LastName, Notes
From Employees
Where Notes LIKE '%japan%'

--Categori id değerleri 1,4,6 olan ürünlerimden hangi kategoride kaç ürün olduğunu listeleyin (categoryId | UrunAdet)

Select CategoryID, COUNT(ProductID)
From Products
Where CategoryID IN (1,4,6)
Group By CategoryID

Select CategoryID, SUM(UnitsInStock)
From Products
Group By CategoryID

--Adının baş harfi b-k arasında olan çalışanlarımı a'dan z'ye sıralı listeleyiniz.

Select *
From Employees
Where FirstName LIKE '[b-k]%'

--Adının baş harfi a ile başlamayanlar.

Select *
From Employees
Where FirstName LIKE '[^a]%'

--Hangi çalışan toplam kaç sipariş vermiş? (EmployeeID | SiparisAdeti)

Select EmployeeID, COUNT(OrderID)
From Orders
Group By EmployeeID
