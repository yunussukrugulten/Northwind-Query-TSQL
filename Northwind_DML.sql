use Northwind

Select *
From Employees

Select CompanyName, Address, ContactName --kolonlar
From Customers -- tablo

Select OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
From Orders

--Çalýþanlarý Title Ad Soyad bilgileriyle listeleyiniz. Bu bilgiler tek bir kolonda bulunsun kolonun adýda FullName olsun.

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

-- Çalýþanlarýn hangi þehirlerde yaþýyor ? Her þehirden bir defa listelensin?

Select distinct City AS Sehirler --distinct o kolondaki her veriden bir adet listelenmesini saðlar.
From Employees

Select distinct Country, City
From Employees

-- Kaç þehirden çalýþaným var?

Select COUNT (distinct City) AS CalisilanSehirAdeti
From Employees

--Count: Satýr sayar

--Þehirlerdeki çalýþan sayýsý kaçtýr ? Þehir | Çalýþan adet?

Select City, Count(*)
From Employees
Group By City

Select City, Count(EmployeeID)
From Employees
Group By City

--Group By veri kümesine gruplandýrýlacak kolona göre parçalamamýzý ve her parçaya ayný iþi yapmamýzý saðlar.

--Operatorler
--Karþýlaþtýrma Operatorleri > < >= =< =
--Mantýksal Operatorler AND OR

Select *
From Employees
Where City='Tacoma'

--Çalýþanlarýmdan doðum yýlý 1950 nin üzerinde olanlarý listeleyiniz

Select *
From Employees
Where BirthDate >= '19510101';

Select *
From Employees
Where YEAR(BirthDate) >= 1951;

--Çalýþanlarýmdan title bilgiisi Sales Representative veya Inside Sales Coordinator olanlardan Sehri London olanlarý listeleyiniz.

Select FirstName,Title,City
From Employees
Where (Title='Sales Representative' OR Title='Inside Sales Coordinator') AND City='London'

--Müsterimlerinden iletiþim kurduðum firma çalýþanýnýn title bilgisi "Sales Representative" veya "Accounting Manager" olanlarý listeleyiniz

Select ContactName, ContactTitle
From Customers
Where ContactTitle = 'Sales Representative' OR ContactTitle = 'Accounting Manager'

Select ContactName, ContactTitle
From Customers
Where ContactTitle IN ('Sales Representative' , 'Accounting Manager')

--Kargo ücreti 50nin üzerinde olan sipariþlerin OrderId si 10254 ile 10348 arasýnda olanlarý listeleyiniz

Select OrderID, Freight
From Orders
Where Freight >50 AND OrderID > 10254 AND OrderID < 10348

Select OrderID, Freight
From Orders
Where Freight >50 AND OrderID Between 10254 AND 10348

--Almanyaya giden sipariþlerimden Kargo ücreti 60dan küçük olanlarý listeleyiniz.

Select *
From Orders
Where ShipCountry = 'Germany' AND Freight <60

--Çalýþanlarýmdan benimle en uzun süredir birlikte olan ilk üçü listeleyiniz.

Select TOP 3 FirstName + ' ' + LastName AS FullName, HireDate
From Employees
Where HireDate is not null
Order By HireDate ASC

Select TOP 3 FirstName + ' ' + LastName AS FullName, HireDate, DATEDIFF (Year,HireDate,GETDATE()) CalistigimizSure
From Employees
Where HireDate is not null
Order By HireDate ASC

--Çalýþanlarým en yaþlýsý hangisidir ?

Select TOP 1 FirstName + ' ' + LastName AS FullName, DATEDIFF(YEAR, BirthDate, GETDATE()) yas
From Employees
Where BirthDate is not null
Order By BirthDate

--Müsterimlerin restoran sahibi olanlar hangileridir?

Select *
From Customers
Where CompanyName LIKE '%restaurant%' AND ContactTitle = 'Owner'

--Çalýþanlarýmdan japoncayý akýcý bir þekilde konuþanlar kimdir?

Select FirstName, LastName, Notes
From Employees
Where Notes LIKE '%japan%'

--Categori id deðerleri 1,4,6 olan ürünlerimden hangi kategoride kaç ürün olduðunu listeleyin (categoryId | UrunAdet)

Select CategoryID, COUNT(ProductID)
From Products
Where CategoryID IN (1,4,6)
Group By CategoryID

Select CategoryID, SUM(UnitsInStock)
From Products
Group By CategoryID

--Adýnýn baþ harfi b-k arasýnda olan çalýþanlarýmý a'dan z'ye sýralý listeleyiniz.

Select *
From Employees
Where FirstName LIKE '[b-k]%'

--Adýnýn baþ harfi a ile baþlamayanlar.

Select *
From Employees
Where FirstName LIKE '[^a]%'

--Hangi çalýþan toplam kaç sipariþ vermiþ? (EmployeeID | SiparisAdeti)

Select EmployeeID, COUNT(OrderID)
From Orders
Group By EmployeeID