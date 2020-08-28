<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="service.LoadComments"%>
<%@page import="service.GetFile"%>
<%@page import="service.UserData"%>
<%@page import="java.util.List"%>
<%@page import="dto.*" language="java"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <title>Profile</title>
        <style type="text/css">
            #sampleFile{
                visibility: hidden
            }
            #form1{
                position:relative;
                
                left:980px;
            }
   
            .prof-img{
                outline: 1px solid #79bc64;
            }
            .coverarea {position: relative;top: 0;left: 0;}
            .userFullName {
                    position: absolute;
                    top: -13px;
                    left: -10px;
                    font-size: 30px
            }
            .upload-form1 {position: absolute;top:400px;left:200px;}
            .upload-form2 {position: absolute;top:400px;left:700px;}
        </style>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setHeader("Pragma", "no-cache");
        %>

        <%! User user;
            SessionFactory sessionFactory;
            Session dbSession;
        %>
        <%@include file="check.jsp" %>

        <%  
            sessionFactory = (SessionFactory) application.getAttribute("sessionFactory");
            System.out.println("Factory: "+sessionFactory);
            dbSession = sessionFactory.openSession();
            System.out.println("Session: "+dbSession);
            dbSession.beginTransaction();  
        %> 

        <nav class="navbar-expand-lg navbar-light bg-light fixed-top">
            <div style="background: #1877F2; padding: 10px 20px; margin: 0px"
                 class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active"><a class="nav-link"
                                                   href="timeline.jsp"> <img width=30 height=30 alt="facebook logo"
                                                  src="Images/facebook.png">
                        </a></li>
                    <li style="font-weight: bolder" class="nav-item active"><a
                            style="color: white" class="nav-link" href="timeline.jsp">Facebook
                            <span class="sr-only">(current)</span>
                        </a></li>
                    <li class="nav-item"><a class="nav-link" href="timeline.jsp">Home</a></li>
                    <li class="nav-item dropdown"><a
                            class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                            role="button" data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false"> Timeline </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Images</a> <a
                                class="dropdown-item" href="#">Videos</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">About</a>
                        </div></li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search"
                           placeholder="Search" aria-label="Search">
                    <button style="color: white"
                            class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
            </div>
        </nav>
        <!-- COVER -->
        <div class="container">
            <div class="coverarea">
                <img alt="cover" src="Images/<%= user.getCoverPicture()%>" width="100%" height="400px">
                <div class="profile-picture">

    <!--################## Profile Upload Form ################################-->
                    
                <form id="form1">    
                    <label for="sampleFile" class="btn btn-primary">Change Avatar</label>
                    <input  onchange="performAjaxSubmit()" id="sampleFile" name="sampleFile" type="file" /> <br/>
                </form>
    
    <!--################## Profile Upload Form ################################-->

                    <div style="position: relative">
                        <img id="profileView" style="position: absolute;left:10px;top:-154px;border-radius: 100%;border:4px dashed #0089ff;background-color: #b9cbe2" alt="profile picture"
                         src="Images/<%= user.getProfilePicture()%>" width="150px" height="150px">
                        <h3  class="userFullName badge badge-secondary">
                        <%
                            out.println(user.getFirstName() + " " + user.getLastName());
                        %>
                        </h3>
                    </div>
                </div>
            </div>
        </div>

        <br>
        <br>
        <hr>
        <br>
        <div class="container">
            <div style="width: 700px; margin: 0 auto;padding:1em 3em" class="jumbotron">
                <h5 class="display-6"><img src="Images/<%= user.getProfilePicture()%>" style="border-radius: 100%" width=50 height=50/> <%= user.getFirstName() + " " + user.getLastName()%> </h5>
                <form action="post" method="post">
                    <textarea name="post" rows="5" cols="60" placeholder="What is in your mind, <%=user.getFirstName()%>?">
                    </textarea>

                    <p class="lead">
                        <input type="submit" value="Post" class="btn btn-primary btn-lg" />
                    </p>
                </form>
            </div>
                              
            <hr>
            <%
                Query query = dbSession.createQuery("from Post where user_id= :user_id");
                query.setInteger("user_id", user.getId());
                List<Post> posts = (List<Post>) query.list();
                for (Post post : posts) {
            %>

            <div style="width: 700px; margin: 0 auto" class="jumbotron">
                <h1 style="font-size:1.5em"><img src="Images/<%= user.getProfilePicture()%>" style="border-radius: 100%" width=50 height=50/> <%= user.getFirstName() + " " + user.getLastName()%> </h1>
                <p><%= post.getDate()%></p>
                <p class="lead"><%= post.getContent()%></p>
                <form action="comment" method="post">
                    <input style="visibility:hidden" type="text" value="<%= post.getId()%>" name="postId"/>
                    <input style="visibility:hidden" type="text" value="<%=user.getId()%>" name="userId"/>

                    <input style="visibility:hidden" type="text" value='<%= user.getFirstName() + user.getLastName()%>' name="userFullName" />
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text" style="padding:1px"><img src="Images/<%= user.getProfilePicture()%>" width="30px" height="30px"/></span>
                        </div>
                        <input name="comment" placeholder="Your comment, <%=user.getFirstName()%>?" type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
                        <div class="input-group-append">
                            <span class="input-group-text">
                                <input  type="submit" value="" style='background: url(Images/send.png);
                                        background-size: cover;
                                        padding-left: 20px;
                                        border: none'/>
                            </span>
                        </div>
                    </div>
                </form>
                <div style="background-color:#dae0e5">
                <%
                    int commentPostId = post.getId();
                    Query commentQuery = dbSession.createQuery("from Comment where post_id= :post_id");
                    commentQuery.setInteger("post_id", commentPostId);
                    List<Comment> comments = (List<Comment>) commentQuery.list();
                    User commentUser;
                    for (Comment comment : comments) {
                        commentUser = comment.getUser();
                        String comment_user_name = commentUser.getFirstName() + " " + commentUser.getLastName();
//                      
                %>
                
                <div style="padding-bottom: 20px" class="row">
                    <div class="col-sm-9" style="background-color: #f8f9fa;
    border-radius: 10px;
    margin-top: 10px;
    margin-left: 25px;">
                        <a href="#"> <%= comment_user_name%> </a>
                        <div class="row">
                            <div class="col-8 col-sm-3">
                                <img src="Images/<%= commentUser.getProfilePicture()%>" style="margin-left:25px;margin-bottom: 10px" width="30px" height="30px">
                            </div>
                            <div class="col-4 col-sm-9">
                                <%= comment.getCommentText()%>
                            </div>
                        </div>
                    </div>
                </div>

                <%
                    }
                %>
                </div>
            </div>
            <hr>
            <%
                }
            %>
            
<%
request.getSession().setAttribute("user", user);
%>
        </div>

            <%@include file="check2.jsp" %>

        
        <script 
            src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
        </script>
        <script>
              function performAjaxSubmit() {


                var sampleFile = document.getElementById("sampleFile").files[0];

                var formdata = new FormData();

                formdata.append("sampleFile", sampleFile);

                var xhr = new XMLHttpRequest();       

                xhr.open("POST","/upload", true);

                xhr.send(formdata);

                xhr.onload = function(e) {
                    var profileView = document.getElementById('profileView');
                    profileView.src = '/Images/loader.png';
                    if (this.status == 200) {
                       var imageName = this.responseText;
                       setTimeout(function() {
                           profileView.src = imageName;
                       }, 3000);
                    }
                };                    
            }   
        </script>

        <script
            src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
        crossorigin="anonymous"></script>
    </body>
</html>