<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
body {
background-color: #B0C4DE
}
</style>
<Center>
<title>CS336 Auction</title>
</head>
<body>
Register here if you don't have an account
<br>
	<form method="post" action="EndUserAccountCreation.jsp">
	<input type="submit" value="Create Account">
	</form>
<br>


Login here if you have an account
<br>
	<form method="post" action="Login.jsp">
	<input type="submit" value="Login">
	</form>
<br>
</Center>
</body>
</html>
