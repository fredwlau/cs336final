<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
body {
background-color: #FFC0CB
}
</style>
<Center>
<title>Auction Creation</title>
</head>
<body>

Choose the type of clothing you want to put up for auction
<br>
	<form method="POST" action="AuctionCreationPart1SQL.jsp">
	<br>
	<input type="radio" name="clothingType" value="Shoes"> Shoes<br>
	<input type="radio" name="clothingType" value="Shirt" checked> Shirt<br>
	<input type="radio" name="clothingType" value="Pants"> Pants
	<br>
	<input type="submit" value="Submit">
	</form>
<br>

<br>
	<form method="post" action="EndUserPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>
</Center>
</body>
</html>