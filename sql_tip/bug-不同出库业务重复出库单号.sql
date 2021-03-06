SELECT DS.ATTRIBUTE1
  FROM (SELECT DE.TRANSACTION_SOURCE_NAME, DE.ATTRIBUTE1
          FROM MTL_MATERIAL_TRANSACTIONS DE
         GROUP BY DE.TRANSACTION_SOURCE_NAME, DE.ATTRIBUTE1) DS
   GROUP BY DS.ATTRIBUTE1 HAVING(COUNT(1)>1)
   
SELECT * FROM MTL_MATERIAL_TRANSACTIONS
WHERE ATTRIBUTE1 IN ('CK201410100010');   
