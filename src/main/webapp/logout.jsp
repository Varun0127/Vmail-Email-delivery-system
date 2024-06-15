<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    
    <script>
        var countdown = 3;

        function redirect() {
            if (countdown > 0) {
                document.getElementById("countdown").innerHTML = countdown;
                countdown--;
                setTimeout(redirect, 1000); 
            } else {
                window.location.href = 'login.jsp';
            }
        }
        window.onload = function() {
            redirect();
        };
    </script>
</head>
<body>

<div class="container">
    <h2>Logged Out Successfully</h2>
    <p>You have been logged out successfully.</p>
    
    <!-- Countdown display -->
    <p>Redirecting to <a href="login.jsp">Login</a> in <span id="countdown">3</span> seconds...</p>
</div>

</body>
</html>