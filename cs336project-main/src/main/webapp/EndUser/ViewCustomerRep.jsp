<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Submit Auction</title>
</head>
<body>

	<h3>Enter the Username of the Customer Representative You Would Like to Message</h3>
	
	<form action="MessageCustomerRep.jsp" method="post">
    <label for="repId">Customer Representative Username:</label>
    <input type="text" id="repId" name="repId" required>

    <label for="messageText">Message:</label>
    <textarea id="messageText" name="messageText" rows="4"></textarea>

    <input type="submit" value="Submit">
	</form>
	
	
	<h3>List of Customer Representatives</h3>
	
    <%
    	//Table Row: auction id / pc part type / brand / closing time 
    	
    	try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    // Query 1: Count of tuples in pc_part table
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT * FROM customer_representative";
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    
		    ArrayList<String> repList = new ArrayList<>();
		    
		    while(rs1.next()){
		    	repList.add(rs1.getString(1));
		    }
		    
		    for(String repString: repList){
		    	%>
		    	
		    		<p><%= repString %></p>
		    	
		    	<% 
		    }
		    
		    
		    stmt1.close();
			rs1.close();
			conn.close();
			
    	} catch (SQLException e) {
		    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
		    request.getRequestDispatcher("CreateEndUserAccount.jsp").forward(request, response);
		}
    
		%>

	
</body>
</html>