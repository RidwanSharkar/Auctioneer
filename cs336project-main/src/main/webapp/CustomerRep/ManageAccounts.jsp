<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Users</title>
</head>
<body>

    <h3>Enter the Username of the Customer Representative You Would Like to Message</h3>

    <form action="MessageCustomerRep.jsp" method="post">
    </form>

    <h3>List of End User Accounts</h3>

    <%
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

            Statement stmt = conn.createStatement();
            String query = "SELECT * FROM end_user";
            ResultSet rs = stmt.executeQuery(query);

            while(rs.next()){
                String username = rs.getString(1);
    %>
                <!-- display end user account details and buttons -->
                <p><%= username %>
                    <form action="EditAuctions.jsp" method="get" style="display: inline;">
                        <input type="hidden" name="username" value="<%= username %>">
                        <button type="submit">Edit Auctions</button>
                    </form>
                    <form action="EditBids.jsp" method="get" style="display: inline;">
                        <input type="hidden" name="username" value="<%= username %>">
                        <button type="submit">Edit Bids</button>
                    </form>
                    <form action="EditAccountInfo.jsp" method="get" style="display: inline;">
                        <input type="hidden" name="username" value="<%= username %>">
                        <button type="submit">Edit Account Information</button>
                    </form>
                    <form action="ProcessAccountDelete.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="username" value="<%= username %>">
                        <button type="submit">Delete</button>
                    </form>
                </p>
    <%
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            // Handle database error
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("ManageAccounts.jsp").forward(request, response);
        }
    %>

</body>
</html>