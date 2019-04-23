<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
body {
background-color: #00FA9A
}
</style>
<Center>
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
		
		//Pulls username attribute for EndUser Account
		ResultSet rs;
		rs = stmt.executeQuery("SELECT Username FROM CustomerRep WHERE Username='" + deleteUsername + "'");
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			result = rs.getString("Username");
		}
		
		//Determines if a username belongs to EndUser or not
		if(result == null || result == ""){
			out.println("Username isn't an  <a href='CustomerRepAccountDeletion.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//String delete = "SELECT Username FROM Account where Username = ?";
		String del1 = "DELETE FROM CustomerRep where Username = ?";
		String delete = "DELETE FROM Account where Username = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(del1);
		PreparedStatement ps2 = con.prepareStatement(delete);

		//ps1.setInt(1);
		//int del = ps1.executeUpdate();
		//System.out.println("Deleted Account:", + del);

					//********************************************************************
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps1.setString(1, deleteUsername);
		ps2.setString(1, deleteUsername);

		out.print("User Account has been successfully deleted");

		
		//ps1.setString(2, deleteUsername);
		ps1.executeUpdate();
		ps2.executeUpdate();

					
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	}
								
	 catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Delete Customer Rep Account");
	 }
%>

<br>
<a href='AdminPage.jsp'>Return to main page</a> 
<br>
</Center>
</body>
</html>