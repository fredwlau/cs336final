
<style>
body {
background-color: #7FFF00
}
</style>

<center>
<%
    if ((session.getAttribute("user") == null)) {
		%>
		You are not logged in<br/>
		<a href="Login.jsp">Please Login</a>
		<%
} 
    else {
		%>
		Welcome <%=session.getAttribute("user")%> 
		
		<br>
		<a href='CustomerRepPage.jsp'>Proceed to account page</a>
		<br>
		<%
    }
%>
</center>