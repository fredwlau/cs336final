<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>End User Email</title>
</head>
<body>

<br>
	<form method="post" action="EmailEndUserSQL.jsp">
	<table>
	<tr>    
	<td>Enter the subject of your question</td><td><input type="text" name="newSubject"></td>
	</tr>
	<tr>    
	<td>Put your question here</td><td><input type="text" name="newContent"></td>
	</tr>
	</table>
	
	<input type="submit" value="Submit Question">
	</form>
<br>

<br>
	<form method="post" action="EndUserPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>

</body>
</html>