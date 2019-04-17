<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Creation Part 1</title>
</head>
<body>
	<%
	String clothingType = request.getParameter("clothingType");
	
	if(clothingType.equals("Shoes")){
		response.sendRedirect("AuctionCreationPart2Shoes.jsp");
	}
	else if(clothingType.equals("Shirt")){
		response.sendRedirect("AuctionCreationPart2Shirt.jsp");
	}
	else{
		response.sendRedirect("AuctionCreationPart2Pants.jsp");
	}
%>

<br>
<a href='AdminPage.jsp'>Return to main page</a> 
<br>

</body>
</html>