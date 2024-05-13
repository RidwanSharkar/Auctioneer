<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Selected Auctions</title>
</head>
<body>
    <%
    int nullCheck = Integer.parseInt(request.getParameter("nullCheck"));
    
   
    

   	try {
	    ApplicationDB db = new ApplicationDB();
	    Connection conn = db.getConnection();
	    String query1 = "";
	    
	    switch(nullCheck) {
	    case 11:
	    	
	        String cpuClockSpeed = request.getParameter("cpuClockSpeed");
	        String cpuCore = request.getParameter("cpuCore");
	        String cpuThreads = request.getParameter("cpuThreads");
	        
	        query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.cpu_clock_speed = " 
	        + cpuClockSpeed + " AND pc_part.cpu_cores = " + cpuCore + " AND pc_part.cpu_threads = " + cpuThreads ;
	        break;
	    case 14:
	        String ramDdr = request.getParameter("ramDdr");
	        String ramSize = request.getParameter("ramSize");
	        query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.ram_ddr = " 
	    	+ ramDdr + " AND pc_part.ram_size = " + ramSize ;
	        
	        break;
	    case 16:
	        String motherboardSocket = request.getParameter("motherboardSocket");
	        query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.motherboard_socket = '" 
	    	    	+ motherboardSocket + "' ";
	        break;
	    case 17:
	        String gpuVRAM = request.getParameter("gpuVRAM");
	        String gpuClockSpeed = request.getParameter("gpuClockSpeed");
	        query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.gpu_clockspeed = " 
	    	    	+ gpuClockSpeed + " AND pc_part.gpu_vram = " + gpuVRAM ;
	        break;
	    case 19:
	        String powerSuppCert = request.getParameter("powerSuppCert");
	        String powerSuppWatts = request.getParameter("powerSuppWatts");
	        query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.psu_certification = '" 
	    	    	+ powerSuppCert + "' AND pc_part.psu_watts = " + powerSuppWatts ;
	        break;
	    case 21:
	        String hddRpm = request.getParameter("hddRpm");
	        String hddSize = request.getParameter("hddSize");
	        query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.hdd_rpm = " 
	    	    	+ hddRpm + " AND pc_part.hdd_size = " + hddSize ;
	        break;
	    case 23:
	        String ssdSize = request.getParameter("ssdSize");
	        String ssdSpeed = request.getParameter("ssdSpeed");
	        query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.ssd_size = " 
	    	    	+ ssdSize + " AND pc_part.ssd_speed = " + ssdSpeed ;
	        break;
		}
	    
	
	    // Query 1: Count of tuples in pc_part table
	    Statement stmt1 = conn.createStatement();
	    
	    ResultSet rs1 = stmt1.executeQuery(query1);
	    
	    ArrayList<String> auctionList = new ArrayList<>();
	    
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    
	    while(rs1.next()){
	    	if(rs1.getObject(nullCheck) != null && rs1.getInt(9) == 0){
	    		
	    		Timestamp auctionTimeStamp = rs1.getTimestamp(4);
			    String closingTime = dateFormat.format(auctionTimeStamp);
			    auctionList.add("Auction ID: " + rs1.getString(1) + " Brand: " + rs1.getString(10) + "Auction Closing Time: " + closingTime);
	    	}
	    	
	    }
	    
	    for(String auctionString: auctionList){
	    	%>
	    	
	    		<p><%= auctionString %></p>
	    	
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