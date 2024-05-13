<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Generate Sales Report</title>
</head>
<body>
<%
    String dbURL = "jdbc:mysql://localhost:3306/cs336project?useSSL=false";
    String dbUsername = "root";
    String dbPassword = "cs336";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        stmt = conn.createStatement();
        
		/*==========================================================================================================*/

        // Total Earnings
        out.println("<h2>Total Earnings:</h2>");
        String sqlTotalEarnings = "SELECT SUM(bid_amount) AS Total_Earnings FROM bid";
        rs = stmt.executeQuery(sqlTotalEarnings);
        if (rs.next()) {
            out.println("<p>Total Earnings: " + rs.getDouble("Total_Earnings") + "</p>");
        }
        
        /*==========================================================================================================*/

        // Earnings Per Item Type
        out.println("<h2>Earnings Per Item Type:</h2>");
        String query = "SELECT pc_part.*, auction.auction_id, SUM(bid.bid_amount) AS total_earnings " +
                       "FROM pc_part " +
                       "JOIN auction ON pc_part.item_id = auction.pc_part " +
                       "JOIN bid ON auction.auction_id = bid.auction_id " +
                       "GROUP BY pc_part.item_id, pc_part.status, pc_part.brand, pc_part.cpu_clock_speed, pc_part.cpu_cores, pc_part.cpu_threads, " +
                       "pc_part.ram_ddr, pc_part.ram_size, pc_part.motherboard_socket, pc_part.gpu_vram, pc_part.gpu_clockspeed, " +
                       "pc_part.psu_certification, pc_part.psu_watts, pc_part.hdd_rpm, pc_part.hdd_size, pc_part.ssd_size, pc_part.ssd_speed, auction.auction_id";
        rs = stmt.executeQuery(query);

        Map<String, Double> earningsPerType = new HashMap<>();
        while (rs.next()) {
            String itemType = determineItemType(rs);
            Double currentEarnings = earningsPerType.getOrDefault(itemType, 0.0);
            earningsPerType.put(itemType, currentEarnings + rs.getDouble("total_earnings"));
        }

        out.println("<table border='1'><tr><th>Item Type</th><th>Earnings</th></tr>");
        for (Map.Entry<String, Double> entry : earningsPerType.entrySet()) {
            out.println("<tr><td>" + entry.getKey() + "</td><td>" + String.format("%.2f", entry.getValue()) + "</td></tr>");
        }
        out.println("</table>");
        
        /*==========================================================================================================*/
        
        // Earnings Per Item
        out.println("<h2>Earnings Per Item:</h2>");
        String sqlEarningsPerItem = "SELECT auction.pc_part, SUM(bid.bid_amount) AS Earnings_Per_Item FROM bid JOIN auction ON bid.auction_id = auction.auction_id GROUP BY auction.pc_part";
        rs = stmt.executeQuery(sqlEarningsPerItem);
        out.println("<table border='1'><tr><th>Item ID</th><th>Earnings</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("pc_part") + "</td><td>" + rs.getDouble("Earnings_Per_Item") + "</td></tr>");
        }
        out.println("</table>");
        
        /*==========================================================================================================*/

        // Earnings Per End-User
        out.println("<h2>Earnings Per End-User:</h2>");
        String sqlEarningsPerUser = "SELECT bid.end_user_username, SUM(bid_amount) AS Earnings_Per_User FROM bid GROUP BY bid.end_user_username";
        rs = stmt.executeQuery(sqlEarningsPerUser);
        out.println("<table border='1'><tr><th>End User</th><th>Earnings</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("end_user_username") + "</td><td>" + rs.getDouble("Earnings_Per_User") + "</td></tr>");
        }
        out.println("</table>");
        
        /*==========================================================================================================*/
        
        // Best-Selling Item Type
        out.println("<h2>Best-Selling Item Type:</h2>");
        String sqlItemsEarnings = "SELECT pc_part.*, SUM(bid.bid_amount) AS total_earnings " +
                                  "FROM pc_part JOIN auction ON pc_part.item_id = auction.pc_part " +
                                  "JOIN bid ON auction.auction_id = bid.auction_id " +
                                  "GROUP BY pc_part.item_id";
        rs = stmt.executeQuery(sqlItemsEarnings);
        Map<String, Double> typeEarnings = new HashMap<>();
        while (rs.next()) {
            String itemType = determineItemType(rs);
            typeEarnings.put(itemType, typeEarnings.getOrDefault(itemType, 0.0) + rs.getDouble("total_earnings"));
        }
        String bestType = null;
        double maxEarnings = 0;
        for (Map.Entry<String, Double> entry : typeEarnings.entrySet()) {
            if (entry.getValue() > maxEarnings) {
                bestType = entry.getKey();
                maxEarnings = entry.getValue();
            }
        }
        out.println("<table border='1'><tr><th>Item Type</th><th>Total Earnings</th></tr>");
        out.println("<tr><td>" + bestType + "</td><td>" + String.format("%.2f", maxEarnings) + "</td></tr>");
        out.println("</table>");
        
        /*==========================================================================================================*/

        // Best-Selling End-User
        out.println("<h2>Best-Selling End-User:</h2>");
        String sqlBestUser = "SELECT end_user_username, SUM(bid_amount) AS total_spent " +
                             "FROM bid GROUP BY end_user_username ORDER BY total_spent DESC LIMIT 1";
        rs = stmt.executeQuery(sqlBestUser);
        
        out.println("<table border='1'><tr><th>End User</th><th>Total Spent</th></tr>");
        if (rs.next()) {
            out.println("<tr><td>" + rs.getString("end_user_username") + "</td><td>" + String.format("%.2f", rs.getDouble("total_spent")) + "</td></tr>");
        }
        out.println("</table>");

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>

<%!
    // Utility method to determine the type of item based on non-null properties
    String determineItemType(ResultSet rs) throws SQLException {
        if (rs.getObject("cpu_cores") != null) return "CPU";
        if (rs.getObject("ram_size") != null) return "RAM";
        if (rs.getObject("motherboard_socket") != null) return "Motherboard";
        if (rs.getObject("gpu_vram") != null) return "GPU";
        if (rs.getObject("psu_watts") != null) return "Power Supply";
        if (rs.getObject("hdd_size") != null) return "HDD";
        if (rs.getObject("ssd_size") != null) return "SSD";
        return "Other";
    }
%>
</body>
</html>