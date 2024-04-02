Use dkavisen;

SELECT a.Title AS Article_Title, MAX(a.View_Count) AS Views, a.Topic
FROM Article a
JOIN Writes w ON a.ID = w.article_id
JOIN Journalist j ON w.journalist_id = j.CPR_NUMBER
JOIN ArticlePhotos ap ON a.ID = ap.Article_id
JOIN Image i ON ap.Image_Title = i.Title
JOIN Reporter r ON j.CPR_NUMBER = r.Reporter_ID
JOIN Edition e ON r.Image_Title = e.Edition_ID
JOIN Newspaper n ON e.Newspaper_Title = n.Title
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
