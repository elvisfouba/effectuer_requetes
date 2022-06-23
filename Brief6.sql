use AdventureWorksDW2012

--1) La table de faits c est la table : [FactInternetSales]

--2) la requete qui permet d afficher les chiffres d affaires par annee et par pays

select sum ([SalesAmount]) as CA, [CalendarYear], [SalesTerritoryCountry]
from [dbo].[DimDate],[dbo].[DimSalesTerritory], [dbo].[FactInternetSales]
where [DateKey]=[OrderDateKey] and [FactInternetSales].[SalesTerritoryKey]=[DimSalesTerritory].[SalesTerritoryKey]
group by grouping sets([SalesTerritoryCountry],[CalendarYear]);

--3) la requete qui permet d afficher les quantites vendues de tous les produits aux USA par mois de chaque annee puis par annee puis en totalite

select SUM ([OrderQuantity]) as quantity, [EnglishMonthName], [CalendarYear]
from [FactInternetSales], [DimDate], [DimSalesTerritory]
where [FactInternetSales].[OrderDateKey]=[DimDate].[DateKey]
and [FactInternetSales].[SalesTerritoryKey]=[DimSalesTerritory].[SalesTerritoryKey]
and [SalesTerritoryCountry]='United States'
group by rollup([EnglishMonthName], [CalendarYear]);

--4) La requete qui permet d afficher le chiffre d affaires genere par annee, pays et par genre du client avec tous les groupements possibles

select SUM([SalesAmount]) as CA, [CalendarYear],[SalesTerritoryCountry],[Gender]
from [dbo].[DimCustomer], [dbo].[DimDate], [DimSalesTerritory], [dbo].[FactInternetSales]
where [dbo].[FactInternetSales].[OrderDateKey]=[DimDate].[DateKey] 
and [dbo].[FactInternetSales].[SalesTerritoryKey]=[DimSalesTerritory].[SalesTerritoryKey]
and [dbo].[FactInternetSales].[CustomerKey]=[dbo].[DimCustomer].[CustomerKey]
group by cube([Gender],[CalendarYear],[SalesTerritoryCountry]);
