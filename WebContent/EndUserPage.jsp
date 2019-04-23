<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<center>
<style>
body {
background-color: #D3D3D3
}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>End User Account</title>
</head>
<body>							  

Modify your account
<br>
	<form method="post" action="EndUserAccountSelfModification.jsp">
	<input type="submit" value="Modify Account">
	</form>
<br>

Create Auction
<br>
	<form method="post" action="AuctionCreationPart1.jsp">
	<input type="submit" value="Create">
	</form>
<br>

Browse Items 
<br>
	<form method="post" action="BrowseItems.jsp">
	<input type="submit" value="Browse">
	</form>
<br>

Bid on Auction
<br>
	<form method="post" action="AuctionBidding.jsp">
	<input type="submit" value="Bid">
	</form>
<br>

Check Bid/Interest Alerts or Update your Interests
<br>
	<form method="post" action="AuctionBidAlert.jsp">
	<input type="submit" value="Check">
	</form>
<br>

Post a question
<br>
	<form method="post" action="EmailEndUser.jsp">
	<input type="submit" value="Post">
	</form>
<br>

Browse your questions and answers to them
<br>
	<form method="post" action="EmailSearchEndUser.jsp">
	<input type="submit" value="Browse">
	</form>
<br>

View bid history
<br>
	<form method="post" action="EndUserViewBidHistory.jsp">
	<table>
	<tr>    
	<td>AID</td><td><input type="text" name="auction ID"></td>
	</tr>
	</table>
	<input type="submit" value="Check">
	</form>
<br>

View users participation history
<br>
	<form method="post" action="EndUserViewParticipationHistory.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="Username"></td>
	</tr>
	</table>
	<input type="submit" value="Check">
	</form>
<br>

Search similar items
<br>
	<form method="post" action="EndUserSimilarItem.jsp">
	<table>
	<tr>    
	<td>CID</td><td><input type="text" name="CID"></td>
	</tr>
	</table>
	<input type="submit" value="Check">
	</form>
<br>

Log out and return to main page
<br>
	<form method="post" action="EndUserLogout.jsp">
	<input type="submit" value="Logout">
	</form>
<br>

</center>

</body>
</html>
