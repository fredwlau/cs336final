<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Auction Delete</title>
</head>
<body>

This auction will be deleted
<br>
	<form method="post" action="AuctionDeleteSQL.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="number" name="deleteAuction"></td>
	</tr>
	</table>
	
	<input type="submit" value="Delete Auction">
	</form>
<br>

</body>
</html>