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
background-color: #B0C4DE
}
</style>
<Center>
<title>Bid Deletion Part2</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336auction.cuwrm3eh7ohh.us-east-2.rds.amazonaws.com/CS3362","cs336auction", "cs336auction");


		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the BidDelete.jsp
		int deleteBid = -1;
		deleteBid = Integer.parseInt(request.getParameter("deleteBid"));
		
		if(deleteBid == -1){
			out.println("Bid ID can't be empty <a href='BidDelete.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		int auctionID = -1;
		auctionID = Integer.parseInt(request.getParameter("auctionID"));
		
		if(auctionID == -1){
			out.println("Must enter an auction ID <a href='BidDelete.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		

		ResultSet rs;
		rs = stmt.executeQuery("SELECT AID FROM AuctionItem WHERE AID=" + auctionID);
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			result = rs.getString("AID");
		}
		

		if(result == null || result == ""){
			out.println("Invalid Auction <a href='BidDelete.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		

		rs = stmt.executeQuery("SELECT BidID FROM Bids WHERE AID='"+auctionID+"' AND BidID='"+deleteBid+"'");
		
		//Will hold the query result
		String updateResult = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			updateResult = rs.getString("BidID");
		}
		

		if(updateResult != null && updateResult != ""){
			out.println("Invalid Bid ID <a href='BidDelete.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		

		String update = "DELETE FROM Bids WHERE BidID ='"+deleteBid+"' AND AID ='"+auctionID+"'";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps1 = con.prepareStatement(update);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		//ps1.setInt(1, deleteBid);
		//ps1.setInt(2, auctionID);
		ps1.executeUpdate();
					
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Bid Successfully Deleted");
		
	} 
	catch (NumberFormatException e){
		out.print("Must enter a number for auction ID and bid ID <a href='BidDelete.jsp'>try again</a>");
	}
	catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Delete Bid");
	}
%>

<br>
<a href='CustomerRepPage.jsp'>Return to main page</a> 
<br>
</Center>
</body>
</html>