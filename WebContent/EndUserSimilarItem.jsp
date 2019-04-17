<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>End User Similiar Item Search</title>
</head>
<body>

<%

	String CID = request.getParameter("CID");
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet myResult;
    int offset = 0;
    String name ="", brand="", color="", sellPrice="";
    String type = "none";
    
    //The query got huge, just going to check each sub table to find out the item type for the master query
    myResult = st.executeQuery("Select * from Shoes where CID ='"+ CID + "'");
    if(myResult.next() == false){
    	myResult = st.executeQuery("Select * from Shirt where CID ='"+ CID + "'");
    	if(myResult.next() == false){
    		
    		myResult = st.executeQuery("Select * from Pants where CID ='"+ CID + "'");
    		//If all 3 checks returned nothing, then that CID doesnt exist in the database
    		if(myResult.next() == false){
    			type = "none";
    		}
    		
    		else{type = "Pants";}
    	}
    	else{type = "Shirt";}
    }
    else{type = "Shoes";}
    
  
    if(type.equals("none")){
    	out.print("The CID entered is not valid");
    }
    else{
    //Get the information of the item we are comparing to
    myResult = st.executeQuery("Select * from Clothing where CID='"+CID+"'");
    myResult.next();
	brand = myResult.getString("Brand");
	color = myResult.getString("Color");
    String gender = myResult.getString("Gender");
    //Get all items that  Closed out in the last month,  Have a >0 sale price thus actually sold and didnt fail to reach the min bid
    //Then join it to the clothing table so that each tuple has both the auction and clothing data
    //Then filter out non matching genders, figure people who look up womens clothing dont want mens clothing
    //final filter such that the remainder shares either a brand or a color, this is the "similarity" of items
    myResult = st.executeQuery("select * from (select * from (select * from(select * from (Select * from(Select * from AuctionItem where CloseOutDateTime between (curdatE() - interval 1 month) and curdate())as t where PriceSoldAt>0) as t2 join Clothing on t2.ClothingCID=Clothing.CID) as t3 where Gender='"+gender+"') as t4 where (Brand='"+brand+"' OR Color='"+color+"')) as t5 where t5.CID in (select CID from " +type+ ") order by PriceSoldAt desc");
  
  
   	
  	 	if(myResult.next() == false){
			out.println("No similar items sold in the last month");
		}
		//If it does exist, execute code
		else{
			
			out.print("Similar item summary for CID : " + CID +"<br/> <br/>");	
				

					//Print out the titles for the rows
	   				out.print("CID");
	   				offset = 10;
	  	 	
	   				while(offset > 0){
	   					out.print("&nbsp;"); offset--;
	   				}
	   				out.print(" Name");
	   				offset = 10;
		  	 	
	   				while(offset > 0){
	   					out.print("&nbsp;"); offset--;
	   				}
	   				out.print(" Brand");
	   				offset = 10;
		  	 	
	   				while(offset > 0){
	   					out.print("&nbsp;"); offset--;
	   				}
	   				out.print("Color");
	   				offset = 10;
	   				while(offset > 0){
	   					out.print("&nbsp;"); offset--;
	   				}
	   				out.print(" Sell price <br/>");
	   		
				do{
					//Grab all the item stats for each tuple that fell in range and print them
					CID = myResult.getString("CID");
					name = myResult.getString("Name");
					brand = myResult.getString("Brand");
					color = myResult.getString("Color");
					sellPrice = myResult.getString("PriceSoldAt");
				
					//offset is used for spacing, &nbsp;
					offset = 20 - CID.length() - name.length();
					out.print(CID);
					while(offset > 0){out.print("&nbsp;"); offset--;}
					offset = 20 - brand.length() - name.length();
					out.print(name);
					while(offset > 0){out.print("&nbsp;"); offset--;}
					offset = 20 - brand.length() - color.length();
					out.print(brand);
					while(offset > 0){out.print("&nbsp;"); offset--;}
					offset = 22 - sellPrice.length() - color.length();
					out.print(color);
					while(offset > 0){out.print("&nbsp;"); offset--;}
					out.print(sellPrice + "<br/>");
				
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

<body>
</html>