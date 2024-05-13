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

<%
    try {
        String username = request.getParameter("username");
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
        String query = "SELECT end_user_username, end_user_password FROM end_user WHERE end_user_username = '" +username+ "'";
        ResultSet rs = stmt.executeQuery(query);

        if(rs.next()) {
            String fetchedPassword = rs.getString("end_user_password");
%>
            <!-- current username and password -->
            <p>Current Username: <%= username %></p>
            <p>Current Password: <%= fetchedPassword %></p>

            <form action="ProcessAccountUserChange.jsp" method="post">
                <label for="newUsername">New Username:</label>
                <input type="text" id="newUsername" name="newUsername"><br>
                <input type="hidden" name="username" value="<%= username %>">
                <input type="submit" value="Update Username">
            </form>

            <form action="ProcessAccountPassChange.jsp" method="post">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword"><br>
                <input type="hidden" name="username" value="<%= username %>">
                <input type="submit" value="Update Password">
            </form>
<%
        } else {
%>
            <p>User not found.</p>
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