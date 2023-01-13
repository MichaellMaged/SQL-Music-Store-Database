/*Query 01- answering the first insight which is "Most 10 Purcashed Genre & their Sales"*/
SELECT g.Name "Genre",
       Count(il.TrackId) "Purchases Count",
       sum(il.UnitPrice*il.Quantity) "Sales"
FROM Genre g
JOIN Track t on g.GenreId=t.GenreId
join InvoiceLine il on il.TrackId=t.TrackId
group by 1
order by 2 DESC
LIMIT 10;

/*Query 02- answering the second insight which is "Purchases of Top 10 Countries for Most Sold Genre"*/
select t2.Country,
       t2."Purchases Count"
from
    (SELECT i.BillingCountry "Country",
            g.Name "Genre",
            Count(il.TrackId) "Purchases Count"
     from Invoice i
     join InvoiceLine il on i.InvoiceId=il.InvoiceId
     join Track t on il.TrackId=t.TrackId
     JOIN Genre g on t.GenreId=t.GenreId
     group by 1
     ORDER BY 3 DESC)t2
JOIN
    (SELECT g.Name "Genre",
            Count(il.TrackId) "Purchases Count",
            sum(il.UnitPrice*il.Quantity) "Sales"
     FROM Genre g
     JOIN Track t on g.GenreId=t.GenreId
     join InvoiceLine il on il.TrackId=t.TrackId
     group by 1
     order by 2 DESC
     limit 10)t1 on t2."genre"=t1."genre"
group by 1
order by 2 DESC
limit 10;

/*Query 03- answering the Third insight which is "Purchases of Top 10 Countries for Most Sold Genre"*/
SELECT t2.CustomerId "Customer ID",
       t2.FirstName "First Name",
       t2.LastName "last Name",
       t2.art_name "Artist name",
       t2.total_spent "Total Spent"
FROM
    (SELECT c.CustomerId,
            c.FirstName,
            c.LastName,
            a.Name art_name,
            sum(il.UnitPrice*Quantity) as total_spent
     from Customer c
     JOIN Invoice i on c.CustomerId=i.CustomerId
     JOIN InvoiceLine il on i.InvoiceId=il.InvoiceId
     join track t on il.TrackId=t.TrackId
     JOIN Album ab on t.AlbumId=ab.AlbumId
     JOIN Artist a on ab.ArtistId=a.ArtistId
     JOIN genre g on g.GenreId=t.GenreId
     where g.Name =
             (select t3."Genre"
              FROM
                  (SELECT g.Name "Genre",
                          Count(il.TrackId) "Purchases Count",
                          sum(il.UnitPrice*il.Quantity) "Sales"
                   FROM Genre g
                   JOIN Track t on g.GenreId=t.GenreId
                   join InvoiceLine il on il.TrackId=t.TrackId
                   group by 1
                   order by 2 DESC
                   LIMIT 1)t3)
     GROUP BY 1,
              2,
              3,
              4)t2
JOIN
    (SELECT a.Name art_name,
            sum(il.UnitPrice*Quantity) as total_spent
     FROM Artist a
     join Album ab on a.ArtistId=ab.ArtistId
     JOIN Track t on ab.AlbumId=t.AlbumId
     JOIN InvoiceLine il on t.TrackId=il.TrackId
     JOIN Invoice i on il.InvoiceId=i.InvoiceId
     group by 1
     order by 2 DESC
     limit 1)t1 on t2.art_name=t1.art_name
group by 1,
         2,
         3
order by 5 DESC
limit 10 ;

/*Query 04 - answering the Third insight which is "Rranking Sales Employees based on Sales Record"*/
SELECT e.EmployeeId "Employee ID",
       e.FirstName "First Name",
       e.LastName "Last Name",
       count(il.TrackId) Purchases,
       sum(il.UnitPrice*Quantity) Sales
from Employee e
JOIN Customer c on e.EmployeeId=c.SupportRepId
JOIN Invoice i on c.CustomerId=i.CustomerId
join InvoiceLine il on i.InvoiceId=il.InvoiceId
group by 1
order by 4 DESC;