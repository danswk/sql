SELECT * FROM fs;

-- add record ID column as primary key for easy reset to original order
ALTER TABLE fs
ADD ID INT,
ADD PRIMARY KEY (ID);

SET @row_number = 0;
UPDATE fs
SET ID = (@row_number := @row_number + 1);

-- move ID to leftmost position
ALTER TABLE fs
CHANGE ID ID INT NOT NULL FIRST;

-- remove fixed leading & trailing quotes, spaces
UPDATE fs
SET
	`Gross Sales` = SUBSTRING(`Gross Sales`, 3, LENGTH(`Gross Sales`) - 4),
	COGS = SUBSTRING(COGS, 3, LENGTH(COGS) - 4),
	Profit = SUBSTRING(Profit, 3, LENGTH(Profit) - 4);

-- remove dollar symbol for conversion to decimal type
UPDATE fs
SET
	`Manufacturing Price` = REPLACE(`Manufacturing Price`, '$', ''),
	`Sale Price` = REPLACE(`Sale Price`, '$', ''),
	`Gross Sales` = REPLACE(`Gross Sales`, '$', ''),
	Discounts = REPLACE(Discounts, '$', ''),
	Sales = REPLACE(Sales, '$', ''),
	COGS = REPLACE(COGS, '$', ''),
	Profit = REPLACE(Profit, '$', '');
    
-- remove irregular leading & trailing quotes, spaces, brackets
UPDATE fs
SET
	Discounts = REPLACE(Discounts, '" ', ''),
	Discounts = REPLACE(Discounts, ' "', ''),
	Profit = REPLACE(Profit, '(', '');
    
-- add decimals to Profit values missing them
UPDATE fs
SET Profit = CONCAT(Profit, '00')
WHERE Profit LIKE '%.';

-- remove leading zeroes from Profit
UPDATE fs
SET Profit = 
    CASE 
        WHEN Profit LIKE '0%' THEN SUBSTRING(Profit, LOCATE('1', Profit))
        ELSE Profit
    END;

-- convert to decimal type for operation
UPDATE fs
SET
	`Manufacturing Price` = CAST(`Manufacturing Price` AS DECIMAL(9, 2)),
	`Sale Price` = CAST(`Sale Price` AS DECIMAL(9, 2)),
	`Gross Sales` = CAST(`Gross Sales` AS DECIMAL(9, 2)),
	Sales = CAST(Sales AS DECIMAL(9, 2)),
	COGS = CAST(COGS AS DECIMAL(9, 2)),
	Profit = CAST(Profit AS DECIMAL(9, 2));

-- alt. could combine like
-- UPDATE fs
-- SET Discounts = CAST(REPLACE(REPLACE(Discounts, '$', ''), '" ', '') AS DECIMAL(9, 2)),

-- aggregate sales data
SELECT
	Country,
	SUM(`Units Sold`) AS 'Total Units Sold',
	SUM(Sales) AS 'Total Sales',
	AVG(`Sale Price`) AS 'Average Sale Price'
FROM fs
GROUP BY Country;  -- same avg sale price for every country - products sold evenly across sale prices + countries

-- profit margins
SELECT
	Country,
	Product,
	`Month Year`,
	(Profit / Sales) * 100 AS 'Profit Margin'
FROM fs;  -- highest profit margin $26,200, lowest $0

-- sales trends
SELECT 
	`Month Year`,
	SUM(Sales) AS `Monthly Sales`
FROM fs
GROUP BY `Month Year`;  -- Oct 2014 best sales month with $12,344, Sep 2013 worst with $4464
-- no apparent trend linking time of year with sales

-- discount effectiveness
SELECT 
	`Discount Band`,
	AVG(Sales) AS 'Average Sales w/ Discount',
	AVG(Sales + Discounts) AS 'Average Sales w/out Discount',
	AVG(Profit) AS 'Average Profit'
FROM fs
GROUP BY `Discount Band`;  -- highest avg sales before + after discount & highest avg profit when discount is low
-- more economically advantageous to offer low discount than no discount

-- segmentation analysis
SELECT 
	Country,
	Segment,
	AVG(Sales) AS 'Average Sales'
FROM fs
GROUP BY Country, Segment;  -- highest avg sales by Small Business in USA, lowest by Channel Partners in Mexico

DESCRIBE fs;
