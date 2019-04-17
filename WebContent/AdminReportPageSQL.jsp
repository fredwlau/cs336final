
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

	

	String flag = request.getParameter("reportType");
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet myResult;
    double sum = 0.0;
    
    
    //total earnings - 
    if(flag.equals("0")){
    	
    	
    	myResult = st.executeQuery("SELECT ItemSales FROM Clothing");
    	
    	while(myResult.next()){
    		sum = sum + myResult.getDouble("ItemSales");
    		
    	}
    	out.println("The total Sales is : " + sum);
       //session.setAttribute("reportFlag", "0");
       // response.sendRedirect("adminReportResult.jsp");
    }
    
    //specific item
    if(flag.equals("1")){
    	
    	
		String itemID = request.getParameter("itemID");
    	myResult = st.executeQuery("SELECT ItemSales FROM Clothing Where CID = '" + itemID + "'");
    	if(myResult.next() == false){
    		out.println("Invalid item ID, try again");
    	}
    	else{
    	sum = myResult.getDouble("itemSales");
    	out.println("The total sales for that item is : " + sum);			
    	}
    }
    
    //the 3 item types
    if(flag.equals("2")){

    	myResult = st.executeQuery("SELECT ItemSales FROM Clothing Where CID IN (SELECT CID FROM Shoes);");
    	sum = 0.0;
    	while(myResult.next()){
    		sum = sum + myResult.getDouble("ItemSales");
    		
    	}
    	out.println("Total sales of Shoes : " + sum + "<br/>");
    	
    	myResult = st.executeQuery("SELECT ItemSales FROM Clothing Where CID IN (SELECT CID FROM Shirt);");
    	sum = 0.0;
    	while(myResult.next()){
    		sum = sum + myResult.getDouble("ItemSales");
    		
    	}
    	out.println("Total sales of Shirts : " + sum + "<br/>");
    	myResult = st.executeQuery("SELECT ItemSales FROM Clothing Where CID IN (SELECT CID FROM Pants);");
    	sum = 0.0;
    	while(myResult.next()){
    		sum = sum + myResult.getDouble("ItemSales");
    		
    	}
    	out.println("Total sales of Pants : " + sum + "<br/>");
    	
    	
    }
    
    //user sales lookup
    if(flag.equals("3")){
	sum = 0.0;
	String username = request.getParameter("username");
	myResult = st.executeQuery("Select PriceSoldAt from AuctionItem where SellerUsername='" + username +"'");
	if(myResult.next() == false){
		out.println("No sales data for that username");
	}
	else{
		do{
		sum = sum + myResult.getDouble("PriceSoldAt");
		}while(myResult.next());
	out.println("The total sales for " + username + " is : " + sum + "<br/>");			
	}
	
    	
    }
    
    //best selling items
    if(flag.equals("4")){
    	
    	
    	String name = "";
    	String brand = "";
    	double itemSales = 0.0;
    	int offset = 0;
    	myResult = st.executeQuery("select Name,Brand, itemSales from Clothing order by itemSales DESC Limit 25");
    	
    	if(myResult.next() == false){
    		out.println("Database is empty");
    	}
    	else{
 	   		out.print("Name");
 	   		offset = 22;
 	  	 	
 	   		while(offset > 0){
 	   			out.print("&nbsp;"); offset--;
 	   		}
 	   		offset = 24;
 	   		out.print("Brand");
	   		while(offset > 0){
	   			out.print("&nbsp;"); offset--;
	   		}
 	   		out.print(" Sales <br/>");
 	   		
    		do{
 				
    			//Grab the name and decimal value from the tuple, determine offset based on side of name and # of digits in purchases, then print
    			name = myResult.getString("Name");
    			brand = myResult.getString("Brand");
    			itemSales = myResult.getDouble("itemSales");
    			offset = 35 - name.length() - brand.length();
    			out.print(name);
    			while(offset > 0){out.print("&nbsp;"); offset--;}
    			out.print(brand);
    			offset = 35 - brand.length() - (Double.toString(itemSales)).length();
    			while(offset > 0){out.print("&nbsp;"); offset--;}
    			out.print(itemSales + "<br/>");
    		}while(myResult.next());
    	
   		}
    	
    	
    }
    
    //best buyers (users with highest purchases)
    if(flag.equals("5")){
    	
    	String uname = "";
    	String totalPurchase ="";
    	int offset = 0;
    	myResult = st.executeQuery("Select distinct WinnerUsername, sum(PriceSoldAt) as S from AuctionItem group by WinnerUsername order by S desc Limit 25");
    	
    	if(myResult.next() == false){
    		out.println("Database is empty");
    	}
    	else{
 	   		out.print("Username");
 	   		offset = 10;
 	  	 	
 	   		while(offset > 0){
 	   			out.print("&nbsp;"); offset--;
 	   		}
 	   		out.print(" TotalPurchases <br/>");
 	   		
    		do{
 				
    			//Grab the name and decimal value from the tuple, determine offset based on side of name and # of digits in purchases, then print
    			uname = myResult.getString("WinnerUsername");
    			totalPurchase = myResult.getString("S");
    			if(!uname.equals("none")){
    			if(totalPurchase == null){totalPurchase="0.0";}
    			offset = 35 - uname.length() - totalPurchase.length();
    			out.print(uname);
    			while(offset > 0){out.print("&nbsp;"); offset--;}
    			out.print(totalPurchase + "<br/>");
    			}
    		}while(myResult.next());
    	
   		}

    
    }
    

	con.close();
%>
<br>
Return to Report page
<br>
	<form method="post" action="AdminReportPage.jsp">
	<input type="submit" value="Return">
	</form>
<br>

<body>
</html>