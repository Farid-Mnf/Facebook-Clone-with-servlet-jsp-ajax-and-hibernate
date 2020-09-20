<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.User"%>
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
//            String noValidate = request.getParameter("noValidate");
//            if(noValidate!=null){
            String enteredCode = request.getParameter("code");
            String email = request.getParameter("email");

            SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
            Session dbSession = sessionFactory.openSession();
            dbSession.beginTransaction();
            Query query = dbSession.createQuery("from RecoveryCode where email=:email and code=:code");
            query.setParameter("email", email);
            query.setParameter("code", enteredCode);


            if(query.uniqueResult()!=null){
                %>
                
                
                
                <div class="container">
                    <form action='success.jsp?email=<%=email%>&code=<%=enteredCode%>' method="POST">
                        <div class="input">
                            <input name="newPassword" type="text" placeholder="Enter new Password"/>
                        </div>
                        <div class="input">
                            <input name="reNewPassword" type="text" placeholder="Re-Enter new Password"/>
                        </div>
                        <div class="button">
                            <input type="submit" value="Continue"/>
                        </div>
                    </form>
                </div>
            <%
                dbSession.getTransaction().commit();
                dbSession.close();
            }else{
                // the code is wrong redirect again to input code
                response.sendRedirect("code.jsp?email=" + email);
            }
            %>
    </body>
</html>
