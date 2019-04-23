<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
body {
background-color: #4169E1
}
</style>
<Center>
<title>View Auction History</title>
</head>
<body>
<%
	
	String passedUsername = request.getParameter("Username");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet myResult;
	int offset = 0;
	String AID = "";
	String CID = "";
	
	//Check if the user exists
	myResult = st.executeQuery("Select Username from Account where Username='" + passedUsername + "'");
	if(myResult.next() == false){
		out.println("Invalid Username");
	}
	//If it does exist, execute code
	else{

		//List of auctions where this user was the seller
		myResult = st.executeQuery("Select AID,ClothingCID from (select AID,ClothingCID from AuctionItem where SellerUsername='"+passedUsername+"')as t order by ClothingCID");
			
		out.print("Account history summary for : " + passedUsername +"<br/> <br/>");	
		if(myResult.next() == false){
			out.println("User has sold no items");
			out.print("<br/>");
		}
		else{
				
	   			out.print("AID");
	   			offset = 10;
	  	 	
	   			while(offset > 0){
	   				out.print("&nbsp;"); offset--;
	   			}
	   			out.print(" ClothingCID");
	   			offset = 8;
		  	 	
	   			while(offset > 0){
	   				out.print("&nbsp;"); offset--;
	   			}
	   			out.print(" Participated as <br/>");
	   		
			do{
				
				
				AID = myResult.getString("AID");
				CID = myResult.getString("ClothingCID");
				offset = 35 - AID.length() - CID.length();
				out.print(AID);
				while(offset > 0){out.print("&nbsp;"); offset--;}
				out.print(CID);
				offset = 10;
				while(offset > 0){out.print("&nbsp;"); offset--;}
				out.print("Seller<br/>");
		
			}while(myResult.next());
	
		}
	
		//List of auctions where this user was a bidder (distinct)
		//Figure if they want specifics on the bids they can do an auction lookup using the AID this will print
		ResultSet myResult2;
		myResult2 = st.executeQuery("Select AID from(select distinct AID from Bids where Username='" +  passedUsername +"')as t order by AID");
		
		out.print("<br/>");
		if(myResult2.next() == false){
			out.println("User has Bid on no items");
		}
		else{
				
			out.print("AID");
   			offset = 10;
  	 	
   			while(offset > 0){
   				out.print("&nbsp;"); offset--;
   			}
   			
   			offset = 30;
	  	 	
   			while(offset > 0){
   				out.print("&nbsp;"); offset--;
   			}
   			out.print(" Participated as <br/>");
			
			do{
				
				AID = myResult2.getString("AID");
				offset = 47 - AID.length();
				out.print(AID);
				while(offset > 0){out.print("&nbsp;"); offset--;}
				out.print("Bidder<br/>");
		
			}while(myResult2.next());
	
		}
	
	}
	con.close();
%>
<br>
Return to main page
<br>
	<form method="post" action="EndUserPage.jsp">
	<input type="submit" value="Return">
	</form>
<br>
</Center>
</body>
</html>