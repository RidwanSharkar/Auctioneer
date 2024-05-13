<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Auction</title>
</head>
<body>
<%
String username = (String) session.getAttribute("username");
if (username == null) {
%>
<p>You are not logged in. Please <a href="EndUserLogin.jsp">login</a> first.</p>
<%
} else {
%>
<h1>Please Select an Item Type You Would Like to Auction</h1>
<form action="ProcessAuction.jsp" method="post">
    <input type="radio" name="part" value="cpu"> CPU<br>
    <input type="radio" name="part" value="gpu"> GPU<br>
    <input type="radio" name="part" value="ram"> RAM<br>
    <input type="radio" name="part" value="power_supply"> Power Supply<br>
    <input type="radio" name="part" value="motherboard"> Motherboard<br>
    <input type="radio" name="part" value="hdd"> HDD<br>
    <input type="radio" name="part" value="ssd"> SSD<br>
    
    <%
    String[] parts = {"cpu", "gpu", "ram", "power_supply", "motherboard", "hdd", "ssd"};
    String[][] properties = {
        {"Clock Speed", "Threads", "Cores"},
        {"Clock Speed", "VRAM"},
        {"DDR", "Size"},
        {"Watts", "Certification"},
        {"Socket"},
        {"Size", "RPM"},
        {"Size", "Speed"}
    };
    for (int i = 0; i < parts.length; i++) {
        %>
        <div id="<%=parts[i] %>-properties" style="display: none;">
        <%
        for (int j = 0; j < properties[i].length; j++) {
            %>
            <%=properties[i][j] %>: <input type="text" name="<%=parts[i] %>_<%=properties[i][j].toLowerCase().replace(" ", "_") %>"><br>
            <%
        }
        %>
        </div>
        <%
    }
    %>
    
    <input type="submit" value="Submit">
</form>
<%
}
%>
</body>
</html>
