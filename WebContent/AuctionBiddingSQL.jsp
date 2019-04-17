<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*, java.math.*, java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Bidding SQL</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the AuctionBidding.jsp
		String newAID = request.getParameter("newAID");
		
		if(newAID == null || newAID == ""){
			out.println("Auction AID can't be empty <a href='AuctionBidding.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newBidPrice = request.getParameter("newBidPrice");
					
		if(newBidPrice == null || newBidPrice == ""){
			out.println("Bid Price can't be empty <a href='AuctionBidding.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Checks to make sure only an integer is used
		for(int i=0; i<newBidPrice.length(); i++){
			if(newBidPrice.charAt(i) < '0' || newBidPrice.charAt(i) > '9'){
				out.println("Bid Price must be an integer <a href='AuctionBidding.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
		}
		
		String newAutomaticBiddingPrice = request.getParameter("newAutomaticBiddingPrice");
						
		//Flag for automatic bidding
		boolean auto = false;
		
		if(newAutomaticBiddingPrice != null && newAutomaticBiddingPrice != ""){
			//Checks to make sure only an integer is used
			for(int i=0; i<newAutomaticBiddingPrice.length(); i++){
				if(newAutomaticBiddingPrice.charAt(i) < '0' || newAutomaticBiddingPrice.charAt(i) > '9'){
					out.println("Automatic Bid must be an integer <a href='AuctionBidding.jsp'>try again</a>");
					
					//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
					con.close();
					
					return;
				}
			}
			
			auto = true;
		}
		
		//Pulls seller username and close out date from the auctionitem table
		ResultSet rs;
		rs = stmt.executeQuery("SELECT AID, CloseOutDateTime, SellerUsername FROM AuctionItem WHERE AID='" + newAID + "'");
							
		//Will hold the query result
		String testAID = "";
		String sellerUsername = "";
		Timestamp closeOutDateTime = null;
				
		//Assigns the result to a variable
		while(rs.next()){
			testAID = rs.getString("AID");
			sellerUsername = rs.getString("SellerUsername");
			closeOutDateTime = rs.getTimestamp("CloseOutDateTime");
		}
		
		//Checks to make sure the Auction exists
		if(testAID == null || testAID == ""){
			out.println("AID doesn't exist <a href='AuctionBidding.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Used to hold current date and time
		java.util.Date date = new java.util.Date();
		Timestamp current = new Timestamp(date.getTime());
		
		//Checks to make sure the auction isn't past its close out date
		if(closeOutDateTime.before(current)){
			out.println("Auction is past its close out date <a href='AuctionBidding.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Holds the username of the person making the bid
		String buyerUsername = (String)session.getAttribute("user");
					
		
		//Checks to make sure the seller of the auction isn't trying to bid on their own auction
		if(buyerUsername.equals(sellerUsername)){
			out.println("Can't bid on your own auction <a href='AuctionBidding.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Converts the bid price string into a integer
		int bidPrice = Integer.parseInt(newBidPrice);
		
		//Gets the initial bid price and bid increments from AuctionItem table
		rs = stmt.executeQuery("SELECT InitialPrice, MinBid FROM AuctionItem WHERE AID='" + newAID + "'");
		
		//Holds the original attributes
		String origInitialPrice = "";
		int originalMinBid = 0;
		
		//Assigns all original attributes to variables	
		while(rs.next()){
			origInitialPrice = rs.getString("InitialPrice");
			originalMinBid = rs.getInt("MinBid");
	    } 
		
		int originalInitialPrice = Integer.parseInt(origInitialPrice);
		
		//Gets the current bid price from Bids table
		rs = stmt.executeQuery("SELECT MAX(BidPrice) AS BidPrice FROM Bids WHERE AID='" + newAID + "'");
		
		//Holds the original attributes
		String origBidPrice = "";
		
		//Assigns all original attributes to variables	
		while(rs.next()){
			origBidPrice = rs.getString("BidPrice");
	    } 
		
		int originalBidPrice = 0;
		
		if(origBidPrice != null && origBidPrice != ""){
			originalBidPrice = Integer.parseInt(origBidPrice);
		}
		
		
		//Flag for the users bid price being equal to the initial price of the Auction item
		boolean equals = false;
		
		//Used to check if the users bid price equals the initial price of the Auction item
		if(origBidPrice == null || origBidPrice == ""){
			if(newBidPrice.equals(origInitialPrice)){
				equals = true;
			}
		}
		
		//Gets the username of the highest bid
		rs = stmt.executeQuery("SELECT Username FROM Bids WHERE AID='" + newAID + "'" + "AND BidPrice ='" + originalBidPrice + "'");
		
		//Holds the original attributes
		String highestBidUsername = "";
		
		//Assigns all original attributes to variables	
		while(rs.next()){
			highestBidUsername = rs.getString("Username");
	    }
		
		
		//Checks the users bid against the initial price, current bid, and bid increments. Also checks to make sure the bidder doesn't already have the highest bid
		if(originalInitialPrice > bidPrice){
			out.println("Bid Price can't be lower than the initial price of " + originalInitialPrice + " and the current bid price is " + originalBidPrice +  " with minimum bid increments of " + originalMinBid +" <a href='AuctionBidding.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		else if(originalBidPrice >= bidPrice){
			out.println("The initial price is " + originalInitialPrice + " and the Bid Price must be greater than previous bid of " + originalBidPrice + " with minimum bid increments of " + originalMinBid + " <a href='AuctionBidding.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		else if((bidPrice - originalBidPrice < originalMinBid) && equals == false){
			if(originalBidPrice != 0){
				out.println("The Bid Price must be greater than previous bid of " + originalBidPrice + " with mininum bid increments of " + originalMinBid + " <a href='AuctionBidding.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
		}
		else if(highestBidUsername != null && highestBidUsername != "" && highestBidUsername.equals(buyerUsername)){
			out.println("You already have the highest bid, save your money <a href='AuctionBidding.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Pulls username attribute for Buyer Account
		rs = stmt.executeQuery("SELECT Username FROM Buyer WHERE Username='" + buyerUsername + "'");
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(rs.next()){
			result = rs.getString("Username");
		}
		
		//Used only when the buyer isn't in the Buyer table
		if(result == null || result == ""){
			//Make an insert statement for the Buyer table:
			String insert1 = "INSERT INTO Buyer(Username)"
					+ "VALUES (?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps1 = con.prepareStatement(insert1);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps1.setString(1, buyerUsername);
			ps1.executeUpdate(); 
		}
		
		if(auto == false){
			//Make an insert statement for the Bids table:
			String insert2 = "INSERT INTO Bids(AID, BidPrice, Username)"
					+ "VALUES (?, ?, ?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(insert2);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setString(1, newAID);
			ps2.setInt(2, bidPrice);
			ps2.setString(3, buyerUsername);
			ps2.executeUpdate(); 
			
			//Updates all automatic bid entries for a certain user and auction where the older automatic bids are greater than 0
			String update1 = "UPDATE Bids SET AutomaticBiddingPrice = ? WHERE AID = ? AND AutomaticBiddingPrice > ? AND Username = ?";
					
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query		
			PreparedStatement up1 = con.prepareStatement(update1);
					
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			up1.setInt(1, 0);
			up1.setString(2, newAID);
			up1.setInt(3, 0);
			up1.setString(4, buyerUsername);
			up1.executeUpdate(); 
				
		}
		else{
			//Make an insert statement for the Bids table:
			String insert2 = "INSERT INTO Bids(AID, BidPrice, Username, AutomaticBiddingPrice)"
					+ "VALUES (?, ?, ?, ?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(insert2);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setString(1, newAID);
			ps2.setInt(2, bidPrice);
			ps2.setString(3, buyerUsername);
			ps2.setString(4, newAutomaticBiddingPrice);
			ps2.executeUpdate(); 
			
			//Updates all automatic bid entries for a certain user and auction where the new automatic bid is less than older automatic bids
			String update1 = "UPDATE Bids SET AutomaticBiddingPrice = ? WHERE AID = ? AND AutomaticBiddingPrice > ? AND Username = ?";
					
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query		
			PreparedStatement up1 = con.prepareStatement(update1);
					
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			up1.setString(1, newAutomaticBiddingPrice);
			up1.setString(2, newAID);
			up1.setString(3, newAutomaticBiddingPrice);
			up1.setString(4, buyerUsername);
			up1.executeUpdate(); 
		}
		
		//Holds the information of people with the highest autobid and excludes the last person who bid
		rs = stmt.executeQuery("SELECT DISTINCT AID AS AID2, Username AS Username2, AutomaticBiddingPrice AS AutomaticBiddingPrice2" 
							+	" FROM Bids AS b2" 
							+	" WHERE b2.AID ='" + newAID +  "'" + " AND b2.Username <>'" + buyerUsername + "'" + " AND b2.AutomaticBiddingPrice = (SELECT MAX(AutomaticBiddingPrice) AS AutomaticBiddingPrice1" 
																																				+	 " FROM Bids AS b1" 
																																				+	 " WHERE b1.Username <>'" + buyerUsername + "'" + " AND b1.AID ='" + newAID + "'" + " )");
		
		//Will hold the query result
		int maxAID = 0;
		String maxUsername = "";
		int maxAutomaticBiddingPrice = 0;
		
		//Assigns the result to a variable
		while(rs.next()){
			maxAID = rs.getInt("AID2");
			maxUsername = rs.getString("Username2");
			maxAutomaticBiddingPrice = rs.getInt("AutomaticBiddingPrice2");
		}
		
		//If there is no user who has an auto bid price higher than the current bid plus the bid increment then this is skipped
		while(maxAutomaticBiddingPrice != 0 && maxAutomaticBiddingPrice - bidPrice >= originalMinBid){
			//Sets the new bid price to original bid plus the minimum bid increment
			bidPrice = bidPrice + originalMinBid;
			
			//Make an insert statement for the Bids table:
			String insert3 = "INSERT INTO Bids(AID, BidPrice, Username, AutomaticBiddingPrice)"
					+ "VALUES (?, ?, ?, ?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps3 = con.prepareStatement(insert3);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps3.setInt(1, maxAID);
			ps3.setInt(2, bidPrice);
			ps3.setString(3, maxUsername);
			ps3.setInt(4, maxAutomaticBiddingPrice);
			ps3.executeUpdate();
			
			//Holds the information of people with the highest autobid and excludes the last person who bid
			rs = stmt.executeQuery("SELECT DISTINCT AID AS AID2, Username AS Username2, AutomaticBiddingPrice AS AutomaticBiddingPrice2" 
								+	" FROM Bids AS b2" 
								+	" WHERE b2.AID ='" + newAID +  "'" + " AND b2.Username <>'" + maxUsername + "'" + " AND b2.AutomaticBiddingPrice = (SELECT MAX(AutomaticBiddingPrice) AS AutomaticBiddingPrice1" 
																																					+	 " FROM Bids AS b1" 
																																					+	 " WHERE b1.Username <>'" + maxUsername + "'" + " AND b1.AID ='" + newAID + "'" + " )");
			
			//Will hold the query result
			maxAID = 0;
			maxUsername = "";
			maxAutomaticBiddingPrice = 0;
			
			//Assigns the result to a variable
			while(rs.next()){
				maxAID = rs.getInt("AID2");
				maxUsername = rs.getString("Username2");
				maxAutomaticBiddingPrice = rs.getInt("AutomaticBiddingPrice2");
			}
		}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Bid Successfully Posted"); 
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Post Bid");
	} 	
%>

<br>
<a href='EndUserPage.jsp'>Return to main page</a> 
<br>

</body>
</html>