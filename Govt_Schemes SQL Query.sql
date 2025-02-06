CREATE DATABASE Govt_Schemes_DB
USE Govt_Schemes_DB

--Project Name - Excited to Share My Project: Indian Government Schemes Management System

Create Table GovernmentSchemes
(
SchemeID INT PRIMARY KEY,
SchemeName VARCHAR(255),
Ministry VARCHAR(255),
StartDate DATE,
EndDate DATE,
Budget DECIMAL(15,2),
Beneficiaries INT
)
INSERT INTO GovernmentSchemes VALUES(1,'Pradhan Mantri Awas Yojana','Ministry of Housing and Urban Affairs','2015-06-01','2022-03-31', 200000.00,1500000),
(2,'Swachh Bharat Abhiyan','Ministry of Jal Shakti','2014-10-02','2024-10-02', 5000000.00, 10000000),
(3, 'Atal Mission for Rejuvenation and Urban Transformation', 'Ministry of Urban Development', '2015-01-01', '2020-12-31', 4000000.00, 5000000),
(4, 'Ayushman Bharat', 'Ministry of Health and Family Welfare', '2018-09-23', '2025-09-23', 10000000.00, 100000000),
(5, 'Make in India', 'Ministry of Commerce and Industry', '2014-09-25', '2025-09-25', 1500000.00, 200000)

SELECT * FROM GovernmentSchemes

-- How can you find the scheme with the highest budget?

SELECT * FROM GovernmentSchemes
WHERE Budget = (SELECT MAX(Budget) from GovernmentSchemes)

--Write a query to list all schemes that started after January 1st, 2015.

SELECT * FROM GovernmentSchemes
WHERE StartDate > '2015-01-01'

--How would you calculate the total budget allocated for all schemes?

SELECT SUM(Budget) AS TotalBudget FROM GovernmentSchemes

--How can you update the budget for a particular scheme (for example, SchemeID = 3)?

UPDATE GovernmentSchemes
SET Budget = 4500000.00
WHERE SchemeID = 3

SELECT * FROM GovernmentSchemes

--How would you delete the scheme with SchemeID = 5?

DELETE FROM GovernmentSchemes
WHERE SchemeID = 5


--Write a query to count the total number of beneficiaries across all schemes.

SELECT SUM(Beneficiaries) AS TotalBeneficiaries FROM GovernmentSchemes


--How can you get a list of schemes that end after 2023?

SELECT * FROM GovernmentSchemes
WHERE EndDate > '2023-12-31'


-- How would you get all schemes managed by the Ministry of Health and Family Welfare?

SELECT * FROM GovernmentSchemes
WHERE Ministry = 'Ministry of Health and Family Welfare'


-- Find all schemes with a budget greater than ₹4,000,000:

SELECT * FROM GovernmentSchemes
WHERE Budget > 4000000


--Find the number of schemes managed by each ministry:

SELECT Ministry, COUNT(*) AS NumberofSchemes
FROM GovernmentSchemes
GROUP BY Ministry


-- Get the scheme with the most beneficiaries:

SELECT * FROM GovernmentSchemes
ORDER BY Beneficiaries DESC

--Table Create for Foreign key

Create Table SchemeDetails
(
SchemeID INT,
Description TEXT,
FOREIGN KEY (SchemeID) REFERENCES GovernmentSchemes(SchemeID)
)

SELECT * FROM SchemeDetails

ALTER TABLE SchemeDetails
ADD TargetBeneficiaries INT,
    GeographicalFocus VARCHAR(255)

INSERT INTO SchemeDetails VALUES(1,'Affordable housing for urban poor under the Pradhan Mantri Awas Yojana, providing financial support to build homes.', 1500000, 'National'),
(2, 'A cleanliness drive initiated by the government to improve sanitation in urban and rural areas under the Swachh Bharat Abhiyan.', 10000000, 'National'),
(3, 'A mission to rejuvenate and transform urban infrastructure, including sewerage and water supply, under Atal Mission for Rejuvenation and Urban Transformation.', 5000000, 'Urban Areas'),
(4, 'A national health protection scheme to provide financial coverage for medical treatment to underprivileged families under Ayushman Bharat.', 100000000, 'National'),
(5, 'Promoting the manufacturing sector in India by facilitating investment, innovation, and skill development under the Make in India initiative.', 200000, 'National')


--Joins

-- Inner Joins,  returns only the rows where there is a match in both tables.

SELECT gs.SchemeID, gs.SchemeName, sd.Description
FROM GovernmentSchemes gs
INNER JOIN SchemeDetails sd ON gs.SchemeID = sd.SchemeID

-- Left Join, returns all records from the left table and the matched records from the right table

SELECT gs.SchemeID, gs.SchemeName, sd.Description
FROM GovernmentSchemes gs
LEFT JOIN SchemeDetails sd ON gs.SchemeID = sd.SchemeID

--Right Join, The RIGHT JOIN returns all records from the right table and the matched records from the right table

SELECT gs.SchemeID, gs.SchemeName, sd.Description
FROM GovernmentSchemes gs
RIGHT JOIN SchemeDetails sd ON gs.SchemeID = sd.SchemeID

--Full Outer Join, returns all records when there is a match in either the left or right table, It returns NULL for missing,
-- matches on either side.

SELECT gs.SchemeID, gs.SchemeName, sd.Description
FROM GovernmentSchemes gs
FULL OUTER JOIN SchemeDetails sd ON gs.SchemeID = sd.SchemeID


--Cross Join, returns the Cartesian product of both tables, i.e., all possible combinations of rows from both tables,
-- It does not require a condition to match rows.

SELECT gs.SchemeID, gs.SchemeName, sd.Description
FROM GovernmentSchemes gs
CROSS JOIN SchemeDetails sd


--UNION, While not a traditional "JOIN," a UNION combines the result sets of two or more queries. It returns distinct rows,
-- from all queries.

SELECT SchemeID, SchemeName
FROM GovernmentSchemes
UNION
SELECT SchemeID, CAST(Description AS VARCHAR(255)) AS Description
FROM SchemeDetails

SELECT SchemeID, SchemeName
FROM GovernmentSchemes
UNION ALL
SELECT SchemeID, CAST(Description AS VARCHAR(255)) AS Description
FROM SchemeDetails

