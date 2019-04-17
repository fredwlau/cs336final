<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>End User Email SQL</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the AuctionCreationPart2Shirt.jsp
		String newSubject = request.getParameter("newSubject");
		
		if(newSubject == null || newSubject == ""){
			out.println("Subject can't be empty <a href='EmailEndUser.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newContent = request.getParameter("newContent");
					
		if(newContent == null || newContent == ""){
			out.println("Content can't be empty <a href='EmailEndUser.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String Username = (String)session.getAttribute("user");
		
		//Used to get the current date and time
		Calendar calendar = Calendar.getInstance();
		java.util.Date now = calendar.getTime();
		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
												
		//Make an insert statement for the Emails table:
		String insert1 = "INSERT INTO Emails(EndUserUsername, Subject, Date_Time, Content)"
				+ "VALUES (?, ?, ?, ?)";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(insert1);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps1.setString(1, Username);
		ps1.setString(2, newSubject);
		ps1.setTimestamp(3, currentTimestamp);
		ps1.setString(4, newContent);
		ps1.executeUpdate(); 
					
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Request Successfully Sent"); 
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Send Request");
	}
%>

<br>
<a href='EndUserPage.jsp'>Return to main page</a> 
<br>

</body>
</html>