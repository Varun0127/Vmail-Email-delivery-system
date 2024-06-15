<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    System.out.println("User ID: " + session.getAttribute("email")); 
    try {
        
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vmail", "root", "root"); 
        
        String query = "SELECT * FROM Emails WHERE recipient_id = ? and status=? order by created_at desc"; 
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, (String) session.getAttribute("email"));
        pstmt.setString(2, "sent"); 
        rs = pstmt.executeQuery();

        JSONArray jsonArray = new JSONArray();
 
        while (rs.next()) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("email_id", rs.getInt("email_id"));
            jsonObject.put("sender_id", rs.getString("sender_id"));
            jsonObject.put("subject", rs.getString("subject"));
            jsonObject.put("message", rs.getString("message"));
            jsonObject.put("status", rs.getString("status"));
            jsonObject.put("created_at", rs.getString("created_at"));
            jsonObject.put("updated_at", rs.getString("updated_at"));

            jsonArray.put(jsonObject);
        }

        out.print(jsonArray.toString());

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
