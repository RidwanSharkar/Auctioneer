<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Specific Search</title>
</head>
<body>
    

    <%
    String partInput = request.getParameter("partName");
    int nullCheck = 0;
    switch(partInput){
    case "cpu":
    	nullCheck = 11;
    	%>
    		<form action="DisplaySpecificAuctions.jsp" method="post">
    		<input type="hidden" name="nullCheck" value="<%= nullCheck %>">
	        <input type="text" name="cpuClockSpeed" placeholder="Enter CPU Clock Speed">
	        <input type="text" name="cpuCore" placeholder="Enter CPU Cores">
	        <input type="text" name="cpuThreads" placeholder="Enter CPU Threads">
	        <input type="submit" value="Search">
	    	</form>
    	
    	<% 
    	break;
    case "ram":
    	nullCheck = 14;
    	%>
    		<form action="DisplaySpecificAuctions.jsp" method="post">
    		<input type="hidden" name="nullCheck" value="<%= nullCheck %>">
	        <input type="text" name="ramDdr" placeholder="Enter RAM DDR">
	        <input type="text" name="ramSize" placeholder="Enter RAM Size">
	        <input type="submit" value="Search">
	    	</form>
    	<%     	
    	break;
    case "motherboard":
    	nullCheck = 16;
    	%>
    		<form action="DisplaySpecificAuctions.jsp" method="post">
    		<input type="hidden" name="nullCheck" value="<%= nullCheck %>">
	        <input type="text" name="motherboardSocket" placeholder="Enter Motherboard Socket">
	        <input type="submit" value="Search">
	    	</form>
    	<%     	
    	break;
    case "gpu":
    	nullCheck = 17;
    	%>
    		<form action="DisplaySpecificAuctions.jsp" method="post">
    		<input type="hidden" name="nullCheck" value="<%= nullCheck %>">
	        <input type="text" name="gpuVRAM" placeholder="Enter GPU VRAM">
	        <input type="text" name="gpuClockSpeed" placeholder="Enter GPU Clock Speed">
	        <input type="submit" value="Search">
	    	</form>
    	<%     	
    	break;
    case "power supply":
    	nullCheck = 19;
    	%>
    		<form action="DisplaySpecificAuctions.jsp" method="post">
    		<input type="hidden" name="nullCheck" value="<%= nullCheck %>">
	        <input type="text" name="powerSuppCert" placeholder="Enter Power Supply Certification">
	        <input type="text" name="powerSuppWatts" placeholder="Enter Power Supply Watts">
	        <input type="submit" value="Search">
	    	</form>
    	<%     	
    	break;
    case "hdd":
    	nullCheck = 21;
    	%>
    		<form action="DisplaySpecificAuctions.jsp" method="post">
    		<input type="hidden" name="nullCheck" value="<%= nullCheck %>">
	        <input type="text" name="hddRpm" placeholder="Enter HDD RPM">
	        <input type="text" name="hddSize" placeholder="Enter HDD Size">
	        <input type="submit" value="Search">
	    	</form>
    	<%     	
    	break;
    case "ssd":
    	nullCheck = 23;
    	%>
    		<form action="DisplaySpecificAuctions.jsp" method="post">
    		<input type="hidden" name="nullCheck" value="<%= nullCheck %>">
	        <input type="text" name="ssdSize" placeholder="Enter SSD Size">
	        <input type="text" name="ssdSpeed" placeholder="Enter SSD Speed">
	        <input type="submit" value="Search">
	    	</form>
    	<%     	
    	break;
    }
    
    
    
    %>
</body>
</html>