
<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://cs336auction.cuwrm3eh7ohh.us-east-2.rds.amazonaws.com/CS3362","cs336auction", "cs336auction");

    Statement st = con.createStatement();
    
    //Will check if a user exists in the CustomerRep table
    ResultSet checkType;
	checkType = st.executeQuery("SELECT Username FROM CustomerRep Where Username = '" + userid + "'");
	
	//Will hold the query result from CustomerRep
	String result = "";
	
	//Assigns the result to a variable
	while(checkType.next()){
		result = checkType.getString("Username");
	}
	
	//Will check if a user exists in the Account table
    ResultSet rs;
    rs = st.executeQuery("select * from Account where Username='" + userid + "' and PasswordHash='" + pwd + "'");
	
	//Determines if a match was found for username and password
    if (rs.next()) {
    	if(userid.equals("admin")){
    		session.setAttribute("user", userid); // the username will be stored in the session
	        response.sendRedirect("AdminLoginSuccess.jsp");
    	}
    	else if(result != null && result != ""){
	        session.setAttribute("user", userid); // the username will be stored in the session
	        response.sendRedirect("CustomerRepLoginSuccess.jsp");
    	}
    	else{
    		session.setAttribute("user", userid); // the username will be stored in the session
	        response.sendRedirect("EndUserLoginSuccess.jsp");
    	}
    } 
    else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
	con.close();
%>
