<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>End User Account Deletion</title>
</head>
<body>

Please enter username to delete
<br>
	<form method="post" action="EndUserAccountDeletionSQL.jsp">
	<table>
	<tr>    
	<td>Username to delete</td><td><input type="text" name="deleteUsername"></td>
	</tr>
	<tr>    
	</tr>
	</table>
	
	<input type="submit" value="Delete Account">
	</form>
<br>

<br>
	<form method="post" action="CustomerRepPage.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>

</body>
</html>