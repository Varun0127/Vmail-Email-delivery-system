<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Session Attributes</title>
</head>
<body>

<h1>Session Attributes</h1>

<ul>
<%
    // Get all attribute names
    java.util.Enumeration<String> attributeNames = session.getAttributeNames();

    // Iterate over all attribute names and display them
    while(attributeNames.hasMoreElements()) {
        String attributeName = attributeNames.nextElement();
        Object attributeValue = session.getAttribute(attributeName);
%>
    <li><%= attributeName %> : <%= attributeValue %></li>
<%
    }
%>
</ul>

</body>
</html>
