SET @potential_prime = 1;
SET @divisor = 1;

SELECT 
    GROUP_CONCAT(POTENTIAL_PRIME SEPARATOR '&') 
FROM
    (SELECT @potential_prime := @potential_prime + 1 AS POTENTIAL_PRIME 
    FROM information_schema.tables t1,
         information_schema.tables t2
    LIMIT 1000
    ) list_of_potential_primes
WHERE NOT EXISTS(SELECT * 
                 FROM (SELECT @divisor := @divisor + 1 AS DIVISOR 
                       FROM information_schema.tables t4, 
                            information_schema.tables t5
	                     LIMIT 1000
                       ) list_of_divisors
	               WHERE MOD(POTENTIAL_PRIME, DIVISOR) = 0 AND POTENTIAL_PRIME <> DIVISOR
                 );
  
  
  
-- The two inner SELECTs (SELECT @potential_prime and SELECT @divisor) create two lists. Both of them contain numbers from 1 to 1000. 
The first list is list_of_potential_primes and the second is list_of_divisors.

-- Then, we iterate over the list of the potential primes (the outer SELECT) and for each number from this list we look for divisors 
(SELECT * FROM clause) that can divide the number without a remainder and are not equal to the number (WHERE MOD... clause). 
If at least one such divisor exists, the number is not prime and is not selected (WHERE NOT EXISTS... clause).
