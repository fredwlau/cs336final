<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Bid Alert</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Holds the username of the person accessing the alert
		String username = (String)session.getAttribute("user");
		
		//Tries to pull current user's username from Buyer list
		ResultSet rs;
		rs = stmt.executeQuery("SELECT Username FROM Buyer WHERE Username='" + username + "'");
							
		//Will hold the query result
		String testUsername = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			testUsername = rs.getString("Username");
			
		}
		
		//Checks to make sure the current user is in the buyer table
		if(testUsername == null || testUsername == ""){
			out.println("You don't have any alerts <a href='EndUserPage.jsp'>Return to your Account</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//This query finds the username and AID for every max bid of auctions that haven't closed out
		ResultSet rsa = stmt.executeQuery("SELECT DISTINCT Username, AID"
									+	  " FROM Bids,"
									+           " (SELECT AID AS AID1, MAX(BidPrice) AS BidPrice1" 
									+			 " FROM Bids GROUP BY AID1) AS maxTable,"
									+		     " (SELECT AID AS AID2"
									+			 " FROM AuctionItem WHERE CloseOutDateTime > current_timestamp()) AS auctionTable,"
									+ 			 " (SELECT AID AS AID3 FROM Bids WHERE Username ='" + testUsername + "'" + " ) AS userTable"
									+	 " WHERE maxTable.BidPrice1 = BidPrice AND AID = maxTable.AID1 AND auctionTable.AID2 = maxTable.AID1 AND auctionTable.AID2 = AID AND AID = userTable.AID3 AND maxTable.AID1 = userTable.AID3 AND auctionTable.AID2 = userTable.AID3");
		
		//If a user doesn't have an alert this will be used as a flag
		boolean alertFlag = false;
				
		//Finds all the bids where the current user doesn't have a max bid and sends alerts for each auction the person was outbidded on
		while(rsa.next()){
			String currentUsername = rsa.getString("Username");
			int currentAID = rsa.getInt("AID");
			
			if(!username.equals(currentUsername)){
				out.println("You were out bid in auction "+  currentAID);
				alertFlag = true;
				%>
				<br><%
			}
		}	
		
		if(alertFlag == false){
			out.println("You have no alerts");
		}
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("alert failed");
	} 	
%>

<br>
<a href='EndUserPage.jsp'>Return to main page</a> 
<br>

</body>
</html>