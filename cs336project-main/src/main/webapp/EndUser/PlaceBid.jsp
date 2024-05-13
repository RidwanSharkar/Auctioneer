<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>

<%@ include file="DatabaseUpdates.jsp" %>
<%
    String auctionId = request.getParameter("auctionId");
    String bidAmount = request.getParameter("bidAmount");
    
    String username = (String) session.getAttribute("username");
    
 	// Get the current date and time
    LocalDateTime now = LocalDateTime.now();

    // Format the date and time as a string
    String formattedDateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    try {
    	ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
        Statement stmt = conn.createStatement();
        
		//Send alert to Other top bidder if they exist
    	
    	Statement stmt5 = conn.createStatement();
    	
    	String highestBidQuery = "SELECT end_user_username FROM bid WHERE auction_id = '" + auctionId + "' AND bid_amount = (SELECT MAX(bid_amount) FROM bid WHERE bid.auction_id = '" + auctionId + "')";
    	ResultSet rs = stmt5.executeQuery(highestBidQuery);
    	

    	if(rs.next()){
    		if(rs.getObject(1) != null){
        		//Send Alert to them 
        		Statement stmt6 = conn.createStatement();
    			stmt6.executeUpdate("INSERT INTO alert VALUES ('" + rs.getString(1) + "' , '" + formattedDateTime + "' , 'A bid has been placed above your bid for Auction: " + auctionId + "' )");
    			stmt6.close();
    		    
    		    
        	}
    	}
    	
        
        stmt.executeUpdate("INSERT INTO bid VALUES ('" + username + "','" + auctionId + "'," + bidAmount + ",'" + formattedDateTime + "' );");

    	 // Set success message as a request attribute
        request.setAttribute("successMessage", "Bid placed successfully!");
    	 
    	
    	 
    	//Check All auto bids
    	
    	Statement stmt2 = conn.createStatement();
    	ResultSet auctionAutoBid = stmt2.executeQuery("SELECT * FROM auto_bid WHERE auction_id = '" + auctionId + "' AND end_user_username != '" + username + "' " );
    	
    	Statement stmt3 = conn.createStatement();
    	ResultSet getAuctionRS = stmt3.executeQuery("SELECT * FROM auction WHERE auction_id = '" + auctionId + "'");
    	
    	getAuctionRS.next();
    	
    	Float auctionIncrement = getAuctionRS.getFloat(3);
    	
    	Float newBid = Float.parseFloat(bidAmount) + auctionIncrement;
    	
    	while(auctionAutoBid.next()){
    		if(auctionAutoBid.getObject(1) != null){
    			if(auctionAutoBid.getFloat(3) >= newBid){
    				//Place a Bid
    				
    				Statement stmt4 = conn.createStatement();
    				
    				stmt4.executeUpdate("INSERT INTO bid VALUES ('" + auctionAutoBid.getString(1) + "','" + auctionId + "'," + newBid + ",'" + formattedDateTime + "' );");
    				
    				newBid += auctionIncrement;
    				
    				stmt4.close();
    			}
    			
    			else if (auctionAutoBid.getFloat(3) < newBid){
    				//Send alert to user 
    				Statement stmt7 = conn.createStatement();
        			stmt7.executeUpdate("INSERT INTO alert VALUES ('" + auctionAutoBid.getString(1) + "' , '" + formattedDateTime + "' , 'Your Limit For You Auto Bid Has Been Exceeded For Aution: " + auctionId + "' )");
        			stmt7.close();
    			}
    		}
    	}
    	
    

        // Forward the request back to AuctionDetailsAndBidding.jsp
        request.getRequestDispatcher("AuctionDetailsAndBidding.jsp").forward(request, response);
       
       
        stmt.close();
        stmt2.close();
        stmt3.close();
        stmt5.close();
        rs.close();
        auctionAutoBid.close();
        conn.close();
    }  catch (SQLException e) {
        request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        request.getRequestDispatcher("EndUserLogin.jsp").forward(request, response);
    }
%>