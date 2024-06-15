<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.List, com.vmail.model.ConnectionProvider" %>
<%
   try {
	   	Connection conn= ConnectionProvider.getConnection(); 
	   	//int email_id=Integer.parseInt(request.getParameter("id"));
        
        PreparedStatement pstmt = conn.prepareStatement("delete from bins where email_id=?");
        pstmt.setInt(1,  Integer.parseInt(request.getParameter("id")));
        
        int j = pstmt.executeUpdate();
        
         pstmt = conn.prepareStatement("delete from emails where email_id=? and folder='bin'");
        pstmt.setInt(1,  Integer.parseInt(request.getParameter("id")));
        int i = pstmt.executeUpdate();
        if(i>0 && j>0){
        	session.setAttribute("dstatus", "success");
            session.setAttribute("dmessage", "Conversation deleted forever.");
        	%>
        	<jsp:forward page="bin.jsp"></jsp:forward> 
        	<%
        }
        else{
        	session.setAttribute("dstatus", "danger");
        	session.setAttribute("dmessage", "Unable to delete Conversation forever.");
        	%>
        	<jsp:forward page="bin.jsp"></jsp:forward> 
        	<%
        }
        
        
        conn.close();
        
        
    } catch (Exception e) {
        e.printStackTrace();
    }
%>