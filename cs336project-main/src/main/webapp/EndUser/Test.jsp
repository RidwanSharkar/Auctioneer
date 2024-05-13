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

	<h3>burger</h3>
    
    <%
    try {
    	ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
      	//First find highest bid on closed auction 
		
		Statement stmt3 = conn.createStatement();
      	
		String highestBidQuery = "SELECT b.bid_amount, b.end_user_username FROM bid b INNER JOIN ( SELECT b.auction_id, MAX(b.bid_amount) AS max_bid FROM bid b LEFT JOIN auction a ON b.auction_id = a.auction_id LEFT JOIN pc_part p ON a.pc_part = p.item_id WHERE p.item_id = '" 
				+ "alex1239" + "' GROUP BY b.auction_id ) AS max_bids ON b.auction_id = max_bids.auction_id AND b.bid_amount = max_bids.max_bid;";
		ResultSet auctionWinnerRS = stmt3.executeQuery(highestBidQuery);
		
		
		
		
		
		
		
		if(auctionWinnerRS.next()){
			// Get the current date and time
		    LocalDateTime now = LocalDateTime.now();

		    // Format the date and time as a string
		    String formattedDateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			Statement stmt4 = conn.createStatement();
			
			String wackQuery = "INSERT INTO alert VALUES ('" + auctionWinnerRS.getString(2) + "' , '" + formattedDateTime + "' , 'You have won auction: " + 
					"woah" + " With Your Bid Of " + auctionWinnerRS.getFloat(1) + "')";
			%>
			
				<p><%= wackQuery %></p>
			
			<%
			
			stmt4.executeUpdate(wackQuery);
		}
        
       
        
		stmt3.close();
        conn.close();
    }  catch (SQLException e) {
        request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        request.getRequestDispatcher("Success.jsp").forward(request, response);
    }
    
    %>
    
    
   	
   	
</body>
</html>