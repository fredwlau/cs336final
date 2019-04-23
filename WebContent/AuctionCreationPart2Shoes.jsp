<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
body {
background-color: #DDA0DD
}
</style>
<Center>
<title>Auction Creation Shoes</title>
</head>
<body>

Enter Clothing Information
<br>
	<form method="post" action="AuctionCreationPart2ShoesSQL.jsp">
	<table>
	<tr>    
	<td>Clothing Name</td><td><input type="text" name="newName"></td>
	</tr>
	<tr>
	<td>Brand</td><td><input type="text" name="newBrand"></td>
	</tr>
	<tr>  
	<td>Gender (M/F)</td><td><input type="text" name="newGender"></td>
	</tr>
	<tr>
	<td>Color</td><td><input type="text" name="newColor"></td>
	</tr>
	<tr>
	<td>Foot Size (Must be a real number such as 8.5)</td><td><input type="text" name="newFootSize"></td>
	</tr>
	</table>
	
	<br>
	Enter Auction Information
	
	<br>
	
	<table>
	<tr>    
	<td>Initial Price(Must be an integer)</td><td><input type="text" name="newInitialPrice"></td>
	</tr>
	<tr>
	<td>Bid Increment(Must be an integer)</td><td><input type="text" name="newMinBid"></td>
	</tr>
	<tr>  
	<td>Minimum Sell Price(Must be an integer)</td><td><input type="text" name="newSecretBidPrice"></td>
	</tr>
	<tr>
	<td>Close Out Date(YYYY-MM-DD HH:MI:SS)</td><td><input type="text" name="newCloseOutDate"></td>
	</tr>
	</table>
	
	<input type="submit" value="Create Auction">
	</form>
<br>

<br>
	<form method="post" action="EndUserPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>

</body>
</html>