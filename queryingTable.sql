
-- 1. Find the names of the sailors who have reserved atleast 1 boat
SELECT sname FROM sailors WHERE sailid IN (SELECT sailid FROM reserves GROUP BY sailid HAVING count(sailid)>=1)
-- or
SELECT sname FROM Sailors S,Reserves R WHERE S.Sailid=R.Sailid GROUP BY R.sailid HAVING count(r.sailid)>=1;
--or
select sname
from Sailors
where exists(
  select *
  from Reserves 
  where Sailors.sailid=Reserves.sailid
 );
--or
select Sname
from Sailors JOIN Reserves
where Sailors.sailid = Reserves.sailid
group by Reserves.sailid
having count(Reserves.sailid)>0;
--or
select Sname
from Sailors NATURAL JOIN Reserves
group by sailid
having count(sailid)>0;
  


-- 2. Find the Sid's of sailors who have reseved a red or a green boat
SELECT sailid FROM reserves WHERE bid IN (SELECT bid FROM boats WHERE colour = 'red' OR colour = 'green');
-- or 
SELECT sailid FROM sailors S, reserves R WHERE S.sailid=R.sailid and (colour='red' OR colour='green');

-- 3. Find the Sid's of sailors who have not reseved a boat
SELECT sid FROM sailors WHERE sid NOT IN (SELECT sid FROM reserves);
