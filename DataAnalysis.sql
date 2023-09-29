Select * From HouseTable;

--Average and Maximum sale price for specific properties
Select LandUse as PropertyType, AVG(SalePrice) as AverageSalePrice, MAX(SalePrice) as MaxSalePrice
From HouseTable
Group by LandUse
Order by AverageSalePrice;

--Trends of property sale prices over the years
Select SaleDate, SalePrice, SoldAsVacant
From HouseTable
Order by SaleDate;

--Shows the owners with the number of properties they own
Select OwnerName, OwnerState, Count(UniqueID) as NumberOfProperties
From HouseTable
Where OwnerName is not null and OwnerState is not null
Group by OwnerName, OwnerAddress, OwnerCity, OwnerState
Order by NumberOfProperties DESC;

--Shows the number of properties based on the types owned by each owner
Select OwnerName, OwnerState, LandUse as PropertyType, Count(UniqueID) as NumberOfProperties
From HouseTable
Where OwnerName is not null and OwnerState is not null
Group by OwnerName, OwnerAddress, OwnerCity, OwnerState, LandUse
Order by NumberOfProperties DESC;

--Shows the average acreage of different properties
Select LandUse as PropertyType, Avg(acreage) as AverageAcreage
From HouseTable
Where acreage is not null
Group by LandUse
Order by AverageAcreage DESC;

--Shows the number of bedrooms, bathrooms and sale price of properties
Select SalePrice, Bedrooms, FullBath, HalfBath
From HouseTable
Where Bedrooms is not null and fullbath is not null and halfbath is not null
Order by SalePrice Desc;

--Shows the average sale price of vacant properties
Select Avg(SalePrice) as AveragePrice
From HouseTable
Where SoldAsVacant = 'Yes';

--Shows the average sale price of sold properties
Select Avg(SalePrice) as AveragePrice
From HouseTable
Where SoldAsVacant = 'No';





