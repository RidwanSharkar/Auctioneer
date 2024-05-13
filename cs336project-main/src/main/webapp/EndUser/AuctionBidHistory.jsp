<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Auction Bid History </title>
</head>
<body>
	
	<h3>Bid History</h3>

    <%
    String auctionId = request.getParameter("auctionId");
    if (auctionId != null && !auctionId.isEmpty()) {
    	try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    // Query 1: Count of tuples in pc_part table
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT bid.end_user_username, bid.bid_amount, bid.bid_date_time FROM auction LEFT JOIN bid ON auction.auction_id = bid.auction_id WHERE auction.auction_id = '" + auctionId + "'";
		    
		    
		    
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    
		    ArrayList<String> bidList = new ArrayList<>();
		    
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    
		    while(rs1.next()){
		    	if(rs1.getObject(1) != null){
		    		String endUserUsername = rs1.getString(1);
			    	Float bidAmount = rs1.getFloat(2);
				    Timestamp bidTimeStamp = rs1.getTimestamp(3);
				    String bidTime = dateFormat.format(bidTimeStamp);
				    
				    bidList.add("Bidder Username: " + endUserUsername + " Bid Amount: " + bidAmount + " Bid Time: " + bidTime);
		    	}
		    	
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