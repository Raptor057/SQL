SELECT TOP (1000) id,part_number,rev,lot,Blocked FROM [APPS].[dbo].[pro_eti001] 
WHERE 
part_number LIKE ('%00555%') --AND 
--id ='' 
order BY created_at DESC