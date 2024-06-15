<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*, com.vmail.model.ConnectionProvider" %>
<%
			String status = (String) request.getAttribute("status");		//Mail Successfully sent setAttribute() from composeaction.jsp 
			String message = (String) request.getAttribute("message");		//Mail Successfully sent setAttribute() from composeaction.jsp 
			String login_msg = (String) session.getAttribute("login_msg");
			if(login_msg==null){											//checking for valid session
				request.setAttribute("session_out","Session out! Please login again.");
				request.setAttribute("status", "danger");
		%>
				<jsp:forward page="login.jsp"></jsp:forward>
		<%
			}
		%>

<%
	
	String currentPassword= request.getParameter("currentPassword");
	String newPassword= request.getParameter("newPassword");
	int user_id= (int)session.getAttribute("user_id");
	int i=0;
	String checkPassword=null;
	System.out.println("user_id "+user_id);
	System.out.println("np "+newPassword);
	try {
		Connection conn= ConnectionProvider.getConnection(); 

    	String query = "select password from users WHERE user_id=?";
    	PreparedStatement pstmt = conn.prepareStatement(query);
    	pstmt.setInt(1, user_id);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next())
		{
			checkPassword=rs.getString(1);
		}
		System.out.println("cp " +checkPassword);
		System.out.println(currentPassword.equals(checkPassword));
		if(currentPassword.equals(checkPassword)){
    		query = "update users set password=? WHERE user_id=?";
    		pstmt = conn.prepareStatement(query);
    		pstmt.setString(1, newPassword);
    		pstmt.setInt(2, user_id);
			i = pstmt.executeUpdate();
			if(i>0){
				session.invalidate();
		%>
				<jsp:forward page="login.jsp">
				<jsp:param value="Password reset, Login again." name="passwordmsg"/>
				</jsp:forward>
		<%			
				}
		}
		else{
			
			%>
			<jsp:forward page="settings.jsp">
			<jsp:param value="Incorrect current Password!" name="passwordmsg"/>
			</jsp:forward>
			<%	
		}
		
	}
	catch(Exception e){
		
	}
%>