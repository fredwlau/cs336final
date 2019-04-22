<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<html>
   <head>
      <title>Browse Items</title>
   </head>

   <body>
      <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://cs336auction.cuwrm3eh7ohh.us-east-2.rds.amazonaws.com/CS3362"
         user = "cs336auction"  password = "cs336auction"/>
 
      <sql:query dataSource = "${snapshot}" var = "result">
      SELECT a.AID, InitialPrice, CloseOutDateTime, SellerUsername, CID, Name, Brand, Gender, Color, ItemSales, BidPrice
      FROM AuctionItem a JOIN Clothing c ON a.ClothingCID=c.CID  JOIN Bids b ON a.AID=b.AID
      ORDER BY Brand ASC; 
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
	    	<th>Gender</th>
	    	<th>Color</th>
	    	<th>Sales</th>
	    	<th>Current Bid</th>
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
               <td><c:out value = "${row.Gender}"/></td>
               <td><c:out value = "${row.Color}"/></td>
               <td><c:out value = "${row.ItemSales}"/></td>
               <td><c:out value = "${row.BidPrice}"/></td>
            </tr>
         </c:forEach>
      </table>


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
Filter By Name
<br>
	<form method="GET" action="BrowseItemsFilter.jsp">
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
	<form method="GET" action="BrowseItemsFilter2.jsp">
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
	<form method="GET" action="BrowseItemsFilter3.jsp">
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
	<form method="GET" action="BrowseItemsFilter4.jsp">
	<table>
	<tr>    
	Type: <input type ="text" name = "Type">
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
</body>
</html>