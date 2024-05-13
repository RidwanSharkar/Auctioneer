<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseUpdates.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Page</title>
    <style>
        /* Add your CSS styles here */
    </style>
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
        <h1>Welcome, <%= username %>!</h1>
        <p>You have successfully logged in.</p>
        <a href="CreateAuction.jsp">Create Auction</a>
        <a href="BidForAnAuction.jsp">Bid For An Auction</a>
        <a href="ViewAlerts.jsp">View or Place Alerts</a>
        <a href="ViewCustomerRep.jsp">Message a Customer Representative</a>
        <a href="Logout.jsp">Logout</a>
        
        <a href="DeleteAccount.jsp">Delete Account</a>
    <%
    }
    %>
</body>
</html>