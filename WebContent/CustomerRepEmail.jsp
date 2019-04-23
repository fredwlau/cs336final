<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<center>

<style>
body {
background-color: #FAFAD2
}
</style>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<p style="font-family:georgia,garamond,serif;font-size:16px;font-style:italic;">

<title>Customer Rep Email SQL</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336auction.cuwrm3eh7ohh.us-east-2.rds.amazonaws.com/CS3362","cs336auction", "cs336auction");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		
		ResultSet rs, rs1, rs2;
		
		String username, csr, subject, dateAndTime, content, originalSubject, originalDT, originalContent;
		
		String CSRUsername = (String)session.getAttribute("user");
		rs1 = stmt1.executeQuery("SELECT * FROM Emails WHERE CustomerRepUsername='"+CSRUsername+"'");
		
		//first list emails that the CSR has responded to
		while(rs1.next()){
			
			//email is a response to another email
			if(rs1.getInt("REF")!= -1){
				int eid = rs1.getInt("REF");
				rs2 = stmt2.executeQuery("SELECT * FROM Emails WHERE EID = '" + eid + "'");
				
				//response email
				username = rs1.getString("EndUserUsername");
				csr = rs1.getString("CustomerRepUsername");
				subject = rs1.getString("Subject");
				dateAndTime = rs1.getString("DATE_TIME");
				content = rs1.getString("Content");
				
				//original email
				rs2.next();
				originalSubject = rs2.getString("Subject");
				originalDT = rs2.getString("DATE_TIME");
				originalContent = rs2.getString("Content");
				
				//output the results
				out.print("<br>");
				out.print("ORIGINAL QUESTION-----------------------------------------------------------------------------------------------");
				out.print("<br>");
				out.print("ORIGINAL DATE AND TIME: " + originalDT);
				out.print("<br>");
				out.print("ORIGINAL SUBJECT: " + originalSubject);
				out.print("<br>");
				out.print("ORIGINAL MESSAGE: " + originalContent);
				out.print("<br>");
				out.print("-------->YOUR RESPONSE-----------------------------------------------------------------------------------------------------------");
				out.print("<br>");
				out.print("-------->FROM: " + username);
				out.print("<br>");
				out.print("-------->DATE AND TIME: " + dateAndTime);
				out.print("<br>");
				out.print("-------->SUBJECT: " + subject);
				out.print("<br>");
				out.print("-------->MESSAGE: " +content);
				out.print("<br>");
				out.print("<br>");		
			}

		}

		rs = stmt.executeQuery("SELECT * FROM Emails WHERE CustomerRepUsername is NULL");

		//unanswered questions
		while(rs.next()){
			int EID = rs.getInt("EID");
			username = rs.getString("EndUserUsername");
			subject = rs.getString("Subject");
			dateAndTime = rs.getString("Date_Time");
			content = rs.getString("Content");
			out.print("UNANSWERED QUESTIONS-----------------------------------------------------------------------------------------------------------");
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
			<td>Type your response:</td>
			</tr>
			<tr>
			<td><textarea rows="4" cols="50" name="newContent"></textarea></td>
			</tr>
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
			<% 
		}

	} catch (Exception ex) {
		out.print(ex);
		out.print("Email retrieval failed");
	}
%>

<br>
<a href='CustomerRepPage.jsp'>Return to main page</a> 
<br>

</p>
</center>
</body>
</html>