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
<title>Customer Rep Account</title>
</head>
<body>							  

Remove Auction
<br>
	<form method="post" action="AuctionDelete.jsp">
	<input type="submit" value="Remove Auction">
	</form>
<br>

Remove Bid from Auction
<br>
	<form method="post" action="BidDelete.jsp">
	<input type="submit" value="Remove Bid">
	</form>
<br>

Check Email
<br>
	<form method="post" action="CustomerRepEmail.jsp">
	<input type="submit" value="Check Email">
	</form>
<br>

Delete an End User Account
<br>
	<form method="post" action="EndUserAccountDeletion.jsp">
	<input type="submit" value="Delete Account">
	</form>
<br>

Modify an End User Account
<br>
	<form method="post" action="EndUserAccountModification.jsp">
	<input type="submit" value="Modify Account">
	</form>
<br>

Log out and return to main page
<br>
	<form method="post" action="CustomerRepLogout.jsp">
	<input type="submit" value="Logout">
	</form>
<br>
</center>
</body>
</html>