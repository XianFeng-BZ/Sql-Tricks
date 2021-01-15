
-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and 
-- last characters. Your result cannot contain duplicates.

SELECT DISTINCT 
    CITY
FROM 
    STATION
WHERE 
    REGEXP_LIKE(City, '^[AEIOU].*[aeiou]$');


-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates.

SELECT DISTINCT 
    CITY 
FROM 
    STATION 
WHERE 
    CITY NOT IN (SELECT 
                    CITY
                 FROM
                    STATION
                 WHERE
                     CITY REGEXP '^[AEIOU]' AND CITY REGEXP '[AEIOU]$'
                 );
    
-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
-- Your result cannot contain duplicates.

SELECT DISTINCT
    City 
FROM 
    Station 
WHERE
    City NOT IN 
        (SELECT 
            City 
         FROM 
            Station 
         WHERE 
            City REGEXP '^[aeiou]' OR City REGEXP '[aeiou]$'
         );
