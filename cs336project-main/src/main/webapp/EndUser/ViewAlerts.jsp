<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="DatabaseUpdates.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alerts Page</title>
</head>
<body>

	<h3>Add An Alert For a Specific Part Time and Brand</h3>

	<form action="AddItemAlert.jsp" method="post">
	    <input type="text" name="partType" placeholder="PC Part Type " required>
	    <input type="text" name="partBrand" placeholder="Part Brand" required>
	    <input type="submit" value="Submit">
	</form>
   	
   	<%
    // You can add any additional JSP code or HTML here
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
        
        
		String query1 = "SELECT * FROM alert WHERE alert.end_user_username = '" + username + "' ";
		ResultSet rs = stmt.executeQuery(query1);
        
        ArrayList<String> alertList = new ArrayList<>();
        
        while(rs.next()){
        	alertList.add("Alert Date: " + rs.getString(2) + " Alert Content: " + rs.getString(3));
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