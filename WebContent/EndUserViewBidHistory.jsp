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
background-color: #DB7093
}
</style>
<Center>
<title>View Bid History</title>
</head>
<body>


<%
	String passedAID = request.getParameter("auction ID");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet myResult;
	int offset = 0;
	String BidID = "";
	String Username = "";
	String Bidprice = "";
	
	//check if exists
	myResult = st.executeQuery("Select AID from AuctionItem where AID='" + passedAID + "'");
	if(myResult.next() == false){
		out.println("Invalid AID");
	}
	//if it does exist grab all its bids
	else{
	
		myResult = st.executeQuery("Select BidID,Username,BidPrice from (select BidID, Username, Bidprice from Bids where AID='" + passedAID +"')as t order by BidPrice");
		if(myResult.next() == false){
			out.println("No bids for that auction<br/>");
		}
		//if it has at least 1 bid, print it
		else{
	   		out.print("BidID");
	   		offset = 20;
	  	 	
	   		while(offset > 0){
	   			out.print("&nbsp;"); offset--;
	   		}
	   		out.print("Username");
			offset = 20;
	  	 	
	   		while(offset > 0){
	   			out.print("&nbsp;"); offset--;
	   		}
	   		out.print("Bidprice<br/>");
	   		
			do{
				
				BidID = myResult.getString("BidID");
				Username = myResult.getString("Username");
				Bidprice = myResult.getString("Bidprice");
			
				offset = 35 - BidID.length() - Username.length();
				out.print(BidID);
				while(offset > 0){out.print("&nbsp;"); offset--;}
				out.print(Username);
				offset = 35 - Bidprice.length() - Username.length();
				while(offset > 0){out.print("&nbsp;"); offset--;}
				out.print(Bidprice + "<br/>");
			
		
			}while(myResult.next());
	
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