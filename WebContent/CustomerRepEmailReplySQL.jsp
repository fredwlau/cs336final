<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Rep Email Reply SQL</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336auction.cuwrm3eh7ohh.us-east-2.rds.amazonaws.com/CS3362","cs336auction", "cs336auction");


		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String EndUsername = request.getParameter("EndUsername");
		String newSubject = "Response to: " + request.getParameter("subject");
		String newContent = request.getParameter("newContent");
		int EID = Integer.parseInt(request.getParameter("EID"));
		int REF = EID;
					
		if(newContent == null || newContent == ""){
			out.println("Content can't be empty <a href='CustomerRepEmailReply.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String CSRUsername = (String)session.getAttribute("user");
		
		//Used to get the current date and time
		Calendar calendar = Calendar.getInstance();
		java.util.Date now = calendar.getTime();
		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
												
		//Make an insert statement for the Emails table:
		String insert1 = "INSERT INTO Emails(EndUserUsername, CustomerRepUsername, Subject, Date_Time, Content, REF)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(insert1);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps1.setString(1, EndUsername);
		ps1.setString(2, CSRUsername);
		ps1.setString(3, newSubject);
		ps1.setTimestamp(4, currentTimestamp);
		ps1.setString(5, newContent);
		ps1.setInt(6, REF);
		ps1.executeUpdate();
		
		String update = "UPDATE Emails SET CustomerRepUsername = ? WHERE EID = ?";
		
		PreparedStatement ps2 = con.prepareStatement(update);
		ps2.setString(1, CSRUsername);
		ps2.setInt(2, EID);
		ps2.executeUpdate();
					
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Response Successfully Sent"); 
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Response Failed to Send");
	}
%>

<br>
<a href='CustomerRepPage.jsp'>Return to main page</a> 
<br>

</body>
</html>