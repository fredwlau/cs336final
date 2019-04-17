<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>End User Account Modification Part2</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the EndUSerAccountModification.jsp
		String Username = request.getParameter("Username");
		String modifyUsername = request.getParameter("modifyUsername");
		String modifyPassword = request.getParameter("modifyPassword");
		String modifyEmail = request.getParameter("modifyEmail");
		String modifyFirstName = request.getParameter("modifyFirstName");
		String modifyLastName = request.getParameter("modifyLastName");
		String modifyPhoneNumber = request.getParameter("modifyPhoneNumber");
		String modifyStreetName = request.getParameter("modifyStreetName");
		String modifyCity = request.getParameter("modifyCity");
		String modifyZipCode = request.getParameter("modifyZipCode");
		String modifyState = request.getParameter("modifyState");
		
		//Pulls username attribute for EndUser Account
		ResultSet r;
		r = stmt.executeQuery("SELECT Username FROM EndUser WHERE Username='" + Username + "'");
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(r.next()){
			result = r.getString("Username");
		}
		
		//Determines if a username belongs to EndUser or not
		if(result == null || result == ""){
			out.println("Username isn't an End User <a href='EndUserAccountModification.jsp'>try again</a>");
			
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
			out.println("New username alread exists, use another one <a href='EndUserAccountModification.jsp'>try again</a>");
			
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
		
		//Pulls the mailing address attributes for a specific username
		ResultSet user;
		user = stmt.executeQuery("SELECT MailStreetName1, MailCity1, MailZipCode1, MailState1 FROM EndUser WHERE Username='" + Username + "'");
		
		//Holds the mailing address primary key attributes
		String MailStreetName = "";
		String MailCity = "";
		String MailZipCode = "";
		String MailState = "";
		
		//Assigns the primary key attributes to variables	
		while(user.next()){
			MailStreetName = user.getString("MailStreetName1");
			MailCity = user.getString("MailCity1");
			MailZipCode = user.getString("MailZipCode1");
			MailState = user.getString("MailState1");
	    } 
		
		//Pulls all attributes for a specific address
		ResultSet address;
		address = stmt.executeQuery("SELECT * FROM Address WHERE StreetName1 ='" + MailStreetName + "'" + " AND City1 ='" + MailCity +  "'" + " AND ZipCode1 ='" + MailZipCode + "'" + " AND State1 ='" + MailState +"'");
		
		//Holds the original attributes
		String originalStreetName = "";
		String originalCity = "";
		String originalZipCode = "";
		String originalState = "";
		
		//Assigns all original attributes to variables	
		while(address.next()){
			originalStreetName = address.getString("StreetName1");
			originalCity = address.getString("City1");
			originalZipCode = address.getString("ZipCode1");
			originalState = address.getString("State1");
	    } 
		
		//If Customer Rep doesn't want to change username
		if(modifyUsername == null || modifyUsername == ""){
			//Uses original attribute
		    modifyUsername = originalUsername;
		}
		
		//If Customer Rep doesn't want to change password
		if(modifyPassword == null || modifyPassword == ""){
			//Uses original attribute
		    modifyPassword = originalPassword;
		}
		
		//If Customer Rep doesn't want to change email
		if(modifyEmail == null || modifyEmail == ""){
			//Uses original attribute
		    modifyEmail = originalEmail;
		}
		
		//If Customer Rep doesn't want to change first name
		if(modifyFirstName == null || modifyFirstName == ""){
			//Uses original attribute
		    modifyFirstName = originalFirstName;
		}
		
		//If Customer Rep doesn't want to change last name
		if(modifyLastName == null || modifyLastName == ""){
			//Uses original attribute
		    modifyLastName = originalLastName;
		}
		
		//If Customer Rep doesn't want to change phone number
		if(modifyPhoneNumber == null || modifyPhoneNumber == ""){
			//Uses original attribute
		    modifyPhoneNumber = originalPhoneNumber;
		} 
		
		
		//If Customer Rep doesn't want to change street name
		if(modifyStreetName == null || modifyStreetName == ""){
			//Uses original attribute
		    modifyStreetName = originalStreetName;
		}
		
		//If Customer Rep doesn't want to change City
		if(modifyCity == null || modifyCity == ""){
			//Uses original attribute
		    modifyCity = originalCity;
		}
		
		//If Customer Rep doesn't want to change zip code
		if(modifyZipCode == null || modifyZipCode == ""){
			//Uses original attribute
		    modifyZipCode = originalZipCode;
		}
		
		//If Customer Rep doesn't want to change State
		if(modifyState == null || modifyState == ""){
			//Uses original attribute
		    modifyState = originalState;
		}
		
		//Check to see if the users mailing address already exists in Mailing Address Table
		rs = stmt.executeQuery("SELECT StreetName1 FROM Address WHERE StreetName1 ='" + modifyStreetName + "'" + " AND City1 ='" + modifyCity + "'" + " AND ZipCode1 ='" + modifyZipCode + "'" + " AND State1 ='" + modifyState + "'");
		
		//Will hold the queries value
		String testStreetName = "";
					
		//Assigns the queries value to attribute
		while(rs.next()){
			testStreetName = rs.getString("StreetName1");
		}
		
		//Only adds an address if it's new
		if(testStreetName == null || testStreetName == ""){
			//Make an insert statement for the Address table:
			String insert1 = "INSERT INTO Address(StreetName1, City1, ZipCode1, State1)"
					+ "VALUES (?, ?, ?, ?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps1 = con.prepareStatement(insert1);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps1.setString(1, modifyStreetName);
			ps1.setString(2, modifyCity);
			ps1.setString(3, modifyZipCode);
			ps1.setString(4, modifyState);
			ps1.executeUpdate();
		}
		
		//Make an update statement for the Account table:
		String updateUser = "UPDATE Account SET Username = ?, PasswordHash = ?, Email = ?, Fname = ?, Lname = ?, PhoneNumber = ? WHERE Username = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps2 = con.prepareStatement(updateUser);

		//Add parameters of the query. Start with 1, the 0-parameter is the UPDATE statement itself
		ps2.setString(1, modifyUsername);
		ps2.setString(2, modifyPassword);
		ps2.setString(3, modifyEmail);
		ps2.setString(4, modifyFirstName);
		ps2.setString(5, modifyLastName);
		ps2.setString(6, modifyPhoneNumber);
		ps2.setString(7, Username);
		ps2.executeUpdate();
		
		//Make an update statement for the Account table:
		String updateEndUser = "UPDATE EndUser SET MailStreetName1 = ?, MailCity1 = ?, MailZipCode1 = ?, MailState1 = ? WHERE Username = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps3 = con.prepareStatement(updateEndUser);

		//Add parameters of the query. Start with 1, the 0-parameter is the UPDATE statement itself
		ps3.setString(1, modifyStreetName);
		ps3.setString(2, modifyCity);
		ps3.setString(3, modifyZipCode);
		ps3.setString(4, modifyState);
		ps3.setString(5, modifyUsername);
		ps3.executeUpdate();
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("End User Account Successfully Updated");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Update End User Account");
	}
%>

<br>
<a href='CustomerRepPage.jsp'>Return to main page</a> 
<br>

</body>