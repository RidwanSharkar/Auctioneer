<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Auction Details and Bidding</title>
</head>
<body>
    <%
    String auctionId = request.getParameter("auctionId");
    if (auctionId != null && !auctionId.isEmpty()) {
    	try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    // Query 1: Count of tuples in pc_part table
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE auction.auction_id = '" + auctionId + "'";
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    
		    rs1.next();
		    
			ArrayList<String> partProperties = new ArrayList<>();
		    
		    String brand = rs1.getString(10);
		    
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    Timestamp closingTimeStamp = rs1.getTimestamp(4);
		    String closingTime = dateFormat.format(closingTimeStamp);
		    
		    
		    
		    
		    String partType = "";
	    	if(rs1.getObject(11) != null){
	    		partType = "cpu";
	    		partProperties.add("CPU Clock Speed: " + rs1.getInt(11));
	    		partProperties.add("CPU Cores: " + rs1.getInt(12));
	    		partProperties.add("CPU Threads: " + rs1.getInt(13));
	    	}
	    	else if (rs1.getObject(14) != null){
	    		partType = "ram";
	    		partProperties.add("RAM DDR: " + rs1.getInt(14));
	    		partProperties.add("RAM size: " + rs1.getInt(15));
	    	}
	    	else if (rs1.getObject(16) != null){
	    		partType = "motherboard";
	    		partProperties.add("Motherboard Socket: " + rs1.getString(16));
	    	}
	    	else if (rs1.getObject(17) != null){
	    		partType = "gpu";
	    		partProperties.add("GPU VRAM: " + rs1.getInt(17));
	    		partProperties.add("GPU Clock Speed: " + rs1.getInt(18));
	    	}
	    	else if (rs1.getObject(19) != null){
	    		partType = "power supply";
	    		partProperties.add("Power Supply Certification: " + rs1.getString(19));
	    		partProperties.add("Power Supply Watts: " + rs1.getInt(20));
	    	}
	    	else if (rs1.getObject(21) != null){
	    		partType = "hdd";
	    		partProperties.add("HDD RPM: " + rs1.getInt(21));
	    		partProperties.add("HDD Size: " + rs1.getInt(22));
	    	}
	    	else if (rs1.getObject(23) != null){
	    		partType = "sdd";
	    		partProperties.add("SSD Size: " + rs1.getInt(23));
	    		partProperties.add("SSD Speed: " + rs1.getInt(24));
	    	}
	    	
	    	float currentPrice = -1;
	    	
	    	Statement stmt2 = conn.createStatement();
	    	String query2 = "SELECT MAX(bid_amount) FROM auction LEFT JOIN bid ON auction.auction_id = bid.auction_id WHERE auction.auction_id = '" + auctionId + "' GROUP BY auction.auction_id;";
	    	ResultSet rs2 = stmt2.executeQuery(query2);
	    	
	    	if (rs2.next()) {
	    	    // Check if the value returned by getFloat(1) is NULL
	    	    if (rs2.getObject(1) != null) {
	    	        currentPrice = rs2.getFloat(1);
	    	    } 
	    	    else{
	    	    	currentPrice = rs1.getFloat(2);
	    	    }
	    	} else {
	    	    // No bids were placed, so the current Price is the starting price
	    		currentPrice = rs1.getFloat(2);
	    	}
	    	
	    	float minPrice = currentPrice + rs1.getFloat(3);
	    	
	    %>
	    	
	    	<div>
			    <h3>Auction Details</h3>
			    <p>Pc Part: <%= partType %></p>
			    <p>Brand: <%= brand %></p>
			    <p>Auction Closing Time: <%= closingTime %></p>
			    <p>Current Price: <%= currentPrice %></p>
			    
			    <%
			    	for(String property: partProperties){
			    		%>
			    			<p><%= property %></p>
			    		<% 
			    	}
			    %>
			</div>
			
			<h3>Place a Bid</h3>
				<form action="PlaceBid.jsp" method="post">
				    <input type="hidden" name="auctionId" value="<%= auctionId %>">
				    <label for="bidAmount">Enter your bid amount:</label>
				    <input type="number" id="bidAmount" name="bidAmount" min="<%= minPrice %>" step="0.01" required>
				    <input type="submit" value="Bid" name="submitBid">
				</form>
				
				
			<%
				// Check if the successMessage attribute is set
				String successMessage = (String) request.getAttribute("successMessage");
				if (successMessage != null) {
				%>
				    <p style="color: green;"><%= successMessage %></p>
				<%
				}
			%>
		<% 
		
		
		%>
		
		<form action="SimilarAuctions.jsp?auctionId=<%= auctionId %>" method="post">
	    <input type="submit" value="View Similar Auctions">
		</form>
			
		
		<% 
			
			
			
		stmt1.close();
		stmt2.close();
		rs1.close();
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