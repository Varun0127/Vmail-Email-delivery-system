<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*, com.vmail.model.ConnectionProvider" %>
<%
	String email= request.getParameter("emailPhone");
	String otp= request.getParameter("otp");
	
	try {
		Connection conn= ConnectionProvider.getConnection();
        
        String query = "SELECT * FROM users WHERE vmailaddress=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
        
        if (!rs.next()) {
        	request.setAttribute("emailError", "Couldn't find your Account");
        	request.setAttribute("emailMobile", email); 
    		request.setAttribute("otp", otp);
%>
			<jsp:forward page="forgot-password.jsp"></jsp:forward>
<%
        } 
        else {
            if( otp.equals("123456"))
			{
            	request.setAttribute("emailMobile", email);
%>
				<jsp:forward page="change-password.jsp"></jsp:forward>
<%
			}
			else{
				request.setAttribute("otpError", "Invalid OTP!");
        		request.setAttribute("emailMobile", email); 
        		request.setAttribute("otp", otp);
%>
			<jsp:forward page="forgot-password.jsp"></jsp:forward>
<%
			}
       }
        
    }
	catch(Exception e){
	}
%>