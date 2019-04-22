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
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		
		ResultSet rs, rs1, rs2;
		
		String username, subject, dateAndTime, content, originalSubject, originalDT, originalContent;
		int EID;
		
		String CSRUsername = (String)session.getAttribute("user");
		rs1 = stmt1.executeQuery("SELECT * FROM Emails WHERE CustomerRepUsername='"+CSRUsername+"'");
		//first list emails that the CSR has responded to
		while(rs1.next()){
			username = rs1.getString("EndUserUsername");
			subject = rs1.getString("Subject");
			dateAndTime = rs1.getString("Date_Time");
			content = rs1.getString("Content");
			//CSR Response Email, parse the original subject and query that email
			if(subject.length()>=12 && subject.charAt(11)==':'){
				originalSubject = subject.substring(13);
				rs2 = stmt2.executeQuery("SELECT * FROM Emails WHERE EndUserUsername='"+username+"' AND Subject='"+originalSubject+"'");
				rs2.next();
				originalDT=rs2.getString("Date_Time");
				originalContent=rs2.getString("Content");
				out.print("ORIGINAL QUESTION-----------------------------------------------------------------------------------------------");
				out.print("<br>");
				out.print('\n');
				out.print('\n');
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
				out.print('\n');
				out.print("-------->MESSAGE: " +content);
				out.print("<br>");
				out.print("<br>");
				out.print('\n');
				out.print('\n');
				}
			else{
				continue;
			}
		}
		
		rs = stmt.executeQuery("SELECT * FROM Emails WHERE CustomerRepUsername is NULL");
		
		//unanswered questions
		while(rs.next()){
			EID = rs.getInt("EID");
			username = rs.getString("EndUserUsername");
			subject = rs.getString("Subject");
			dateAndTime = rs.getString("Date_Time");
			content = rs.getString("Content");
			out.print("UNANSWERED QUESTIONS-----------------------------------------------------------------------------------------------------------");
			out.print('\n');
			out.print('\n');
			out.print("<br>");
			out.print("FROM: " + username);
			out.print("<br>");
			out.print("DATE AND TIME: " + dateAndTime);
			out.print("<br>");
			out.print("SUBJECT: " + subject);
			out.print("<br>");
			out.print("MESSAGE: " +content);
			out.print("<br>");
			out.print("<form method=\"post\" action=\"CustomerRepEmailReply.jsp\">");
			out.print("<input type=\"hidden\" id=\"thisField\" name=\"EID\" value=" + EID + ">");
			out.print("<input type=\"hidden\" id=\"thisField0\" name=\"username\" value=" + username + ">");
			out.print("<input type=\"hidden\" id=\"thisField1\" name=\"subject\" value=" + subject + ">");
			out.print("<input type=\"hidden\" id=\"thisField2\" name=\"dateAndTime\" value=" + dateAndTime + ">");
			out.print('\n');
			out.print("<input type=\"hidden\" id=\"thisField3\" name=\"content\" value=" + content + ">");
			out.print("<input type=\"submit\" value=\"Reply\">");
			out.print("</form>");
			out.print("<br>");
			out.print('\n');
			out.print('\n');

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