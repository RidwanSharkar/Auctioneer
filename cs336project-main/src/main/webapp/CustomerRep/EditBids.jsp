<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Bid History</title>
</head>
<body>
    <%
    String username = request.getParameter("username");
    if (username != null && !username.isEmpty()) {
        try {
        	String successMessage = (String)request.getAttribute("successMessage");
            if(successMessage != null && !successMessage.isEmpty()) {
    		%>
                <p style="color: green;"><%= successMessage %></p>
    		<%
            }
            
            String errorMessage = (String)request.getAttribute("errorMessage");
            if(errorMessage != null && !errorMessage.isEmpty()) {
    		%>
                <p style="color: red;"><%= errorMessage %></p>
    		<%
            }
            ApplicationDB db = new ApplicationDB();
            Connection conn = db.getConnection();
        
            Statement stmt1 = conn.createStatement();
            String query1 = "SELECT bid.auction_id, bid.bid_amount, bid.bid_date_time FROM bid LEFT JOIN end_user ON bid.end_user_username = end_user.end_user_username WHERE end_user.end_user_username = '" + username + "'" ;
            ResultSet rs1 = stmt1.executeQuery(query1);
            
            ArrayList<String[]> bidList = new ArrayList<>();
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            
            while(rs1.next()){
                String auctionId = rs1.getString(1);
                Float bidAmount = rs1.getFloat(2);
                Timestamp bidTimeStamp = rs1.getTimestamp(3);
                String bidTime = dateFormat.format(bidTimeStamp);
                
                String[] bidInfo = {auctionId, String.valueOf(bidAmount), bidTime};
                bidList.add(bidInfo);
            }
            
            for(String[] bidInfo: bidList){
    %>
                <!-- display bid history entry and delete button -->
                <p>
                    Auction ID: <%= bidInfo[0] %> 
                    Bid Amount: <%= bidInfo[1] %> 
                    Bid Time: <%= bidInfo[2] %>
                    <form action="ProcessBidDelete.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="username" value="<%= username %>">
                        <input type="hidden" name="auctionId" value="<%= bidInfo[0] %>">
                        <input type="hidden" name="bidAmount" value="<%= bidInfo[1] %>">
                        <input type="hidden" name="bidTime" value="<%= bidInfo[2] %>">
                        <button type="submit">Delete</button>
                    </form>
                </p>
    <%
            }
            
            stmt1.close();
            rs1.close();
            conn.close();   
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("CreateEndUserAccount.jsp").forward(request, response);
        }
        
        
    } else {
        // Handle the case where no username was submitted
        %>
        <p>Please enter a username to view bid history.</p>
        <%
    }
    %>
</body>
</html>