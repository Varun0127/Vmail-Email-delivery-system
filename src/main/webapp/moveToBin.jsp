<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.List, com.vmail.model.ConnectionProvider" %>
<%
   try {
	   	Connection conn= ConnectionProvider.getConnection();
        //int email_id=Integer.parseInt(request.getParameter("id"));
        PreparedStatement pstmt = conn.prepareStatement("update emails set folder='bin' where email_id=?");
        pstmt.setInt(1,  Integer.parseInt(request.getParameter("id")));
        int i = pstmt.executeUpdate();
        pstmt = conn.prepareStatement("insert into bins (email_id, previous_folder) VALUES (?, ?)");
        pstmt.setInt(1,  Integer.parseInt(request.getParameter("id")));
        pstmt.setString(2, request.getParameter("folder"));
        int j = pstmt.executeUpdate();
        if(i>0 && j>0){
        	session.setAttribute("dstatus", "success");
            session.setAttribute("dmessage", "Conversation moved to Bin.");
        	String folder = request.getParameter("folder");
                String forwardPage = folder + ".jsp";
                pageContext.forward(forwardPage);
        	
        }
        else{
        	session.setAttribute("dstatus", "danger");
        	session.setAttribute("dmessage", "Can't move conversation to Bin.");
        	String folder = request.getParameter("folder");
            String forwardPage = folder + ".jsp";
            pageContext.forward(forwardPage);
        	
        }
        
        
        
        conn.close();
        
        
    } catch (Exception e) {
        e.printStackTrace();
    }
%>