<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message Page</title>
</head>
<body>

	<h3>Message An End User</h3>

	<form action="MessageEndUser.jsp" method="post">
	    <input type="text" name="endUserId" placeholder="End User Username " required>
	    <label for="messageText">Message:</label>
    	<textarea id="messageText" name="messageText" rows="4"></textarea>
	    <input type="submit" value="Submit">
	</form>
   	
   	<%

    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
    %>
    <p style="color:red;"><%= errorMessage %></p>
    <%
    }
    %>
    
    <h3>Current Alerts: </h3>
    
    <%
    try {
    	ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
        Statement stmt = conn.createStatement();
        
        String username = (String) session.getAttribute("username");
        
        
		String query1 = "SELECT * FROM rep_message WHERE customer_rep_username = '" + username + "' ";
		ResultSet rs = stmt.executeQuery(query1);
        
        ArrayList<String> alertList = new ArrayList<>();
        
        while(rs.next()){
        	alertList.add("End User ID: " + rs.getString(2) + " Message Content: " + rs.getString(4));
        }
        
        for(String alertString: alertList){
	    	%>
	    	
	    		<p><%= alertString %></p>
	    	
	    	<% 
	    }
		
        
        
        
        stmt.close();
        conn.close();
    }  catch (SQLException e) {
        request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        request.getRequestDispatcher("Success.jsp").forward(request, response);
    }
    
    %>
    
    
   	
   	
</body>
</html>