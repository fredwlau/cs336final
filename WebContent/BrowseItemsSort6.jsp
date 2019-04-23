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
 
      <sql:query dataSource = "${snapshot}" var = "result">
      SELECT a.AID, InitialPrice, CloseOutDateTime, SellerUsername, CID, Name, Brand, Type, Gender, Color,
      MAX(BidPrice) as BidPrice FROM AuctionItem a JOIN Clothing c on a.ClothingCID = c.CID 
      JOIN Bids b on b.AID = a.AID WHERE WinnerUsername is null GROUP BY a.AID
      ORDER BY ItemSales ASC;
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
<br>
<br>
SORT BY
<br>
<form method="post" action="SortIntermediate.jsp">
<select name="Type">
  <option value="Name">Name</option>
  <option value="Brand">Brand</option>
  <option value="Gender">Gender</option>
  <option value="Color">Color</option>
  <option value="Price">Price</option>
  <option value="Sales">Sales</option>
  <option value="Type">Type</option>
</select>
<input type ="submit" value="Sort">
</form>
Filter By Name
<br>
	<form method="post" action="BrowseItemsFilter.jsp">
	<table>
	<tr>    
	Type: <input type ="text" name = "Type">
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
	Type: <input type ="text" name = "Type">
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
	Type: <input type ="text" name = "Type">
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
	Type: <input type ="text" name = "Type">
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