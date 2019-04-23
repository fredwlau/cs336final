<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<html>
   <head>
   <style>
body {
background-color: #E6E6FA
}
</style>
      <title>Browse Items</title>
   </head>

   <body>
      <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://cs336auction.cuwrm3eh7ohh.us-east-2.rds.amazonaws.com/CS3362"
         user = "cs336auction"  password = "cs336auction"/>
 	
 	  <%String filter_color = request.getParameter("Type");
 	  request.setAttribute("filter_color", filter_color);%>
 	  
 	  <c:set var = "empId" value ="${filter_color}"/>
 
      <sql:query dataSource = "${snapshot}" var = "result">
      SELECT a.AID, InitialPrice, CloseOutDateTime, SellerUsername, CID, Name, Brand, Type, Gender, Color, 
      MAX(BidPrice) as BidPrice FROM AuctionItem a JOIN Clothing c on a.ClothingCID = c.CID 
      JOIN Bids b on b.AID = a.AID WHERE Color = ? GROUP BY a.AID
      <sql:param value = "${empId}" />
      </sql:query>
 
      <table border = "1" width = "100%">
         <tr>
            <th>Auction ID Number</th>
            <th>Starting Price</th>
            <th>Closing Date</th>
            <th>Seller</th>
	    	<th>Clothing ID Number</th>
	    	<th>Clothing Name</th>
	    	<th>Clothing Brand</th>
	    	<th>Clothing Type</th>
	    	<th>Gender</th>
	    	<th>Color</th>
	    	<th>Current Bid</th>
	    	<th>Your Bid</th>
	    	<th>Automatic Bidding Threshold</th>
	    	<th>Place Bid</th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td><c:out value = "${row.AID}"/></td>
               <td><c:out value = "${row.InitialPrice}"/></td>
               <td><c:out value = "${row.CloseOutDateTime}"/></td>
               <td><c:out value = "${row.SellerUsername}"/></td>
 	       	   <td><c:out value = "${row.CID}"/></td>
               <td><c:out value = "${row.Name}"/></td>
               <td><c:out value = "${row.Brand}"/></td>
               <td><c:out value = "${row.Type}"/></td>
               <td><c:out value = "${row.Gender}"/></td>
               <td><c:out value = "${row.Color}"/></td>
               <td><c:out value = "${row.BidPrice}"/></td>
               <form method = "post" action="AuctionBiddingSQL.jsp">
               <td><input type="text" name="newBidPrice"></td>
               <td><input type="text" name="newAutomaticBiddingPrice"></td>
			   <td align='center'><input type=submit value="Bid"></td>
			   <td><input type="hidden" name="newAID" value="${row.AID}"></td></form>
            </tr>
         </c:forEach>
      </table>
<Center>

Sort by Name
<br>
	<form method="post" action="BrowseItemsSort1.jsp">
	<input type="submit" value="Return">
	</form>
<br>
Sort by Brand
<br>
	<form method="post" action="BrowseItemsSort2.jsp">
	<input type="submit" value="Return">
	</form>
<br>
Sort by Gender
<br>
	<form method="post" action="BrowseItemsSort3.jsp">
	<input type="submit" value="Return">
	</form>
<br>
Sort By Color
<br>
	<form method="post" action="BrowseItemsSort4.jsp">
	<input type="submit" value="Return">
	</form>
<br>
Sort by Price
<br>
	<form method="post" action="BrowseItemsSort5.jsp">
	<input type="submit" value="Return">
	</form>
<br>
Sort By Sales
<br>
	<form method="post" action="BrowseItemsSort6.jsp">
	<input type="submit" value="Return">
	</form>
<br>
Sort By Type
<br>
	<form method="post" action="BrowseItemsSort7.jsp">
	<input type="submit" value="Return">
	</form>
<br>
Filter By Name
<br>
	<form method="post" action="BrowseItemsFilter.jsp">
	<table>
	<tr>    
	Name:<input type ="text" name = "Type">
	</tr>
	</table>
	<input type="submit" value="Return">
	</form>
<br>
Filter By Brand
<br>
	<form method="post" action="BrowseItemsFilter2.jsp">
	<table>
	<tr>    
	Brand:<input type ="text" name = "Type">
	</tr>
	</table>
	<input type="submit" value="Return">
	</form>
<br>
Filter By Gender
<br>
	<form method="post" action="BrowseItemsFilter3.jsp">
	<table>
	<tr>    
	Gender:<input type ="text" name = "Type">
	</tr>
	</table>
	<input type="submit" value="Return">
	</form>
<br>
Filter By Color
<br>
	<form method="post" action="BrowseItemsFilter4.jsp">
	<table>
	<tr>    
	Color:<input type ="text" name = "Type">
	</tr>
	</table>
	<input type="submit" value="Return">
	</form>
<br>
Filter By Type
<br>
	<form method="post" action="BrowseItemsFilter5.jsp">
	<table>
	<tr>    
	Type:<input type ="text" name = "Type">
	</tr>
	</table>
	<input type="submit" value="Return">
	</form>
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