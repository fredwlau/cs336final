<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Creation</title>
</head>
<body>

<br>
	<form method="post" action="EndUserAccountCreationSQL.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="newUsername"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="newPassword"></td>
	</tr>
	<tr>  
	<td>Email</td><td><input type="text" name="newEmail"></td>
	</tr>
	<tr>
	<td>First Name</td><td><input type="text" name="newFirstName"></td>
	</tr>
	<tr>  
	<td>Last Name</td><td><input type="text" name="newLastName"></td>
	</tr>
	<tr>
	<td>Phone Number</td><td><input type="text" name="newPhoneNumber"></td>
	</tr>
	<tr>
	
	<tr>
	<td></td>
	</tr>

	<tr>
	<td>Mailing Address</td>
	</tr>
	
	<tr>
	<td></td>
	</tr>
	
	<tr>
	<td>Street Name</td><td><input type="text" name="newStreetName"></td>
	</tr>
	<tr>
	<td>City</td><td><input type="text" name="newCity"></td>
	</tr>
	<tr>
	<td>ZipCode</td><td><input type="text" name="newZipCode"></td>
	</tr>
	<tr>
	<td>State</td><td><input type="text" name="newState"></td>
	</tr>
	</table>
	
	<input type="submit" value="Create Account">
	</form>
<br>

<br>
	<form method="post" action="index.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>

</body>
</html>