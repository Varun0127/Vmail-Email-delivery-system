<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.List, com.vmail.model.ConnectionProvider" %>
<%
   try {
	   	Connection conn= ConnectionProvider.getConnection(); 
        //int email_id=Integer.parseInt(request.getParameter("id"));
        String status= request.getParameter("status");
        String newStatus="";
        PreparedStatement pstmt=null;
        if(status.equals("unread")){
        	pstmt = conn.prepareStatement("update emails set status='read' where email_id=?");
        	newStatus="read";
        }
        else if(status.equals("read")){
        	pstmt = conn.prepareStatement("update emails set status='unread' where email_id=?");  	
        	newStatus="unread";
        }
        pstmt.setInt(1,  Integer.parseInt(request.getParameter("id")));
        int i = pstmt.executeUpdate();
        
        if(i>0){
        	session.setAttribute("dstatus", "success");
            session.setAttribute("dmessage", "Conversation marked as "+newStatus+".");
        	String folder = request.getParameter("folder");
                String forwardPage = folder + ".jsp";
                pageContext.forward(forwardPage);
        }
        else{
        	String tempState="read".equals(status)?"unread":"read";
        	session.setAttribute("dstatus", "danger");
        	session.setAttribute("dmessage", "Unable to mark conversation as "+tempState+".");
        	String folder = request.getParameter("folder");
            String forwardPage = folder + ".jsp";
            pageContext.forward(forwardPage);
        	
        }
        
        
        conn.close();
        
        
    } catch (Exception e) {
        e.printStackTrace();
    }
%>