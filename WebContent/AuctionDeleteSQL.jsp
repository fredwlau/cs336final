<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Delete Part2</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		int deleteAuction = -1;
		//Get parameters from the HTML form at the AuctionDelete.jsp
		deleteAuction = Integer.parseInt(request.getParameter("deleteAuction"));
		
		if(deleteAuction == -1){
			out.println("Auction ID can't be empty <a href='AuctionDelete.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Pulls AID from Auctions
		ResultSet rs;
		rs = stmt.executeQuery("SELECT AID FROM AuctionItem WHERE AID='"+deleteAuction+"'");
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			result = rs.getString("AID");
		}
		
		//Determines if a username belongs to EndUser or not
		if(result == null || result == ""){
			out.println("AID:" + deleteAuction + "is not a valid auction, please try again <a href='AuctionDelete.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Make a delete statement for the Account table:
		String update = "DELETE from AuctionItem WHERE AID = ?";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(update);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps1.setInt(1, deleteAuction);
		ps1.executeUpdate();
					
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Auction Successfully Deleted");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Delete Auction");
	}
%>

<br>
<a href='CustomerRepPage.jsp'>Return to main page</a> 
<br>

</body>
</html>