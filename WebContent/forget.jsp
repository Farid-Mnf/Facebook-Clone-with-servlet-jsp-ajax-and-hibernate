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
        <%
            String error = request.getParameter("error");
            if(error!=null){
                out.println("<script>"
                        + "alert('this email do not exist !');"
                        + "</script>");
            }
            %>
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
        <div class="container">
            <form action="code.jsp" method="POST">
                <div class="input">
                    <input name="email" type="email" placeholder="Enter your Email?"/>
                </div>
                <h6 class="recovery">*Recovery Code will be sent to this email !</h6>
                <div class="button">
                    <input type="submit" value="Continue"/>
                </div>
            </form>
        </div>
    </body>
</html>
