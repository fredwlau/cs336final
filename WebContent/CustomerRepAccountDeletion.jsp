<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Representative Account Deletion</title>
</head>
<body>

Please enter CSR username to delete
<br>
	<form method="post" action="CustomerRepAccountDeletionSQL.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="deleteUsername"></td>
	</tr>
	<tr>    
	</tr>
	</table>
	
	<input type="submit" value="Delete Account">
	</form>
<br>

<br>
	<form method="post" action="AdminPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>

</body>
</html>