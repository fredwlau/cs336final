<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sort Intermediate</title>
</head>
<body>
	<%
	String sortType = request.getParameter("Type");
	
	if(sortType.equals("Name")){
		response.sendRedirect("BrowseItemsSort1.jsp");
	}
	else if(sortType.equals("Brand")){
		response.sendRedirect("BrowseItemsSort2.jsp");
	}
	else if(sortType.equals("Gender")){
		response.sendRedirect("BrowseItemsSort3.jsp");
	}
	else if(sortType.equals("Color")){
		response.sendRedirect("BrowseItemsSort4.jsp");
	}
	else if(sortType.equals("Price")){
		response.sendRedirect("BrowseItemsSort5.jsp");
	}
	else if(sortType.equals("Sales")){
		response.sendRedirect("BrowseItemsSort6.jsp");
	}
	else if(sortType.equals("Type")){
		response.sendRedirect("BrowseItemsSort7.jsp");
	}
%>

<br>
<a href='AdminPage.jsp'>Return to main page</a> 
<br>

</body>
</html>