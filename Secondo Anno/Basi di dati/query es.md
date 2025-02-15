---
date: 2024/10/22
tags: 
Materia: "[[Basi di dati]]"
---
## query es

#### 1 
```
SELECT * FROM Customers where Country = "France";`
```
#### 2 
```
SELECT s.SupplierName, COUNT(p.ProductID)  
FROM Products p
JOIN Suppliers s on p.SupplierID = s.SupplierID 

```
#### 3 
```
SELECT c.[CategoryName] , SUM(p.[UnitPrice]*p.[UnitsInStock])
FROM [Products]  p 
JOIN [Categories]  c ON c.[CategoryID]  = p.[CategoryID] 
GROUP BY c.[CategoryID] 
```
#### 4 
```
SELECT c.[ContactName], COUNT(o.[OrderID])
FROM [Customers] c 
JOIN [Orders] o ON c.[CustomerID] = o.[CustomerID] 
GROUP BY c.[CustomerID] 
ORDER BY c.[ContactName] ASC 
```
#### 6 
```
SELECT c.[ContactName], SUM(od.[UnitPrice]*od.[Quantity])
FROM [Customers] c 
JOIN [Orders] o ON c.[CustomerID] = o.[CustomerID]
JOIN [Order Details] od ON o.[OrderID] = od.[OrderID]
GROUP BY c.[CustomerID]
```
#### 8 
```
SELECT p.[ProductName] 
FROM [Products] p 
JOIN [Suppliers] s ON p.[SupplierID] = s.[SupplierID] 
WHERE s.[Country] = "Italy"
```
#### 9
```
SELECT SUM(od.[UnitPrice] * od.[Quantity])
FROM [Products] p 
JOIN [Suppliers] s ON p.[SupplierID] = s.[SupplierID]
JOIN [Order Details] od ON p.[ProductID] = od.[ProductID] 
WHERE s.[Country] = "France"
```
#### 10 
```
SELECT e.[FirstName], COUNT(o.[OrderID]) 
FROM [Employees] e
JOIN [Orders] o ON e.[EmployeeID]  = o.[EmployeeID] 
GROUP BY e.[EmployeeID]  
HAVING  COUNT(o.[OrderID]) > 50
```
#### 13 
```
SELECT c.[ContactName], e.[FirstName] , e.[Country]  
FROM [Customers] c
JOIN [Orders] o ON c.[CustomerID] = o.[CustomerID] 
JOIN [Employees] e ON o.[EmployeeID] = e.[EmployeeID] 
WHERE c.[Country] = e.[Country] 
```
#### 15 
```
SELECT od.[Quantity] * od.[UnitPrice] AS Total, o.[OrderDate] 
FROM [Orders] o
JOIN [Order Details] od ON o.[OrderID] = od.[OrderID] 
WHERE o.[OrderDate] BETWEEN "1995-07-01" AND "1995-09-30"
```

## Sub query

#### 1
```
SELECT c.[ContactName], FORMAT(o.[OrderDate], "dd/mm/yyyy") 
FROM [Customers] c
JOIN [Orders] o ON c.[CustomerID] = o.[CustomerID] 
WHERE o.[OrderDate]  = (
SELECT MAX(o.[OrderDate])
FROM [Orders] o 
)

```
#### 2
```
SELECT
p.[ProductID],
SUM(ode.[UnitPrice] * ode.[Quantity])/(
	SELECT SUM(od.[UnitPrice] * od.[Quantity])
	FROM [Order Details] od)*100,
(
	SELECT SUM(od.[UnitPrice] * od.[Quantity])
	FROM [Order Details] od)
FROM [Order Details] ode
JOIN [Products] p ON ode.[ProductID] = p.[ProductID]
GROUP BY p.[ProductID] 

```
#### 3
```
SELECT c.[CompanyName] 
FROM [Customers] c
JOIN [Orders] o ON c.[CustomerID] = o.[CustomerID] 
WHERE o.[OrderDate] > #1995-1-1#
GROUP BY c.[CompanyName] 
```
#### 4
```
SELECT c.[ContactName], c.[CompanyName] 
FROM [Customers] c
JOIN [Orders] o ON c.[CustomerID] = o.[CustomerID]
JOIN [Order Details]  od ON od.[OrderID]  = o.[OrderID]
WHERE od.[ProductID] = 23 AND od.[Quantity] > 20
GROUP BY c.[CustomerID] 
```
#### 5
```
SELECT p.[ProductName] , MAX(od.[Quantity]) AS [Quantity] 
FROM [Order Details] od
JOIN [Products] p ON od.[ProductID] = p.[ProductID] 
GROUP BY p.[ProductID] 
```
```
SELECT p.[ProductName], od.[Quantity]

FROM [Products] p

JOIN [Order Details] od ON p.[ProductID] = od.[ProductID]

WHERE [Quantity] = (

SELECT MAX(ods.[Quantity])

FROM [Order Details] ods

WHERE od.[ProductID] = ods.[ProductID]

)
```

#### 6
```
SELECT e.[LastName] 
FROM [Employees] e
WHERE e.[EmployeeID]  IN (SELECT o.[EmployeeID] 
FROM [Orders] o
WHERE o.[OrderDate] = '1994-09-02')
```
