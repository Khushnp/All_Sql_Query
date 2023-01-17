
CREATE PROCEDURE getAllAuthor
AS  
BEGIN  
    SELECT id,FirstName, LastName,AddedDate,ModifiedDate
    FROM Author1  
    ORDER BY id;  
END;