<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Rep Account Deletion Part2</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the CustomerRepAccountDeletion.jsp
		String deleteUsername = request.getParameter("deleteUsername");
		
		if(deleteUsername == null || deleteUsername == ""){
			out.println("Username can't be empty <a href='CustomerRepAccountDeletion.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String changeUsername = request.getParameter("changeUsername");
		
		if(changeUsername == null || changeUsername == ""){
			out.println("Change username can't be empty <a href='CustomerRepAccountDeletion.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Pulls username attribute for CustomerRep Account
		ResultSet rs;
		rs = stmt.executeQuery("SELECT Username FROM CustomerRep WHERE Username='" + deleteUsername + "'");
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			result = rs.getString("Username");
		}
		
		//Determines if a username belongs to CustomerRep or not
		if(result == null || result == ""){
			out.println("Username isn't a Customer Representative <a href='CustomerRepAccountDeletion.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}

		//Checks to make sure that update username isn't already in the database
		rs = stmt.executeQuery("SELECT Username FROM Account WHERE Username='" + changeUsername + "'");
		
		//Will hold the query result
		String updateResult = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			updateResult = rs.getString("Username");
		}
		
		//Determines if a change username belongs to Account or not
		if(updateResult != null && updateResult != ""){
			out.println("Change Username already exists, choose a different one <a href='CustomerRepAccountDeletion.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Make a delete statement for the Account table:
		String update = "UPDATE Account SET Username = ? WHERE Username = ?";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(update);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps1.setString(1, changeUsername);
		ps1.setString(2, deleteUsername);
		ps1.executeUpdate();
					
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Customer Rep Account Successfully Created");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Create Customer Rep Account");
	}
%>

<br>
<a href='AdminPage.jsp'>Return to main page</a> 
<br>

</body>
</html>