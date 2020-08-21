<%@page import="service.LoadComments"%>
<%@page import="service.GetFile"%>
<%@page import="service.UserData"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@ page import="dto.*" language="java"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<title>Profile</title>
<style type="text/css">
    .coverarea {position: relative;top: 0;left: 0;}
    .profile-picture {position: absolute;top: 120px;left: 50px;}
    .user-name {background: graytext;position: absolute;bottom: 30;left: 0;font-size: 25px}
    .upload-form1 {position: absolute;top:100px;left:150px;}
    .upload-form2 {position: absolute;top:100px;left:500px;}
</style>
</head>
<body>
<%
    response.setHeader("Cache-Control", "no-cache, no-store");
    response.setHeader("Pragma", "no-cache");
%>

<%! User user; Connection con;  %>
<%@include file="check.jsp" %>
<% 
String profilePicture = service.GetFile.get(user.getId(),con,"profile");
String coverPicture = service.GetFile.get(user.getId(),con,"cover");
if(profilePicture!=null){
    user.setProfilePicture(profilePicture);
}
if(coverPicture!=null){
    user.setCoverPicture(coverPicture);
}

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
			<img alt="cover" src="Images/<%= user.getCoverPicture() %>" width="100%" height="400px">
			<div class="profile-picture">
			
<form class="upload-form1" action="upload" method="POST" enctype="multipart/form-data">
        <div class="input-group">	
                <div class="custom-file">
                        <input style="width:300px" type="file" name="profile" size="50" class="custom-file-input" id="inputGroupFile04">
                        <label class="custom-file-label" for="inputGroupFile04">Update Photo</label>
                </div>
                <div class="input-group-append">
                        <input type="submit" value="Change" class="btn btn-info"/>
                </div>
        </div>
</form>
	
                            
<form class="upload-form2" action="uploadCover" method="POST" enctype="multipart/form-data">
        <div class="input-group">
                <div class="custom-file">
                        <input style="width:300px" type="file" name="cover" size="50" class="custom-file-input" id="inputGroupFile04">
                        <label class="custom-file-label" for="inputGroupFile04">Update Cover</label>
                </div>
                <div class="input-group-append">
                        <input type="submit" value="Change" class="btn btn-info"/>
                </div>
        </div>
</form>
				
				
				<img style="border-radius: 100%" alt="profile picture"
					src="Images/<%= user.getProfilePicture() %>" width="150px" height="150px">
				<h3 class="user-name">
					<%
					out.println(user.getFirstName() + " " + user.getLastName());
					%>
				</h3>
			</div>
		</div>
	</div>
	
	<br>
	<br>
	<br>
	<hr>
	<br>
	<br>
	<br>
	<div class="container">
            <div style="width: 700px; margin: 0 auto" class="jumbotron">
            <h1 class="display-4"><img src="Images/<%= user.getProfilePicture() %>" style="border-radius: 100%" width=100 height=100/> <%= user.getFirstName()+" "+user.getLastName() %> </h1>
                    <form action="post" method="post">
                            <textarea name="post" rows="5" cols="60"
                                    placeholder="What is in your mind, <%=user.getFirstName()%>?"></textarea>

                            <p class="lead">
                                    <input type="submit" value="Post" class="btn btn-primary btn-lg" />
                            </p>
                    </form>
            </div>

            <hr>
            <% 
            java.util.List<Post> posts = service.ProfilePosts.getProfilePosts(user.getId(), con);
            for(Post post : posts){
            %>

            <div style="width: 700px; margin: 0 auto" class="jumbotron">
                <h1 class="display-4"><img src="Images/<%= user.getProfilePicture() %>" style="border-radius: 100%" width=100 height=100/> <%= user.getFirstName()+" "+user.getLastName() %> </h1>
                <p><%= post.getDate().substring(0, post.getDate().length()-2) %></p>
                <hr class="my-4">
                <p class="lead"><%= post.getContent() %></p>
                <hr class="my-4">
                <form action="comment" method="post">
                    <input style="visibility:hidden" type="text" value="<%=post.getPost_id()%>" name="postId"/>
                    <input style="visibility:hidden" type="text" value="<%=user.getId()%>" name="userId"/>

                    <input style="visibility:hidden" type="text" value='<%= user.getFirstName()+user.getLastName()%>' name="userFullName" />
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                        <span class="input-group-text" style="padding:1px"><img src="Images/<%= user.getProfilePicture() %>" width="30px" height="30px"/></span>
                      </div>
                      <input name="comment" placeholder="Your comment, <%=user.getFirstName() %>?" type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
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
                <%
                List<Comment> comments = LoadComments.getPostComments(post.getPost_id(), con);
                User commentUser;
                for(Comment comment: comments){
                    commentUser = UserData.getUserById(comment.getComment_user_id(), con);
                    String comment_user_name = commentUser.getFirstName()+" "+commentUser.getLastName();
                    String user_image = GetFile.get(comment.getComment_user_id(), con, "profile");
                    
                    %>
                <hr>
                <div class="row">
                    <div class="col-sm-9">
                        <a href="#"> <%= comment_user_name %> </a>
                      <div class="row">
                        <div class="col-8 col-sm-3">
                            <img src="Images/<%= user_image %>" style="margin-left:25px;margin-bottom: 10px" width="30px" height="30px">
                        </div>
                        <div class="col-4 col-sm-9 bg-primary" style="border-radius: 5px;padding-top: 10px">
                           <%= comment.getComment_text() %>
                        </div>
                      </div>
                    </div>
                </div>
                        
                <%
                }
                %>
            </div>
            <hr>
            <%
            }
            %>
	</div>
            <%@include file="check2.jsp" %>
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
			integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
			integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
			crossorigin="anonymous"></script>
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
			integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
			crossorigin="anonymous"></script>
</body>
</html>