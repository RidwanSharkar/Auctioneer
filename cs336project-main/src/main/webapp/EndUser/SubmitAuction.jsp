<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Submit Auction</title>
</head>
<body>
    <%
    // Retrieve the part name
    String part = request.getParameter("part");

    // Determine the properties for the selected part
    String[] properties = null;
        switch(part) {
            case "cpu":
                properties = new String[]{"Clock Speed", "Threads", "Cores"};
                break;
            case "gpu":
                properties = new String[]{"Clock Speed", "VRAM"};
                break;
            case "ram":
                properties = new String[]{"DDR", "Size"};
                break;
            case "power_supply":
                properties = new String[]{"Watts", "Certification"};
                break;
            case "motherboard":
                properties = new String[]{"Socket"};
                break;
            case "hdd":
                properties = new String[]{"Size", "RPM"};
                break;
            case "ssd":
                properties = new String[]{"Size", "Speed"};
                break;
    }
    %>

    <h1>Auction Submitted</h1>
    <p>Part: <%= part %></p>

    <%
    ArrayList<String> pc_partPropertyHolder = new ArrayList<String>();
    if (properties != null) {
        for (String property : properties) {
            String parameterName = part + "_" + property.toLowerCase().replace(" ", "_");
            String parameterValue = request.getParameter(parameterName);
    %>
            <p><%= property.substring(0, 1).toUpperCase() + property.substring(1) %>: <%= parameterValue %></p>
    <%
    	pc_partPropertyHolder.add(parameterValue);
        }
    } else {
    %>
        <p>No properties found for the selected part.</p>
    <%
    }
    %>
    
	<%
		try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    // Query 1: Count of tuples in pc_part table
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT COUNT(*) FROM pc_part";
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    int pcPartCount = 0;
		    if (rs1.next()) {
		        pcPartCount = rs1.getInt(1);
		    }
		    rs1.close();
		    stmt1.close();
		
		    // Query 2: Count of tuples in auction table
		    Statement stmt2 = conn.createStatement();
		    String query2 = "SELECT COUNT(*) FROM auction";
		    ResultSet rs2 = stmt2.executeQuery(query2);
		    int auctionCount = 0;
		    if (rs2.next()) {
		        auctionCount = rs2.getInt(1);
		    }
		    rs2.close();
		    stmt2.close();
		    
		    //To construct the string for the insert queries
		    String[] pc_partInsertArray = new String[17];
		    Arrays.fill(pc_partInsertArray, "NULL");
		    		
		    //Make the id(primary key) of each the username + count of items/auction to make a unique key
		    String itemId = (String) session.getAttribute("username") + pcPartCount;
		    String auctionId = (String) session.getAttribute("username") + auctionCount;
		    
		    pc_partInsertArray[0] = "'" + itemId + "'";
		    pc_partInsertArray[1] = "0";
		    pc_partInsertArray[2] = "'" + request.getParameter(part + "_brand") + "'";
		    
		    //Add the relevant part property information to the pc_partInsertArray
		    int arrStartPoint = -1;
		    switch(part) {
	            case "cpu":
	            	pc_partInsertArray[3] = pc_partPropertyHolder.get(0);
	            	pc_partInsertArray[4] = pc_partPropertyHolder.get(1);
	            	pc_partInsertArray[5] = pc_partPropertyHolder.get(2);
	                break;
	            case "gpu":
	            	pc_partInsertArray[9] = pc_partPropertyHolder.get(0);
	            	pc_partInsertArray[10] = pc_partPropertyHolder.get(1);
	                break;
	            case "ram":
	            	pc_partInsertArray[6] = pc_partPropertyHolder.get(0);
	            	pc_partInsertArray[7] = pc_partPropertyHolder.get(1);
	                break;
	            case "power_supply":
	            	pc_partInsertArray[11] = "'" + pc_partPropertyHolder.get(0) + "'";
	            	pc_partInsertArray[12] = pc_partPropertyHolder.get(1);
	                break;
	            case "motherboard":
	            	pc_partInsertArray[8] = "'" + pc_partPropertyHolder.get(0) + "'";
	                break;
	            case "hdd":
	            	pc_partInsertArray[13] = pc_partPropertyHolder.get(0);
	            	pc_partInsertArray[14] = pc_partPropertyHolder.get(1);
	                break;
	            case "ssd":
	            	pc_partInsertArray[15] = pc_partPropertyHolder.get(0);
	            	pc_partInsertArray[16] = pc_partPropertyHolder.get(1);
	                break;
    		}
		   
		    
		    StringBuilder sb1 = new StringBuilder();
		    for (int i = 0; i < pc_partInsertArray.length; i++) {
		        sb1.append(pc_partInsertArray[i]);
		        if (i < pc_partInsertArray.length - 1) {
		            sb1.append(", ");
		        }
		    }
		    String partCommaSeparatedValues = sb1.toString();
		    
		    
		    //Fill out dump for auction 
		    
		    String[] auctionInsertArray = new String[7];
		    auctionInsertArray[0] = "'" + auctionId + "'";
		    auctionInsertArray[1]= request.getParameter(part + "_initialprice");
		    auctionInsertArray[2]= request.getParameter(part + "_biddingincrement");
		    auctionInsertArray[3]= "'" + request.getParameter(part + "_closingdate") +  " " + request.getParameter(part + "_closingtime") + "'";
		    auctionInsertArray[4] = "'" + session.getAttribute("username") + "'";
		    auctionInsertArray[5]= request.getParameter(part + "_minimumprice");
		    auctionInsertArray[6] = "'" + itemId + "'";
		    
		    StringBuilder sb2 = new StringBuilder();
		    for (int i = 0; i < auctionInsertArray.length; i++) {
		        sb2.append(auctionInsertArray[i]);
		        if (i < auctionInsertArray.length - 1) {
		            sb2.append(", ");
		        }
		    }
		    String auctionCommaSeparatedValues = sb2.toString();
		    
		    
			// Query 3: Add Item to pc_part table
			Statement stmt3 = conn.createStatement();
			String query3 = "INSERT INTO pc_part VALUES(" + partCommaSeparatedValues + ")";			
			stmt3.executeUpdate(query3);
			stmt3.close();
			
			// Query 4: Add Item to pc_part table
			Statement stmt4 = conn.createStatement();
			String query4 = "INSERT INTO auction VALUES(" + auctionCommaSeparatedValues + ")";			
			stmt4.executeUpdate(query4);
			stmt4.close();
			
			
			//Send Alerts to anyone looking for this type of PC part
			
			// Query 5: Check all item alerts
			
			Statement stmt5 = conn.createStatement();
			String query5 = "SELECT * FROM item_alert WHERE item_alert.pc_part_type = '" + part + "' AND item_alert.pc_part_brand = '" + request.getParameter(part + "_brand") + "' ";
			ResultSet rs5 = stmt5.executeQuery(query5);
			
			// Get the current date and time
		    LocalDateTime now = LocalDateTime.now();

		    // Format the date and time as a string
		    String formattedDateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			
			while(rs5.next()){
				String endUser = rs5.getString(1);
				
				Statement stmt6 = conn.createStatement();
				stmt6.executeUpdate("INSERT INTO alert VALUES ('" + endUser + "' , '" + formattedDateTime + "' , 'Alert for available PC Part of Type: " + part + " and of Brand: " + 
					request.getParameter(part + "_brand") + "' )");
				stmt6.close();
			}
			
			

		    conn.close();
		%>
		    <p>itemId is: <%= itemId %></p>
		    <p>auctionId is: <%= auctionId %></p>
		<%
		} catch (SQLException e) {
		    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
		    request.getRequestDispatcher("CreateEndUserAccount.jsp").forward(request, response);
		}
	
	
		
		
	%>

    <p>Additional Information:</p>
    <ul>
    	<li>Brand: <%= request.getParameter(part + "_brand") %></li>
        <li>Closing Date: <%= request.getParameter(part + "_closingdate") %></li>
        <li>Closing Time: <%= request.getParameter(part + "_closingtime") %></li>
        <li>Initial Price: <%= request.getParameter(part + "_initialprice") %></li>
        <li>Bidding Increment: <%= request.getParameter(part + "_biddingincrement") %></li>
        <li>Minimum Price: <%= request.getParameter(part + "_minimumprice") %></li>
    </ul>
</body>
</html>