<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Rep Email Reply</title>
</head>
<body>
	<% 
		String username = request.getParameter("username");
		String subject = request.getParameter("subject");
		String dateAndTime = request.getParameter("dateAndTime");
		String content = request.getParameter("content");
		int EID = Integer.parseInt(request.getParameter("EID"));
		out.print("-------------------------------------------------------------------------------------------------------------------------------");
		out.print("<br>");
		out.print("FROM: " + username);
		out.print("<br>");
		out.print("DATE AND TIME: " + dateAndTime);
		out.print("<br>");
		out.print("SUBJECT: " + subject);
		out.print("<br>");
		out.print("MESSAGE: " +content);
		out.print("<br>");
	%>

<br>
	<form method="post" action="CustomerRepEmailReplySQL.jsp">
	<table>
	<tr>    
	<td>Type your response</td><td><input type="text" name="newContent"></td>
	</tr>
	<tr>
	<td><input type="hidden" id="thisField0" name="EID" value="<%=EID%>"></td>
	</tr>
	<tr>
	<td><input type="hidden" id="thisField1" name="EndUsername" value="<%=username%>"></td>
	</tr>
	<tr>
	<td><input type="hidden" id="thisField2" name="subject" value="<%=subject%>"></td>
	</tr>
	</table>
	
	<input type="submit" value="Submit Response">
	</form>
<br>

<br>
	<form method="post" action="CustomerRepEmail.jsp">
	<input type="submit" value="Cancel">
	</form>
<br>

</body>
</html>