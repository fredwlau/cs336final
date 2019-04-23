<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
body {
background-color: #F5FFFA
}
</style>
<Center>
<title>Report Page</title>
</head>
<body>


Report total earnings
<br>
	<form method="post" action="AdminReportPageSQL.jsp">
	<input type="hidden" name="reportType" value="0">
	<input type="submit" value="Get Report">
	</form>
<br>

Specific item sales
<br>
	<form method="post" action="AdminReportPageSQL.jsp">
	<input type="hidden" name="reportType" value="1">
	<table>
	<tr>    
	<td>itemID</td><td><input type="text" name="itemID"></td>
	</tr>
	</table>
	<input type="submit" value="Get Report">
	</form>
<br>

Total sales by item type
<br>
	<form method="post" action="AdminReportPageSQL.jsp">
	<input type="hidden" name="reportType" value="2">
	<input type="submit" value="Get Report">
	</form>
<br>

User earnings lookup
<br>
	<form method="post" action="AdminReportPageSQL.jsp">
	<input type="hidden" name="reportType" value="3">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="Get Report">
	</form>
<br>

Best selling items
<br>
	<form method="post" action="AdminReportPageSQL.jsp">
	<input type="hidden" name="reportType" value="4">
	<input type="submit" value="Get Report">
	</form>
<br>

Best Buyers
<br>
	<form method="post" action="AdminReportPageSQL.jsp">
	<input type="hidden" name="reportType" value="5">
	<input type="submit" value="Get Report">
	</form>
<br>


Return to admin page
<br>
	<form method="post" action="AdminPage.jsp">
	<input type="submit" value="Return">
	</form>
<br>



</body>
</html>