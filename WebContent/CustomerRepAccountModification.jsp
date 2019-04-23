<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
body {
background-color: #FFA500
}
</style>
<Center>
<title>Customer Representative Account Modification</title>
</head>
<body>

<br>
	<form method="post" action="CustomerRepAccountModificationSQL.jsp">
	<table>
	<tr>    
	<td>Enter username of the account you wish to modify</td><td><input type="text" name="Username"></td>
	</tr>
	
	<tr>
	<td></td>
	</tr>

	<tr>
	<td>The following information will be modified if you make changes. 
		If you leave certain boxes blank then that information will not be changed.</td>
	</tr>
	
	<tr>
	<td></td>
	</tr>
	
	<tr>    
	<td>Username</td><td><input type="text" name="modifyUsername"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="modifyPassword"></td>
	</tr>
	<tr>  
	<td>Email</td><td><input type="text" name="modifyEmail"></td>
	</tr>
	<tr>
	<td>First Name</td><td><input type="text" name="modifyFirstName"></td>
	</tr>
	<tr>  
	<td>Last Name</td><td><input type="text" name="modifyLastName"></td>
	</tr>
	<tr>
	<td>Phone Number</td><td><input type="text" name="modifyPhoneNumber"></td>
	</tr>
	<tr>
	</table>
	
	<input type="submit" value="Modify Account">
	</form>
<br>

<br>
	<form method="post" action="AdminPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>
</Center>
</body>
</html>