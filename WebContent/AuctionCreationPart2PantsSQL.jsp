<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Creation Part 2 Pants SQL</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the AuctionCreationPart2Shirt.jsp
		String type = "Pants";
		String newName = request.getParameter("newName");
		
		if(newName == null || newName == ""){
			out.println("Clothing Name can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newBrand = request.getParameter("newBrand");
					
		if(newBrand == null || newBrand == ""){
			out.println("Brand can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newGender = request.getParameter("newGender");
					
		if(newGender == null || newGender == ""){
			out.println("Gender can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newColor = request.getParameter("newColor");
					
		if(newColor == null || newColor == ""){
			out.println("Color can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newPantsWaist = request.getParameter("newPantsWaist");
					
		if(newPantsWaist == null || newPantsWaist == ""){
			out.println("Pants Waist can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newPantsLength = request.getParameter("newPantsLength");
		
		if(newPantsLength == null || newPantsLength == ""){
			out.println("Pants Length can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newInitialPrice = request.getParameter("newInitialPrice");
					
		if(newInitialPrice == null || newInitialPrice == ""){
			out.println("Initial Price can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newMinBid = request.getParameter("newMinBid");
		
		if(newMinBid == null || newMinBid == ""){
			out.println("Bid Increment can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newSecretBidPrice = request.getParameter("newSecretBidPrice");
		
		if(newSecretBidPrice == null || newSecretBidPrice == ""){
			out.println("Minimum Price can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		String newCloseOutDate = request.getParameter("newCloseOutDate");
		
		if(newCloseOutDate == null || newCloseOutDate == ""){
			out.println("Close Out Date can't be empty <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Will be used to count the number of periods in a string
		int count = 0;
		
		//Checks to make sure a real number is used
		for(int i=0; i<newPantsWaist.length(); i++){
			if(newPantsWaist.charAt(i) < '0' || newPantsWaist.charAt(i) > '9'){
				if(newPantsWaist.charAt(i) == '.' && count == 0){
					count++;
				}
				else{
					out.println("Pants Waist must be a real number <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
					//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
					con.close();

					return;
				}
			}
		}
		
		//Will be used to count the number of periods in a string
		count = 0;
		
		//Checks to make sure only a real number is used
		for(int i=0; i<newPantsLength.length(); i++){
			if(newPantsLength.charAt(i) < '0' || newPantsLength.charAt(i) > '9'){
				if(newPantsLength.charAt(i) == '.' && count == 0){
					count++;
				}
				else{
					out.println("Pants Length must be a real number <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
					//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
					con.close();

					return;
				}
			}
		}
							
		//Checks to make sure only an integer is used
		for(int i=0; i<newInitialPrice.length(); i++){
			if(newInitialPrice.charAt(i) < '0' || newInitialPrice.charAt(i) > '9'){
				out.println("Initial Price must be an integer <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
		}
		
		//Checks to make sure only an integer is used
		for(int i=0; i<newMinBid.length(); i++){
			if(newMinBid.charAt(i) < '0' || newMinBid.charAt(i) > '9'){
				out.println("Bid Increment must be an integer <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
		}
		
		//Checks to make sure only an integer is used
		for(int i=0; i<newSecretBidPrice.length(); i++){
			if(newSecretBidPrice.charAt(i) < '0' || newSecretBidPrice.charAt(i) > '9'){
				out.println("Minimum Sell Price must be an integer <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
		}
		
		//Checks Close Out Date's length to make sure it's correct
		if(newCloseOutDate.length() != 19){
			out.println("Close Out Date must have 19 characters <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Checks to make sure the correct date and time are used
		for(int i=0; i<newCloseOutDate.length(); i++){
			if(i < 4 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '9')){
				out.println("Close Out Date year portion must be in integers <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 4 && newCloseOutDate.charAt(i) != '-'){
				out.println("Close Out Date must contain - after year <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 5 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '1')){
				out.println("Close Out Date month first month number must be between 0 and 1 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 6 && newCloseOutDate.charAt(5) == '0' && newCloseOutDate.charAt(i) == '0'){
				out.println("Close Out Date month can't have 00 months <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 6 && newCloseOutDate.charAt(5) == '1' && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '2')){
				out.println("Close Out Date month second month number must be between 0 and 2 when first month number is 1 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 6 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '9')){
				out.println("Close Out Date month second month number must be an integer <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 7 && newCloseOutDate.charAt(i) != '-'){
				out.println("Close Out Date must contain - after months <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 8 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '3')){
				out.println("Close Out Date day first day number must be between 0 and 3 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 9 && newCloseOutDate.charAt(8) == '0' && newCloseOutDate.charAt(i) == '0'){
				out.println("Close Out Date day can't have 00 days <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if((i == 9 && newCloseOutDate.charAt(8) == '3') && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '1')){
				out.println("Close Out Date day can't have more than 31 days <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if((i == 9 && newCloseOutDate.charAt(8) != '3') && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '9')){
				out.println("Close Out Date day second day number must be between 0 and 9 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 10 && newCloseOutDate.charAt(i) != ' '){
				out.println("Close Out Date must contain a space after days <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 11 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '2')){
				out.println("Close Out Date hours first hour number must be between 0 and 2 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 12 && newCloseOutDate.charAt(11) == '2' && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '3')){
				out.println("Close Out Date hours second hour number must be between 0 and 3 when first hour number is 2 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 12 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '9')){
				out.println("Close Out Date hours second hour number must be and integer <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 13 && newCloseOutDate.charAt(i) != ':'){
				out.println("Close Out Date day must have : after hours portion <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 14 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '5')){
				out.println("Close Out Date minutes first minute number must be and integer between 0 and 5 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 15 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '9')){
				out.println("Close Out Date minutes second minute number must be and integer <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 16 && newCloseOutDate.charAt(i) != ':'){
				out.println("Close Out Date day must have : after minutes portion <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 17 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '5')){
				out.println("Close Out Date seconds first second number must be and integer between 0 and 5 <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
			else if(i == 18 && (newCloseOutDate.charAt(i) < '0' || newCloseOutDate.charAt(i) > '9')){
				out.println("Close Out Date seconds second second number must be and integer <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
				return;
			}
		}
		
		//Used to convert the close out date to datetime
		String datetimeString = request.getParameter("newCloseOutDate");
		Timestamp ts = Timestamp.valueOf(datetimeString);
		
		//Used to get the current date and time
		Calendar calendar = Calendar.getInstance();
		java.util.Date now = calendar.getTime();
		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
		
		if(ts.before(currentTimestamp)){
			out.println("Close Out Date must be the current time and date or in the future <a href='AuctionCreationPart2Pants.jsp'>try again</a>");
					
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//Check Clothing Table to see if name, brand, gender, and color combination already exists
		ResultSet r;
		r = stmt.executeQuery("SELECT CID FROM Clothing WHERE Name ='" + newName + "'" + " AND Brand ='" + newBrand + "'" + " AND Gender ='" + newGender + "'" + " AND Color ='" + newColor + "'");

		//Will hold a CID if a match is found				
		int checkCID = 0;
			
		//Gets a result from previous query				
		while(r.next()){
			checkCID = r.getInt("CID");
		}
		
		//Will hold the CID value of the auto increment
		int lastCID = 0;
				
		//If the clothing combination isn't in the table then it is inserted, else we check the Pants table to see if the same CID, length and waist match
		//If there is no match we insert into both tables, else nothing is inserted.
		if(checkCID == 0){
			//Make an insert statement for the Clothing table:
			String insert1 = "INSERT INTO Clothing(Name, Brand, Gender, Color, Type)"
					+ "VALUES (?, ?, ?, ?, ?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps1 = con.prepareStatement(insert1);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps1.setString(1, newName);
			ps1.setString(2, newBrand);
			ps1.setString(3, newGender);
			ps1.setString(4, newColor);
			ps1.setString(5, type);
			ps1.executeUpdate();
			
			//Pulls the CID of the most recent clothing item that was just inserted
			r = stmt.executeQuery("SELECT last_insert_id() AS CID FROM Clothing");
			
			//Assigns the auto increment number
			while(r.next()){
				lastCID = r.getInt("CID");
			}
			
			//Converts the pants waist string into a float
			float pantsWaistSize = Float.parseFloat(newPantsWaist);
			
			//Converts the pants length string into a float
			float pantsLengthSize = Float.parseFloat(newPantsLength);
								
			//Make an insert statement for the Pants table:
			String insert2 = "INSERT INTO Pants(CID, PantsWaist, PantsLength)"
					+ "VALUES (?, ?, ?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(insert2);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setInt(1, lastCID);
			ps2.setFloat(2, pantsWaistSize);
			ps2.setFloat(3, pantsLengthSize);
			ps2.executeUpdate();	
		}
		else{
			//Pulls the CID 
			r = stmt.executeQuery("SELECT CID FROM Pants WHERE CID ='" + checkCID + "'" + " AND PantsWaist ='" + newPantsWaist + "'" + " AND PantsLength ='" + newPantsLength + "'");
			
			while(r.next()){
				lastCID = r.getInt("CID");
			}
			
			//If there is no entry in the Pants table that matches the users input, then a new row is inserted into Clothing and Pants tables.
			if(lastCID == 0){
				//Converts the pants waist string into a float
				float pantsWaistSize = Float.parseFloat(newPantsWaist);
				
				//Converts the pants length string into a float
				float pantsLengthSize = Float.parseFloat(newPantsLength);
									
				//Make an insert statement for the Pants table:
				String insert2 = "INSERT INTO Pants(CID, PantsWaist, PantsLength)"
						+ "VALUES (?, ?, ?)";
							
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps2 = con.prepareStatement(insert2);

				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps2.setInt(1, checkCID);
				ps2.setFloat(2, pantsWaistSize);
				ps2.setFloat(3, pantsLengthSize);
				ps2.executeUpdate();
				
				//Needed for the CID that's inserted into the Auction Table below this code
				lastCID = checkCID;
			}	
		}
		
		//Holds the username of the person making the auction
		String sellerUsername = (String)session.getAttribute("user");
		
		//Pulls username attribute for Seller Account
		r = stmt.executeQuery("SELECT Username FROM Seller WHERE Username='" + sellerUsername + "'");
				
		//Will hold the query result
		String result = "";
				
		//Assigns the result to a variable
		while(r.next()){
			result = r.getString("Username");
		}
		
		//Used only when the seller isn't in the Seller table
		if(result == null || result == ""){
			//Make an insert statement for the Seller table:
			String insert3 = "INSERT INTO Seller(Username)"
					+ "VALUES (?)";
						
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps3 = con.prepareStatement(insert3);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps3.setString(1, sellerUsername);
			ps3.executeUpdate(); 
		}
		
		//Converts the following strings into integers
		int initialPrice = Integer.parseInt(newInitialPrice);
		int minBid = Integer.parseInt(newMinBid);
		int secretBidPrice = Integer.parseInt(newSecretBidPrice);
												
		//Make an insert statement for the Shoes table:
		String insert4 = "INSERT INTO AuctionItem(InitialPrice, MinBid, SecretBidPrice, CloseOutDateTime, SellerUsername, ClothingCID)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
					
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps4 = con.prepareStatement(insert4);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps4.setInt(1, initialPrice);
		ps4.setInt(2, minBid);
		ps4.setInt(3, secretBidPrice);
		ps4.setTimestamp(4, ts);
		ps4.setString(5, sellerUsername);
		ps4.setInt(6, lastCID);
		ps4.executeUpdate(); 
		
		//sets initial bid so we can display items that dont have bids
		ResultSet re;
		re = stmt.executeQuery("SELECT AID FROM AuctionItem WHERE ClothingCID='" + lastCID + "'");
		
		int new_AID = 0;
		int autobidprice = 0;
		while(re.next()){
			new_AID = re.getInt("AID");
		}
		
		String insert5 = "INSERT INTO Bids(AID, BidPrice, Username, AutomaticBiddingPrice)"
				+ "VALUES (?, ?, ?, ?)";
		PreparedStatement ps5 = con.prepareStatement(insert5);
		
		ps5.setInt(1, new_AID);
		ps5.setInt(2, initialPrice);
		ps5.setString(3, sellerUsername);
		ps5.setInt(4, autobidprice);
		ps5.executeUpdate();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
		String pants = "T";
		String alert_username;
		ResultSet rs;
		rs = stmt.executeQuery("SELECT * FROM Interests WHERE Pants = '" + pants + "'");
		while(rs.next()){
			String alert = "Here is a new auction that we are showing you based on your interest in PANTS";
			String insert6 = "INSERT INTO Alerts(Username, AID, Alert)" + "VALUES(?, ?, ?)";
			alert_username = rs.getString("Username");
			PreparedStatement ps6 = con.prepareStatement(insert6);
			ps6.setString(1, alert_username);
			ps6.setInt(2, new_AID);
			ps6.setString(3, alert);
			ps6.executeUpdate();
		}
		
		con.close();
		out.print("Auction Successfully Created"); 
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Create Auction");
	}
%>


<br>
<a href='EndUserPage.jsp'>Return to main page</a> 
<br>

</body>
</html>