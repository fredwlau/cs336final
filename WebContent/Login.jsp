<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
</head>
<body>
<style>
body {
background-color: #d24dff
}
</style>

<center>

<br>
	<form method="post" action="LoginSQL.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="Login">
	</form>
<br>

<br>
	<form method="post" action="index.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>
</center>


</body>
</html>