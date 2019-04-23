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
background-color: #FF4500
}
</style>
<Center>
<title>Customer Rep Account Modification Part2</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the CustomerRepAccountModification.jsp
		String Username = request.getParameter("Username");
		String modifyUsername = request.getParameter("modifyUsername");
		String modifyPassword = request.getParameter("modifyPassword");
		String modifyEmail = request.getParameter("modifyEmail");
		String modifyFirstName = request.getParameter("modifyFirstName");
		String modifyLastName = request.getParameter("modifyLastName");
		String modifyPhoneNumber = request.getParameter("modifyPhoneNumber");
		
		//Pulls username attribute for CustomerRep Account
		ResultSet r;
		r = stmt.executeQuery("SELECT Username FROM CustomerRep WHERE Username='" + Username + "'");
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(r.next()){
			result = r.getString("Username");
		}
		
		//Determines if a username belongs to CustomerRep or not
		if(result == null || result == ""){
			out.println("Username isn't a Customer Representative <a href='CustomerRepAccountModification.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Quries the modified username so we can see if it already exists
		r = stmt.executeQuery("SELECT Username FROM Account WHERE Username ='" + modifyUsername + "'");
		
		//will hold the query result
		String modTest = "";
					
		//Assigns the result to a variable
		while(r.next()){
			modTest = r.getString("Username");
		}
		
		//Determines if the new username is already being used
		if(modTest != null && modTest != ""){
			out.println("New username alread exists, use another one <a href='CustomerRepAccountModification.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}

		//Pulls all attributes for a specific username
		ResultSet rs;
		rs = stmt.executeQuery("SELECT * FROM Account WHERE Username='" + Username + "'");
		
		//Holds the original attributes
		String originalUsername = "";
		String originalPassword = "";
		String originalEmail = "";
		String originalFirstName = "";
		String originalLastName = "";
		String originalPhoneNumber = "";
		
		//Assigns all original attributes to variables	
		while(rs.next()){
			originalUsername = rs.getString("Username");
			originalPassword = rs.getString("PasswordHash");
			originalEmail = rs.getString("Email");
			originalFirstName = rs.getString("Fname");
			originalLastName = rs.getString("Lname");
			originalPhoneNumber = rs.getString("PhoneNumber");
	    } 
		
		//If admin doesn't want to change username
		if(modifyUsername == null || modifyUsername == ""){
			//Uses original attribute
		    modifyUsername = originalUsername;
		}
		
		//If admin doesn't want to change password
		if(modifyPassword == null || modifyPassword == ""){
			//Uses original attribute
		    modifyPassword = originalPassword;
		}
		
		//If admin doesn't want to change email
		if(modifyEmail == null || modifyEmail == ""){
			//Uses original attribute
		    modifyEmail = originalEmail;
		}
		
		//If admin doesn't want to change first name
		if(modifyFirstName == null || modifyFirstName == ""){
			//Uses original attribute
		    modifyFirstName = originalFirstName;
		}
		
		//If admin doesn't want to change last name
		if(modifyLastName == null || modifyLastName == ""){
			//Uses original attribute
		    modifyLastName = originalLastName;
		}
		
		//If admin doesn't want to change phone number
		if(modifyPhoneNumber == null || modifyPhoneNumber == ""){
			//Uses original attribute
		    modifyPhoneNumber = originalPhoneNumber;
		} 
		
		//Make an update statement for the Account table:
		String updateUsername = "UPDATE Account SET Username = ?, PasswordHash = ?, Email = ?, Fname = ?, Lname = ?, PhoneNumber = ? WHERE Username = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(updateUsername);

		//Add parameters of the query. Start with 1, the 0-parameter is the UPDATE statement itself
		ps1.setString(1, modifyUsername);
		ps1.setString(2, modifyPassword);
		ps1.setString(3, modifyEmail);
		ps1.setString(4, modifyFirstName);
		ps1.setString(5, modifyLastName);
		ps1.setString(6, modifyPhoneNumber);
		ps1.setString(7, Username);
		ps1.executeUpdate();
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Account Successfully Updated");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Update Account");
	}
%>

<br>
<a href='AdminPage.jsp'>Return to main page</a> 
<br>
</Center>
</body>