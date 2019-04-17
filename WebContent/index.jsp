<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
</head>
<body>							  
	<% 
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String noneHolder = "none";
		String noneTest ="";
		
		ResultSet rs = stmt.executeQuery("SELECT Username FROM Buyer WHERE Username ='" + noneHolder + "'");
		
		//Flag for account none being in Account table
		boolean noneExists = false;
				
		while(rs.next()){
			noneTest = rs.getString("Username");
		}
		
		//Checks to see if none exists in Account
		if(noneTest != null && noneTest != ""){
			noneExists = true;
		}
		
		//This query finds the AID and secret bid price reserve of auctions that have closed out and the usersnames and maximum bids that were placed on the auction item
		//Does not include Auctions that closed out and had no one that bid on them
		rs = stmt.executeQuery("SELECT AID AS AID3, SecretBidPrice2 AS SecretBidPrice3, BidPrice2 AS BidPrice3, Username AS Username3, ClothingCID2 AS ClothingCID3"
									+	" FROM Bids AS b3,"
									+		" (SELECT AID AS AID2, SecretBidPrice1 AS SecretBidPrice2, ClothingCID1 AS ClothingCID2, MAX(BidPrice) AS BidPrice2" 
									+	 	" FROM Bids AS b2,"
									+			" (SELECT AID AS AID1, SecretBidPrice AS SecretBidPrice1, ClothingCID AS ClothingCID1" 
			     					+			" FROM AuctionItem"
									+			" WHERE CloseOutDateTime < current_timestamp() AND WinnerUsername IS NULL) AS table1"
									+		" WHERE b2.AID = table1.AID1"
									+		" GROUP BY AID2, SecretBidPrice2) AS table2"
									+	" WHERE b3.AID = table2.AID2 AND b3.BidPrice = table2.BidPrice2");
		
		//Will hold the attributes from query
		String auctionAID = "";
		int auctionSecretBidPrice = 0;
		int auctionMaxBid = 0;
		String auctionUsername = "";
		String auctionCID = "";
		
		//Will assign every attribute from the query
		while(rs.next()){
			auctionAID = rs.getString("AID3");
			auctionSecretBidPrice = rs.getInt("SecretBidPrice3");
			auctionMaxBid = rs.getInt("BidPrice3");
			auctionUsername = rs.getString("Username3");
			auctionCID = rs.getString("ClothingCID3");
	
			//Sets the winner of an auction who has the max bid which is equal to or higher than the Secret Bid Price or who placed a bid for 0 while the secret bid price was also 0
			if(auctionMaxBid == 0 && auctionSecretBidPrice == 0 && auctionUsername != null && (!auctionUsername.equals(""))){
				//Updates the winner of an auction
				String update1 = "UPDATE AuctionItem SET WinnerUsername = ?, PriceSoldAt = ? WHERE AID = ?";
						
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query		
				PreparedStatement up1 = con.prepareStatement(update1);
						
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				up1.setString(1, auctionUsername);
				up1.setInt(2, 0);
				up1.setString(3, auctionAID);
				up1.executeUpdate();
			} 
			else if(auctionMaxBid != 0 && auctionSecretBidPrice != 0 && auctionMaxBid >= auctionSecretBidPrice){
				//Updates the winner of an auction
				String update1 = "UPDATE AuctionItem SET WinnerUsername = ?, PriceSoldAt = ? WHERE AID = ?";
						
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query		
				PreparedStatement up1 = con.prepareStatement(update1);
						
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				up1.setString(1, auctionUsername);
				up1.setInt(2, auctionMaxBid);
				up1.setString(3, auctionAID);
				up1.executeUpdate();
				
				//Gets the total sales for the item that was sold
				rs = stmt.executeQuery("SELECT ItemSales FROM Clothing WHERE CID ='" + auctionCID + "'");
						
				int auctionSale = 0;
				int totalSales = 0;
						
				while(rs.next()){
					auctionSale = rs.getInt("ItemSales");
					
					//Adds the winners bid to the item sales number of the clothing item
					totalSales = auctionSale + auctionMaxBid;
				}
				
				//Updates the total sales of clothing table
				String update2 = "UPDATE Clothing SET ItemSales = ? WHERE CID = ?";
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query		
				PreparedStatement up2 = con.prepareStatement(update2);
						
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				up2.setInt(1, totalSales);
				up2.setString(2, auctionCID);
				up2.executeUpdate();
			}
			else{
				if(noneExists == true){
					//Updates the auction winner to default account none because no one bid equal to or over the the secret bid price reserve
					String update1 = "UPDATE AuctionItem SET WinnerUsername = ? WHERE AID = ?";
							
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query		
					PreparedStatement up1 = con.prepareStatement(update1);
							
					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					up1.setString(1, "none");
					up1.setString(2, auctionAID);
					up1.executeUpdate();
				}
			}
		}
		
		//This query finds all the auctions where no one placed any bids
		rs = stmt.executeQuery("SELECT AID FROM AuctionItem WHERE CloseOutDateTime < current_timestamp() AND WinnerUsername IS NULL");
		
		//Will hold the attributes from query
		String noBidAID = "";
		
		if(noneExists == true){
			//Will assign every attribute from the query
			while(rs.next()){
				noBidAID = rs.getString("AID");
		
				//Updates the winner of an auction
				String update2 = "UPDATE AuctionItem SET WinnerUsername = ? WHERE AID = ?";
						
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query		
				PreparedStatement up2 = con.prepareStatement(update2);
						
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				up2.setString(1, "none");
				up2.setString(2, noBidAID);
				up2.executeUpdate();
			}
		}
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("index failed");
	} 	
	%>
	
Register here if you don't have an account
<br>
	<form method="post" action="EndUserAccountCreation.jsp">
	<input type="submit" value="Create Account">
	</form>
<br>


Login here if you have an account
<br>
	<form method="post" action="Login.jsp">
	<input type="submit" value="Login">
	</form>
<br>

</body>
</html>
