Use dkavisen;
SELECT * from writes;

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
JOIN image i ON r.Image_ID = i.ID
GROUP BY  j.CPR_NUMBER
HAVING COUNT(r.Image_ID) = 1;

SELECT DISTINCT j.First_name, j.Last_name
FROM Journalist j
JOIN Writes w ON j.CPR_NUMBER = w.journalist_id
JOIN Article a ON w.article_id = a.ID
JOIN ArticlePhotos ap ON a.ID = ap.Article_id
JOIN Image i ON ap.img_id = i.ID
JOIN Reporter r ON j.CPR_NUMBER = r.Reporter_ID;
