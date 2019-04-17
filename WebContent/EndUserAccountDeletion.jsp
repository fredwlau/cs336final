<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>End User Account Deletion</title>
</head>
<body>

The users entire account won't be deleted so certain information can be preserved.
Enter delete along with a number such as delete1 in the change name to box. Make sure the
delete name isn't already used.
<br>
	<form method="post" action="EndUserAccountDeletionSQL.jsp">
	<table>
	<tr>    
	<td>Username to delete</td><td><input type="text" name="deleteUsername"></td>
	</tr>
	<tr>    
	<td>Change name to</td><td><input type="text" name="changeUsername"></td>
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