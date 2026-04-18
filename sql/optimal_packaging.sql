-- Determining Optimal Packaging for Christmas Gifts
 
-- Given two tables, playground.gifts and playground.packages, write a SQL query to
-- match each gift to the smallest package it fits into based on dimensions. 
-- A gift fits in a package if its dimensions are less than or equal to those of the package.
-- A package is considered smaller than another if its volume is smaller. Each package can hold only one gift. 
-- Produce a table with columns: package_type and number, where number indicates how many gifts are matched to each
-- package_type. Exclude package types not used. Sort the result by package_type in ascending order. Assume every gift fits in at least one package and no two packages have the same volume.
-- These are the tables to query for this question:
-- playground.gifts

--     id int
--     gift_name string
--     length int
--     width int
--     height int

-- playground.packages

--     package_type string
--     length int
--     width int
--     height int

-- Your answer should include these columns:

--     package_type varchar
--     number integer

-- small	1
-- medium	8
-- special	12
-- big	64
-- extra	125

-- 1	Water gun	3
-- 2	Video game	1
-- 3	Toy car	16
-- 4	Toy car	16
-- 5	Toy gun	2

WITH package_with_volume AS (
    SELECT 
     package_type,
     length,
     width,
     height,
     length * width * height AS package_volume
    FROM playground.packages
), 
volume_of_gifts AS (
    SELECT 
        id,
        gift_name,
        length,
        width,
        height,
        length * width * height AS gift_volume
    FROM playground.gifts
), 
both_logics AS (
SELECT 
vg.id,
vg.gift_name,
pv.package_type,
pv.package_volume,
vg.gift_volume,
ROW_NUMBER() OVER (PARTITION BY vg.id ORDER BY pv.package_volume ASC) AS rn_gift,
ROW_NUMBER() OVER (PARTITION BY pv.package_type ORDER BY vg.gift_volume desc) as rn_package
FROM volume_of_gifts vg
JOIN package_with_volume pv
ON (vg.length <= pv.length 
AND vg.width <= pv.width
AND vg.height <= pv.height)
--ORDER BY vg.id, pv.package_volume
ORDER BY pv.package_type, pv.package_volume, vg.gift_volume desc )
SELECT package_type, count(*) as number FROM both_logics WHERE rn_gift=1 AND rn_package=1
GROUP BY package_type
