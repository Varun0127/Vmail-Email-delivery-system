<%@ page import="java.sql.*" %>
<%
    String vmailAddress = request.getParameter("vmailAddress");
    String message = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vmail", "root", "root");
        
        String query = "SELECT * FROM users WHERE vmailaddress=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, vmailAddress);
        
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            message = "not available";
        } else {
            message = "available";
        }
        
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    out.print(message);
%>
