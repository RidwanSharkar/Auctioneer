<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Auction History</title>
</head>
<body>
	<h3>The AuctionID of Auctions The User Has Participated in as a Seller or Bidder</h3>
    <%
    String userId = request.getParameter("userId");
    if (userId != null && !userId.isEmpty()) {
    	try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		    
		    Set<String> auctionSet = new HashSet<>();
		    
		    Set<String> bidderSet = new HashSet<>();
		
		    // Query 1: Count of tuples in pc_part table
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT * FROM auction WHERE auction.end_user_username = '" + userId + "'" ;
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    
		   
		    
		    while(rs1.next()){
		    	auctionSet.add(rs1.getString(1));
		    	
		    }
		    
		    Statement stmt2 = conn.createStatement();
		    String query2= "SELECT * FROM bid WHERE bid.end_user_username = '" + userId + "'" ;
		    ResultSet rs2 = stmt1.executeQuery(query2);
		    
		    while(rs2.next()){
		    	bidderSet.add(rs2.getString(2));
		    }
		    
		    for(String auctionString: auctionSet){
		    	%>
		    	
		    		<p>Seller: <%= auctionString %></p>
		    	
		    	<% 
		    }
		    
		    for(String bidString: bidderSet){
		    	%>
		    	
		    		<p>Bidder: <%= bidString %></p>
		    	
		    	<% 
		    }
		    
		    
			
			
		stmt1.close();
		rs1.close();
		stmt2.close();
		rs2.close();
		conn.close();	
		} catch (SQLException e) {
		    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
		    request.getRequestDispatcher("CreateEndUserAccount.jsp").forward(request, response);
		}
    	
    	
    	
    } else {
        // Handle the case where no auction ID was submitted
        %>
        <p>Please enter an auction ID to view details and bid.</p>
        <%
    }
    %>
</body>
</html>