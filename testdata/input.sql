SELECT NULL, NULL, NULL, COUNT( * ) AS Cnt
FROM Customers
WHERE State IN ( 'MB' , 'KS' )
   UNION ALL
SELECT City, State, NULL, COUNT( * ) AS Cnt
FROM Customers
WHERE State IN ( 'MB' , 'KS' )
GROUP BY City, State
   UNION ALL
SELECT NULL, NULL, CompanyName, COUNT( * ) AS Cnt
FROM Customers
WHERE State IN ( 'MB' , 'KS' )
GROUP BY CompanyName;

DELETE FROM student
   WHERE sno IN 
    (SELECT sno FROM student GROUP BY sno HAVING COUNT(*) > 1)
   AND ROWID NOT IN
    (SELECT MIN(ROWID) FROM student GROUP BY sno 
     HAVING COUNT(*) > 1);
     
update t1 
set a= (select a from t2 where t1.c= t2.c ) , 
    b =(select b from t2 where t1.c= t2.c)  
    where  t1.c  in (select c from t2);
