<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
body {
background-color: #B0C4DE
}
</style>
<Center>
<title>Bid Deletion</title>
</head>
<body>

Remove a Bid From an Auction
<br>
	<form method="post" action="BidDeleteSQL.jsp">
	<table>
	<tr>    
	<td>Bid ID to Delete</td><td><input type="number" name="deleteBid"></td>
	</tr>
	<tr>    
	<td>Auction ID to Delete From</td><td><input type="number" name="auctionID"></td>
	</tr>
	</table>
	
	<input type="submit" value="Delete Bid">
	</form>
<br>

<br>
	<form method="post" action="CustomerRepPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>
</Center>
</body>
</html>