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
            
            .success {
                width:30%;
                margin:0 auto;
            }
            .success img {
                display: block;
                width:100%;
                height: 40%;
            }
            .container h4{
                margin:0 auto;
                margin-top: 50px;
                margin-bottom: 20px;
                text-align: center
            }
            .container h4 a {
                text-decoration: none;
                color:white;
                background: #031D2E;
                padding:10px 15px;
                border-radius: 5px;
                border: 3px solid #2BB673;
                font-weight: lighter;
            }
            .container h4 a:hover {
                background: #2BB673;
                transition: ease-in-out;
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
                String enteredCode = request.getParameter("code");
                String email = request.getParameter("email");
                
                
                String password = request.getParameter("newPassword");
                String rePassword = request.getParameter("reNewPassword");
                
                if(password.equals(rePassword)){

                    SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
                    Session dbSession = sessionFactory.openSession();
                    dbSession.beginTransaction();
                    Query query = dbSession.createQuery("from User where email=:userEmail");
                    query.setParameter("userEmail", email);
                    User user = (User) query.uniqueResult();
                    user.setPassword(password);
                    dbSession.update(user);
                    
                    %>
                    <div class="container">
                        <div class="success">
                            <img src="Images/success.png"/>
                        </div>
                        <h4><a href="index.jsp">Login?</a></h4>
                    </div>
                    <%
                        dbSession.getTransaction().commit();
                        dbSession.close();
                    
                }else{
                    response.sendRedirect("password.jsp?email=" + email + "&code=" + enteredCode);
                }
            
            %>
                
                
                
                
    </body>
</html>
