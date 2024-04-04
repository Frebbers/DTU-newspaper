Use dkavisen;

SELECT a.Topic,
(SELECT a2.Title
FROM Article a2
WHERE a2.Topic = a.Topic
ORDER BY a2.View_Count DESC
LIMIT 1) AS Most_Read_Article,
MAX(a.View_Count) AS Max_Views
FROM Article a
GROUP BY a.Topic;





SELECT j.First_name, j.Last_name, SUM(a.View_Count) as Total_Views
FROM Journalist j
JOIN Writes w ON j.CPR_NUMBER = w.journalist_id
JOIN Article a ON w.article_id = a.ID
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
JOIN Writes w ON j.CPR_NUMBER = w.journalist_id
JOIN Article a ON w.article_id = a.ID
JOIN ArticlePhotos ap ON a.ID = ap.Article_id
JOIN Image i ON ap.Image_Title = i.Title
JOIN Reporter r ON j.CPR_NUMBER = r.Reporter_ID;
