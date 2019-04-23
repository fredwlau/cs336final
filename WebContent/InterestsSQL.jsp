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
background-color: #00FA9A
}
</style>
<Center>
<title>Interests SQL</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String shirts = request.getParameter("type1");   
		String shoes = request.getParameter("type2");
		String pants = request.getParameter("type3");
		String username = (String)session.getAttribute("user");
		String shirts_sql, shoes_sql, pants_sql;
		String insert_interests = "INSERT INTO Interests(Username, Shirt, Shoes, Pants)" + "VALUES(?, ?, ?, ?)";
		String update_interests = "UPDATE Interests SET Shirt = ?, Shoes = ?, Pants = ? WHERE Username = ?";
		

		if(shirts!=null){
			shirts_sql = "T";
		}
		else{
			shirts_sql = "F";
		}

		if(shoes!=null){
			shoes_sql = "T";
		}
		else{
			shoes_sql = "F";
		}

		if(pants!=null){
			pants_sql = "T";
		}
		else{
			pants_sql = "F";
		}
		
		
		ResultSet rs;
		rs = stmt.executeQuery("SELECT * FROM Interests WHERE Username = '" + username + "'");
		if(rs.next()){
			PreparedStatement ps1 = con.prepareStatement(update_interests);
			ps1.setString(1, shirts_sql);
			ps1.setString(2, shoes_sql);
			ps1.setString(3, pants_sql);
			ps1.setString(4, username);
			ps1.executeUpdate();
			out.print("Your interests were successfully updated");
		}
		else{
			PreparedStatement ps2 = con.prepareStatement(insert_interests);
			ps2.setString(1, username);
			ps2.setString(2, shirts_sql);
			ps2.setString(3, shoes_sql);
			ps2.setString(4, pants_sql);
			ps2.executeUpdate();
			out.print("Your interests were successfully saved");
		}
	
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Send Request");
	}
%>

<br>
<a href='EndUserPage.jsp'>Return to main page</a> 
<br>
</Center>
</body>
</html>