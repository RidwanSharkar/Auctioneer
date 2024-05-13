<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Process Auction</title>
</head>
<body>
    <%
        // Retrieve form data
        String part = request.getParameter("part");

        // Retrieve specific part properties based on the selected part
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

    <h1>Auction Details</h1>
    <p>Selected Part: <%=part%></p>
    <form action="SubmitAuction.jsp" method="post">
        <% if (properties != null) { for (String property : properties) { %>
            <label for="<%=part%>_<%=property.toLowerCase().replace(" ", "_")%>"><%=property%>:</label>
            <input type="text" id="<%=part%>_<%=property.toLowerCase().replace(" ", "_")%>" name="<%=part%>_<%=property.toLowerCase().replace(" ", "_")%>"><br>
        <% } } else { %>
            <p>No properties found for selected part.</p>
        <% } %>
		<input type="hidden" name="part" value="<%= part %>">
		
		<label for="<%=part%>_brand">Part Brand, Select From the Following Options: Intel, AMD, Nvidia, AMD Radeon, Other</label>
        <input type="text" id="<%=part%>_brand" name="<%=part%>_brand"><br>
		
        <label for="<%=part%>_closingdate">Closing Date In Format yyyy-mm-dd:</label>
        <input type="text" id="<%=part%>_closingdate" name="<%=part%>_closingdate"><br>

        <label for="<%=part%>_closingtime">Closing Time In Format hh:mm:ss with hour on 24 hour clock:</label>
        <input type="text" id="<%=part%>_closingtime" name="<%=part%>_closingtime"><br>

        <label for="<%=part%>_initialprice">Initial Price:</label>
        <input type="text" id="<%=part%>_initialprice" name="<%=part%>_initialprice"><br>

        <label for="<%=part%>_biddingincrement">Bidding Increment:</label>
        <input type="text" id="<%=part%>_biddingincrement" name="<%=part%>_biddingincrement"><br>

        <label for="<%=part%>_minimumprice">Minimum Price:</label>
        <input type="text" id="<%=part%>_minimumprice" name="<%=part%>_minimumprice"><br>
        
       
        <input type="submit" value="Submit">
    </form>
</body>
</html>