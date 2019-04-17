<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Creation Part 2</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the CreateAccount.jsp
		String newUsername = request.getParameter("newUsername");
		
		if(newUsername == null || newUsername == ""){
			out.println("Username can't be empty <a href='CustomerRepAccountCreation.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//This query tries to find an account with the same username
		ResultSet rs = stmt.executeQuery("SELECT Username FROM Account WHERE Username ='" + newUsername + "'");
		
		//Will hold the query attribute
		String testUsername ="";
					
		while(rs.next()){
			testUsername = rs.getString("Username");
			
			if(testUsername.equals(newUsername)){
				out.println("This username is already used, try another <a href='CustomerRepAccountCreation.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
		}
		
		String newPassword = request.getParameter("newPassword");
					
		if(newPassword == null || newPassword == ""){
			out.println("Password can't be empty <a href='CustomerRepAccountCreation.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newEmail = request.getParameter("newEmail");
					
		if(newEmail == null || newEmail == ""){
			out.println("Email can't be empty <a href='CustomerRepAccountCreation.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newFirstName = request.getParameter("newFirstName");
					
		if(newFirstName == null || newFirstName == ""){
			out.println("First Name can't be empty <a href='CustomerRepAccountCreation.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newLastName = request.getParameter("newLastName");
					
		if(newLastName == null || newLastName == ""){
			out.println("Last Name can't be empty <a href='CustomerRepAccountCreation.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newPhoneNumber = request.getParameter("newPhoneNumber");
		
		//Make an insert statement for the Account table:
		String insert1 = "INSERT INTO Account(Username, PasswordHash, Email, Fname, Lname, PhoneNumber)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(insert1);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps1.setString(1, newUsername);
		ps1.setString(2, newPassword);
		ps1.setString(3, newEmail);
		ps1.setString(4, newFirstName);
		ps1.setString(5, newLastName);
		ps1.setString(6, newPhoneNumber);
		ps1.executeUpdate();
					
		//Make an insert statement for the CustomerRep table:
		String insert2 = "INSERT INTO CustomerRep(Username)"
				+ "VALUES (?)";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps2 = con.prepareStatement(insert2);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps2.setString(1, newUsername);
		ps2.executeUpdate();
					
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