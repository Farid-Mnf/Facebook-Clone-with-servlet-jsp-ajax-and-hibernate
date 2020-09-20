
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.Query"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/style.css">
        <title>Facebook</title>
        <style>
            .content{
                width:600px;
                height: auto;
                margin:50px auto;
            }
            .content .profile:first-child {
                border-radius: 10px 10px 0 0;
            }
            .content .profile:last-of-type {
                border-radius: 0 0 10px 10px;
            }
            .content hr {
                width: 500px;
                margin:0 auto;
                opacity: 0;

            }
            .content .profile {
                width: 100%;
                height: 100%;
                padding:10px;
                background: #1A4464;
            }
            .content .profile .user-avatar img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                margin: 10px;
            }
            .content .profile {
                display: flex;
                flex-direction: row;
                color: white;
            }
            
            .profile-area {
                width:80%;
            }
            .button-area {
                margin-top: 40px;
            }
            .addButton {
                cursor: pointer;
                background-color: #031D2E;
                color: white;
                border: none;
                border-radius: 5px;
                padding:10px;
            }
        </style>
    </head>
    <body>
<%
    response.setHeader("Cache-Control", "no-cache, no-store");
    response.setHeader("Pragma", "no-cache");
%>

<%! 
    User user;
    SessionFactory sessionFactory;
    Session dbSession;
%>
    <%
user = (User) session.getAttribute("user");
sessionFactory = (SessionFactory) application.getAttribute("sessionFactory");
dbSession = sessionFactory.openSession();
%>
    <%@ include file = "check.jsp" %>

        <nav>
            <!--logo and search-->
            <div class="left-side">
                <div class="logo">
                    <img src="img/icons/facebook.svg" alt="">
                </div>

                <div class="search">
                    <input type="text" placeholder="Search Facebook" name="" id="">
                </div>
            </div>

            <!--tab icons-->
            <div class="tabs">
                <div class="tab-icon">
                    <div class="icon">
                        <a href="timeline.jsp"><img src="img/icons/home.svg" alt=""></a>
                    </div>
                </div>

                <div class="tab-icon active">
                    <div class="icon">
                        <a href="peopleyoumayknow.jsp"><img src="img/icons/users.svg" alt=""></a>
                    </div>
                </div>
            </div>

            <!--right side-->
            <div class="right-side">
                <div class="user">
                    <div class="profile">
                        <a href="profile.jsp"><img onerror="this.src='/Images/facebook.png'"
                                src="Images/<%= user.getProfilePicture() %>" alt=""></a>
                    </div>
                    <h4><a style="color:white" href="profile.jsp"><%=user.getFirstName()%></a></h4>

                </div>

                <!--icons-->
                <div class="user-icons">

                    <div class="icon has-notification">
                        <img src=" img/icons/messenger.svg" alt="">
                    </div>

                    <div class="icon">
                        <img src="img/icons/bell.svg" alt="">
                    </div>

                    <div class="icon">
                        <a style="color:white;font-size: 15px" href="logout">Logout</a>
                    </div>
                </div>
            </div>
        </nav>
                
                    
                <%
                    dbSession.beginTransaction();
                    Query query = dbSession.createQuery("from User user where not user.id=:userId");
                    query.setParameter("userId", user.getId());
                    List<User> allUsers = query.list();
                    
                    
                %>
                <%
                    if(allUsers.size()!=0){
                %>  
        
        <div class="content">
        <%
            for(User someUser : allUsers){
        %>
            <div class="profile">
                <div class="profile-area">
                    <div class="user-avatar">
                        <img src="Images/<%=someUser.getProfilePicture()%>"/>
                    </div>
                    <div class="user-name">
                        <%=someUser.getFirstName() + " " + 
                                someUser.getLastName() %>
                    </div>
                </div>
                <div class="button-area">
                    <button onclick="addFriend(<%=someUser.getId() %>)"  class="addButton">Add Friend</button>
                </div>
            </div>
            <hr>
        <%
            }
            dbSession.getTransaction().commit();
            dbSession.close();
        %>
        </div>
    <%
        }
    %>
    </body>
    
    <script>
    </script>
    
    <script src="js/jquery.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/index.js"></script>
    
<%@include file="check2.jsp"%>
</html>
