<%@page import="service.UserData"%>
<%@page import="service.RecoveryEmail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Facebook</title>
        <style>
            .logo {
                margin-left: 20px;
            }
            .facebook-logo {
                margin:0 0 0 30px;
                color:white
            }
            .container {
                color:white;
                padding:20px;
                border-radius: 10px;
                background:#072A41;
                margin: 15% auto;
                width:40%;
            }
            .container .input {
                width:90%;
                margin:0 auto;
                padding:20px;
                
            }
            .container .input input {
                width:100%;
                padding:15px 20px;
                border-radius: 5px;
                border:none;
                background:  #1A4464;
                color:white;
                font-size: 15px;
            }
            .container .input input::placeholder {
                color:white;
                opacity: .5;
            }
            .container .recovery {
                position: relative;
                top:-15px;
                left: 50px;
                font-weight:  lighter;
                font-size: 10px;
                
            }
            .container .button {
                margin: 0 auto;
                width:20%;
                margin-top: 20px;
            }
            .container .button input {
                text-decoration: none;
                color:white;
                border: none;
                cursor: pointer;
                background: #11486be0;
                padding:10px 20px;
                border-radius: 5px;
            }
            .container .button input:hover {
                background: #031D2E;
                transition: ease-in-out;
                transition-duration: .5s
            }
        </style>
    </head>
    <body>
        <nav>
            <!--logo and search-->
            <div class="left-side">
                <div class="logo">
                    <a href="index.jsp"><img src="img/icons/facebook.svg" alt=""></a>
                </div>
                <div class="facebook-logo">
                    <h1>Facebook</h1>
                </div>
            </div>
        </nav>
        <%  
            boolean found = UserData.checkIfExists(request.getParameter("email"), request);
            if(found){
                %>
                
                <div class="container">
                    <form action='password.jsp?email=<%=request.getParameter("email")%>' method="POST">
                        <div class="input">
                            <input name="code" type="text" placeholder="Enter Recover Code?"/>
                        </div>
                            <h6 class="recovery">*Recovery Code is sent to <%=request.getParameter("email")%> !</h6>
                        <div class="button">
                            <input type="submit" value="Continue"/>
                        </div>
                    </form>
                </div>
                <%
                    RecoveryEmail recoveryEmail = new RecoveryEmail(request.getParameter("email"),request);
                    recoveryEmail.sendCode();
                    %>
                
                <%
            }else{
                response.sendRedirect("forget.jsp?error=true");
            }
            %>
        
        
    </body>
</html>
