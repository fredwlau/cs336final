<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
body {
background-color: #FFE4E1
}
</style>
<Center>
<title>End User Email</title>
</head>
<body>


<link href="../_css/site.css" rel="stylesheet">

<br>
	<form method="post" action="EmailEndUserSQL.jsp">
	<table>
	<tr>    
	<td>Enter the subject of your question </td><td><input type="text" name="newSubject"></td>
	</tr>
	<tr>    
	<td>Put your question here</td><td><textarea rows="4" cols="50" name="newContent"></textarea></td>
	</tr>
	</table>
	
	<input type="submit" value="Submit Question">
	</form>
<br>


</Center>
</body>
</html>