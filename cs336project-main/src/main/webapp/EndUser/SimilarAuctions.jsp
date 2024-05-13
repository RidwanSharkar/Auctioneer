<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Similar Auctions </title>
</head>
<body>
    <%
    String auctionId = request.getParameter("auctionId");
    if (auctionId != null && !auctionId.isEmpty()) {
    	try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    // Query 1: Get the auction
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE auction.auction_id = '" + auctionId + "'";
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    
		    rs1.next();
		    
		    String auctionBrand = rs1.getString(10);
		    
		    //Find what part type it is
		    
		    String partType = "";
		    int nullCheck = 0;
	    	if(rs1.getObject(11) != null){
	    		partType = "cpu";
	    		nullCheck = 11;
	    	}
	    	else if (rs1.getObject(14) != null){
	    		partType = "ram";
	    		nullCheck = 14;
	    	}
	    	else if (rs1.getObject(16) != null){
	    		partType = "motherboard";
	    		nullCheck = 16;
	    	}
	    	else if (rs1.getObject(17) != null){
	    		partType = "gpu";
	    		nullCheck = 17;
	    	}
	    	else if (rs1.getObject(19) != null){
	    		partType = "power supply";
	    		nullCheck = 19;
	    	}
	    	else if (rs1.getObject(21) != null){
	    		partType = "hdd";
	    		nullCheck = 21;
	    	}
	    	else if (rs1.getObject(23) != null){
	    		partType = "sdd";
	    		nullCheck = 23;
	    	}
	    	
	    	Statement stmt2 = conn.createStatement();
	    	String query2 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.brand = '" + auctionBrand + "'";
	    	ResultSet rs2 = stmt2.executeQuery(query2);
	    	
	    	ArrayList<String> similarAuctionsList = new ArrayList<>();
	    	
	    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    
		    while(rs2.next()){
		    	if(rs2.getObject(nullCheck) != null && ! rs2.getString(1).equals(auctionId)){
		    		Timestamp auctionTimeStamp = rs1.getTimestamp(4);
				    String closingTime = dateFormat.format(auctionTimeStamp);
		    		similarAuctionsList.add("Auction ID: " + rs2.getString(1) + " Part Type: " + partType + " Brand: " + rs2.getString(10) + "Auction Closing Time: " + closingTime);
		    	}
		    }
		    
		    for(String auctionString: similarAuctionsList){
		    	%>
		    	
		    		<p><%= auctionString %></p>
		    	
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