/*  (1) the delete/update statements used to change the tables (as in section 5), and
    (2) the queries made (as in section 6), and
    (3) the statements used to create and apply functions, procedures, triggers, and
 */

/* SQL Modifications */

use dkavisen;

INSERT INTO Article (Release_Date, Title, Edition_Title, Edition_Release_date, Topic, View_Count)
VALUES ('2023-01-06', 'Article 11', 'The Times', '2023-01-01', 'Crime', 0);

UPDATE Article
SET View_Count = View_Count + 20
WHERE Title = 'Article 1';


SELECT * FROM editor WHERE Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM editor WHERE  Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
SELECT * FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM reporter WHERE Reporter_id = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM writes WHERE journalist_CPR = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM Journalist
WHERE First_name = 'Jack' AND Last_name = 'Brown';

/* Queries */


SELECT a.Topic,
       (SELECT a2.Title
        FROM Article a2
        WHERE a2.Topic = a.Topic
        ORDER BY a2.View_Count DESC
        LIMIT 1) AS Most_Read_Article,
       MAX(a.View_Count) AS Max_Views
FROM Article a
GROUP BY a.Topic;


SELECT j.First_name, j.Last_name, SUM(a.View_Count) AS Total_Views
FROM Journalist j
         JOIN Writes w ON j.CPR_NUMBER = w.journalist_CPR
         JOIN Article a ON w.article_title = a.Title
    AND w.edition_title = a.Edition_Title
    AND w.edition_release_date = a.Edition_Release_date
GROUP BY j.CPR_NUMBER
ORDER BY Total_Views DESC
LIMIT 10;


SELECT j.First_name, j.Last_name
FROM journalist j
         JOIN reporter r ON j.CPR_NUMBER = r.Reporter_ID
         JOIN image i ON r.Image_Title = i.Title
GROUP BY  j.CPR_NUMBER
HAVING COUNT(r.Image_Title) = 1;


SELECT a.Topic, AVG(a.View_Count) AS Avg_Reads
FROM Article a
GROUP BY a.Topic
HAVING AVG(a.View_Count) < (SELECT AVG(View_Count) FROM Article);


SELECT DISTINCT j.First_name, j.Last_name
FROM Journalist j
         JOIN Writes w ON j.CPR_NUMBER = w.journalist_CPR
         JOIN Article a ON w.article_title = a.Title
    AND w.edition_title = a.Edition_Title
    AND w.edition_release_date = a.Edition_Release_date
         JOIN ArticlePhotos ap ON a.Title = ap.Article_Title
    AND a.Edition_Title = ap.Edition_Title
    AND a.Edition_Release_date = ap.Edition_Release_date
         JOIN Image i ON ap.Image_Title = i.Title
         JOIN Reporter r ON j.CPR_NUMBER = r.Reporter_ID;
