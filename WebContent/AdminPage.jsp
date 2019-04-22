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

<title>Admin Account</title>
</head>
<body>							  

Create a Customer Representative Account
<br>
	<form method="post" action="CustomerRepAccountCreation.jsp">
	<input type="submit" value="Create Account">
	</form>
<br>

Delete a Customer Representative Account
<br>
	<form method="post" action="CustomerRepAccountDeletion.jsp">
	<input type="submit" value="Delete Account">
	</form>
<br>

Modify a Customer Representative Account
<br>
	<form method="post" action="CustomerRepAccountModification.jsp">
	<input type="submit" value="Modify Account">
	</form>
<br>

Generate a sales report
<br>
	<form method="post" action="AdminReportPage.jsp">
	<input type="submit" value="Create Report">
	</form>
<br>

Log out and return to main page
<br>
	<form method="post" action="AdminLogout.jsp">
	<input type="submit" value="Logout">
	</form>
<br>














</center>
</body>
</html>