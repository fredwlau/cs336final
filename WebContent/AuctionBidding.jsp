<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction Bidding</title>
</head>
<body>

<br>
	<form method="post" action="AuctionBiddingSQL.jsp">
	<table>
	<tr>    
	<td>Enter Auction AID</td><td><input type="text" name="newAID"></td>
	</tr>
	<tr>    
	<td>Enter Bid Price(Must be an Integer)</td><td><input type="text" name="newBidPrice"></td>
	</tr>
	<tr>    
	<td>Enter Automatic Bid Threshold(Must be an Integer. If left blank will default to 0.)</td><td><input type="text" name="newAutomaticBiddingPrice"></td>
	</tr>
	</table>
	
	<input type="submit" value="Bid on Auction">
	</form>
<br>

<br>
	<form method="post" action="EndUserPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>

</body>
</html>