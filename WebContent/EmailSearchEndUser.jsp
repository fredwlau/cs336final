<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
body {
background-color: #EEE8AA
}
</style>
<Center>
<title>Email Search End User</title>
</head>

<P ALIGN=CENTER>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();
		
		//Holds the username of the person accessing the alert
		String username = (String)session.getAttribute("user");
		
		//Tries to pull all emails for the current user
		ResultSet rs, rs1;
		rs = stmt.executeQuery("SELECT * FROM Emails WHERE EndUserUsername='" + username + "'"); 
							
		//Will hold the query result
		String testUsername = "";
		String from, subject, dateAndTime, content, originalSubject;
				
		//Assigns the result to a variable
		while(rs.next()){
			testUsername = rs.getString("EndUserUsername");
			subject = rs.getString("Subject");
			from = rs.getString("CustomerRepUsername");
			if(rs.wasNull()){
				from = "";
			}
			dateAndTime = rs.getString("Date_Time");
			content = rs.getString("Content");
			if(from.equals("")){
				out.print("UNANSWERED QUESTION------------------------------------------------------------------------------------------");
				out.print("<br>");
				out.print("DATE AND TIME: " + dateAndTime);
				out.print("<br>");
				out.print("SUBJECT: " + subject);
				out.print("<br>");
				out.print("MESSAGE: " +content);
				out.print("<br>");
				out.print("<br>");
				continue;
			}

			else{
				//if subject length is less then 12 it CANNOT be a response
				if(subject.length()>=12){
					//it is a response
					if(subject.charAt(11) == ':'){
						originalSubject = subject.substring(13);
						String originalDT, originalContent;
						rs1 = stmt1.executeQuery("SELECT * FROM Emails WHERE EndUserUsername='"+username+"' AND CustomerRepUsername='"+from+"' AND Subject='"+originalSubject+"'");
						rs1.next();
						originalDT = rs1.getString("Date_Time");
						originalContent = rs1.getString("Content");
						out.print("ORIGINAL QUESTION-----------------------------------------------------------------------------------------------");
						out.print("<br>");
						out.print("ORIGINAL DATE AND TIME: " + originalDT);
						out.print("<br>");
						out.print("ORIGINAL SUBJECT: " + originalSubject);
						out.print("<br>");
						out.print("ORIGINAL MESSAGE: " + originalContent);
						out.print("<br>");
						out.print("-------->RESPONSE-----------------------------------------------------------------------------------------------------");
						out.print("<br>");
						out.print("-------->FROM: " + from);
						out.print("<br>");
						out.print("-------->DATE AND TIME: " + dateAndTime);
						out.print("<br>");
						out.print("-------->SUBJECT: " + subject);
						out.print("<br>");
						out.print("-------->MESSAGE: " +content);
						out.print("<br>");
						out.print("<br>");
						continue;
					}
				}
				else{
					continue;
				}
			}
		}
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("alert failed");
	} 	
%>
</P>
<br>
<a href='EndUserPage.jsp'>Return to main page</a> 
<br>
</Center>
</body>
</html>