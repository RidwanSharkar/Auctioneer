<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="com.example.DateCheck"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>

<%

try {
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    
    //Close Auctions Past Due
    
    
    Statement stmt1 = conn.createStatement();
    String allOpenAuctionsQuery = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.status = 0";
    ResultSet openAuctionsRS =  stmt1.executeQuery(allOpenAuctionsQuery);
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    while(openAuctionsRS.next()){
    	Timestamp auctionTimeStamp = openAuctionsRS.getTimestamp(4);
	    String closingTime = dateFormat.format(auctionTimeStamp);
    	if(DateCheck.isDateTimeBeforeNow(closingTime)){
    		//Current auction's closing time has passed
    		String partId = openAuctionsRS.getString(8);
    		String auctionId = openAuctionsRS.getString(1);
    		Float minPrice = openAuctionsRS.getFloat(6);
    		String updateItemToClosed = "UPDATE pc_part SET status = 1 WHERE item_id = '" + partId + "'";
    		Statement stmt2 = conn.createStatement();
    		stmt2.executeUpdate(updateItemToClosed);
    		stmt2.close();
    		
    		//Send Alert to Users who won the auction 
    		
    		//First find highest bid on closed auction 
    		String highestBidQuery = "SELECT b.bid_amount, b.end_user_username FROM bid b INNER JOIN ( SELECT b.auction_id, MAX(b.bid_amount) AS max_bid FROM bid b LEFT JOIN auction a ON b.auction_id = a.auction_id LEFT JOIN pc_part p ON a.pc_part = p.item_id WHERE p.item_id = '" 
    		+ partId + "' GROUP BY b.auction_id ) AS max_bids ON b.auction_id = max_bids.auction_id AND b.bid_amount = max_bids.max_bid;";
    		Statement stmt3 = conn.createStatement();
    		ResultSet auctionWinnerRS = stmt3.executeQuery(highestBidQuery);
    		
    		if(auctionWinnerRS.next()){
    			if(auctionWinnerRS.getFloat(1) >= minPrice){
    				//If the highest bid is greater than the minimum price
    				// Get the current date and time
        		    LocalDateTime now = LocalDateTime.now();

        		    // Format the date and time as a string
        		    String formattedDateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        			Statement stmt4 = conn.createStatement();
        			String wackQuery = "INSERT INTO alert VALUES ('" + auctionWinnerRS.getString(2) + "' , '" + formattedDateTime + "' , 'You have won auction: " + 
        					auctionId + " With Your Bid Of " + auctionWinnerRS.getFloat(1) + "')";
        			stmt4.executeUpdate(wackQuery);
    			}
    			
    		}
    	
    	}
    }
    
    
    
    
    //Update Auto Bids
    
    
    
    
    conn.close();
} catch (SQLException e) {
    
}
%>