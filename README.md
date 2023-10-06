# HousingData

This housing data analysis project involves comprehensive data cleaning and subsequent analysis of a dataset containing information related to various aspects of real estate properties. The dataset includes details such as unique identifiers, property addresses, sale dates, sale prices, property types, ownership information, property features, and more.

**Data Cleaning Process:**
  In the initial phase of the project, a thorough data cleaning process was undertaken to ensure data integrity and consistency. The following data cleaning steps were performed:
  
    Standardization of Date Format: The date format in the dataset was standardized to ensure uniformity, facilitating easier analysis.
    Population of Property Address: Null values in the Property Address field were identified and subsequently populated using Parcel ID-based matching.
    Splitting of Property Address: Property and owner addresses were split into separate columns for address, city, and state to enhance data structure and usability.
    Standardization of SoldAsVacant: The SoldAsVacant column was standardized to only include 'Yes' or 'No' values, with 'Y' and 'N' being updated accordingly.
    Removal of Duplicate Records: Duplicate records were identified and removed using row number-based filtering.
    
**Data Analysis Process:**
  Some of the key aspects covered in the analysis included:
    Calculation of average and maximum sale prices for specific property types.
    Exploration of trends in property sale prices over the years.
    Identification of property owners and their respective property portfolios.
    Examination of property ownership distribution by property types.
    Evaluation of the average acreage for different property types.
    Analysis of property features such as the number of bedrooms, bathrooms, and sale prices.
    Calculation of the average sale prices for vacant and non-vacant properties.
  
