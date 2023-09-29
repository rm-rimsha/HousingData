Select * From HouseTable;

--Standardize the date format
Alter table HouseTable
Alter column SaleDate date;

--Populate the PropertyAddress
--as it can not null or changed
Select *
From HouseTable
Where PropertyAddress is null;

--Parcel ID based on the address/city
--Using SELF JOIN to update the null values in PropertyAddress based on ParcelID

Select h1.ParcelID, h1.PropertyAddress, h2.ParcelID, h2.PropertyAddress, isNULL(h1.PropertyAddress, h2.PropertyAddress)
From HouseTable h1
	Join HouseTable h2 on h1.ParcelID = h2.ParcelID AND h1.UniqueID <> h2.UniqueID
Where h1.PropertyAddress is null;

Update h1
Set PropertyAddress = isNULL(h1.PropertyAddress, h2.PropertyAddress)
From HouseTable h1
	Join HouseTable h2 on h1.ParcelID = h2.ParcelID AND h1.UniqueID <> h2.UniqueID
Where h1.PropertyAddress is null;

--Split the Property Address and Owner Address to Address, State, City

--Split the data
Select PropertyAddress,
	   Parsename(Replace(PropertyAddress, ',', '.'),2) as Address,
	   Parsename(Replace(PropertyAddress, ',', '.'),1) as City
From HouseTable;

--Add the columns to data  table
Alter table HouseTable
Add PropertyCity nvarchar(255);

--Add the split data to the columns
Update HouseTable
Set PropertyCity = Parsename(Replace(PropertyAddress, ',', '.'),1);

Update HouseTable
Set PropertyAddress = Parsename(Replace(PropertyAddress, ',', '.'),2);

--For owner address
Select OwnerAddress,
	   Parsename(Replace(OwnerAddress, ',', '.'), 3) as OwnerAddress,
	   Parsename(Replace(OwnerAddress, ',', '.'), 2) as OwnerCity,
	   Parsename(Replace(OwnerAddress, ',', '.'), 1) as OwnerState
From HouseTable;

--Add the columns
Alter table HouseTable
Add OwnerCity nvarchar(255), OwnerState nvarchar(255);

--Update the data
Update HouseTable
Set OwnerCity = Parsename(Replace(OwnerAddress, ',', '.'), 2), 
	OwnerState = Parsename(Replace(OwnerAddress, ',', '.'), 1);

Update HouseTable
Set OwnerAddress = Parsename(Replace(OwnerAddress, ',', '.'), 3);

--Remove the inconsistent data
--Standardize the SoldAsVacant column
--Only Yes and No (Update the Y and N)

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From HouseTable
Group by SoldAsVacant
Order by Count(SoldAsVacant);

Update HouseTable
Set SoldAsVacant = CASE
					When SoldAsVacant = 'Y' THEN 'Yes'
					When SoldAsVacant = 'N' THEN 'No'
					Else SoldAsVacant
					END;

--Remove duplicates

--Find duplicates using row number
Select *,
		ROW_NUMBER() OVER 
			(Partition by
				ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
			 Order by UniqueID) as RowNumber
From HouseTable;

--Using CTE
With RowNumberCTE as 
(Select *,
		ROW_NUMBER() OVER 
			(Partition by
				ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
			 Order by UniqueID) as RowNumber
From HouseTable)
Delete From RowNumberCTE Where RowNumber > 1;
