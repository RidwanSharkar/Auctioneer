<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Bid History</title>
</head>
<body>
    <%
    String userId = request.getParameter("userId");
    if (userId != null && !userId.isEmpty()) {
    	try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    // Query 1: Count of tuples in pc_part table
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT bid.auction_id, bid.bid_amount, bid.bid_date_time FROM bid LEFT JOIN end_user ON bid.end_user_username = end_user.end_user_username WHERE end_user.end_user_username = '" + userId + "'" ;
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    
		    ArrayList<String> bidList = new ArrayList<>();
		    
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    
		    while(rs1.next()){
		    	String auctionId = rs1.getString(1);
		    	Float bidAmount = rs1.getFloat(2);
			    Timestamp bidTimeStamp = rs1.getTimestamp(3);
			    String bidTime = dateFormat.format(bidTimeStamp);
			    
			    bidList.add("Auction ID: " + auctionId + " Bid Amount: " + bidAmount + " Bid Time: " + bidTime);
		    }
		    
		    for(String bidString: bidList){
		    	%>
		    	
		    		<p><%= bidString %></p>
		    	
		    	<% 
		    }
		    
		    
			
			
		stmt1.close();
		rs1.close();
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