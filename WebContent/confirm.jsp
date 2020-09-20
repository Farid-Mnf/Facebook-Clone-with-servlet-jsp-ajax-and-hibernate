<%@page import="service.UserData"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="service.ConfirmEmail"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user;
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String reEmail = request.getParameter("reEmail");
    String password = request.getParameter("password");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String year = request.getParameter("year");
    String gender = request.getParameter("gender");
    if(request.getParameter("continue")==null){
        boolean found = UserData.checkIfExists(email,request);
        if (gender != null && firstName != null && lastName != null && email != null && reEmail != null && password != null && month != null && day != null && year != null) {
            if (!found && email.equals(reEmail)) {
                ConfirmEmail confirm = new ConfirmEmail(email, request);
                confirm.sendCode();
                user = new User();
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setPassword(password);
                user.setMonth(month);
                user.setDay(day);
                user.setYear(year);
                user.setGender(gender);
                user.setProfilePicture("facebook.png");
                user.setCoverPicture("facebook.png");
                session.setAttribute("user", user);
            }else{
                response.sendRedirect("index.jsp");        
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }else{
        %>
        <script>
            alert("wrong code");
        </script>
        <%
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Facebook</title>
<link rel="stylesheet" href="confirm.css" type="text/css" />
</head>
<body class="login">
<!-- header starts here -->
<div id="facebook-Bar">
<div id="facebook-Frame">
<div id="logo"> <a href="index.jsp">Facebook</a> </div>
<div id="header-main-right">
<div id="header-main-right-nav">

</div>
</div>
</div>
</div>
<!-- header ends here -->
<div class="loginbox radius">
<h2 style="color:#141823; text-align:center;">Confirm your Email</h2>
<div class="loginboxinner radius">
<div class="loginheader">
<h4 class="title">Enter the confirmation code we have just sent to you</h4>
</div>
<!--loginheader-->
<div class="loginform">
<form id="login" action="signup" method="post">
<p>
<input type="text" id="firstname" name="confirmationCode" placeholder="Confirmation Code?" value="" class="radius mini" />
</p>
<p>
<button class="radius title" name="signup">Continue</button>
</p>
</form>
</div>
</div>
<!--loginboxinner-->
</div>
<!--loginbox-->
</body>
</html>
