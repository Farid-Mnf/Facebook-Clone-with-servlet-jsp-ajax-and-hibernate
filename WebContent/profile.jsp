<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="service.UserData"%>
<%@page import="java.util.List"%>
<%@page import="model.*" language="java"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/owl.theme.default.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <title>Profile</title>
    <style type="text/css">
        .dropdown-item {
            background-color: #031D2E;
            color:white;
        }
        .dropdown-item:hover {
            background-color:#072A41;
            color:white;
        }
        .dot{
            margin-left: 4px;
        }
        .dropdown-toggle{
            border-radius: 100%;
            width: 40px;
            height: 40px;
            background-color: #031D2E;
        }
        .dropdown-toggle::after {
            content: none;
        }
        .comment-button-section{
            cursor: pointer;
        }
        img:hover {
            cursor: pointer
        }

        .likeCount {
            position: relative;
            right: 150px
        }

        .likeButton {
            position: absolute;
        }
        ::placeholder{
            color:white
        }
        .postIcon {
            background-image: url(Images/postIcon.png);
            width:64px; height:64px;
            background-size: contain;
        }
        body{
            background-color: #031d2e;
        }
        .loaderCover {
            visibility: hidden;
            position: relative;
            top: -200px;
            left: 40%;
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 120px;
            height: 120px;
            -webkit-animation: spin 2s linear infinite;
            /* Safari */
            animation: spin 2s linear infinite;
        }

        /* Safari */
        @-webkit-keyframes spin {
            0% {
                -webkit-transform: rotate(0deg);
            }

            100% {
                -webkit-transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        .loaderProfile {
            visibility: hidden;
            position: relative;
            top: -140px;
            left: 3%;
            z-index: 2;
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 120px;
            height: 120px;
            -webkit-animation: spin 2s linear infinite;
            /* Safari */
            animation: spin 2s linear infinite;
        }

        /* Safari */
        @-webkit-keyframes spin {
            0% {
                -webkit-transform: rotate(0deg);
            }

            100% {
                -webkit-transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        #form1,
        #form2 {

            width: 143px;
        }

        #form1 {
            float: left;
        }

        #form2 {
            float: right;
        }

        #sampleFile {
            visibility: hidden
        }

        #sampleFile2 {
            visibility: hidden
        }

        .prof-img {
            outline: 1px solid #79bc64;
        }

        .coverarea {
            position: relative;
            top: 0;
            left: 0;
        }

        .userFullName {
            position: absolute;
            top: -13px;
            left: -10px;
            font-size: 30px
        }

        .upload-form1 {
            position: absolute;
            top: 400px;
            left: 200px;
        }

        .upload-form2 {
            position: absolute;
            top: 400px;
            left: 700px;
        }
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

    <%            sessionFactory = (SessionFactory) application.getAttribute("sessionFactory");
            System.out.println("Factory: " + sessionFactory);
            dbSession = sessionFactory.openSession();
            System.out.println("Session: " + dbSession);
            dbSession.beginTransaction();
        %>
        <nav style="padding:0" class="navbar-expand-lg navbar-light bg-light fixed-top">
        <div style="background-color:#072A41; padding: 10px 20px; margin: 0px" class="collapse navbar-collapse"
            id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active"><a class="nav-link" href="timeline.jsp"> <img width=30 height=30
                            alt="facebook logo" src="Images/facebook.png">
                    </a></li>
                <li style="font-weight: bolder" class="nav-item active"><a style="color: white" class="nav-link"
                        href="timeline.jsp">Home
                        <span class="sr-only">(current)</span>
                    </a></li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button style="color: white" class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>
    <!-- COVER -->
    <div class="container">
        <div class="coverarea">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-dark text-info" data-toggle="modal" data-target="#exampleModalCenter"
                style="position: relative;top:260px;left:20px">
                Update Image
            </button>
            <img onerror="this.src='/Images/facebook.png'" alt="cover" src="Images/<%= user.getCoverPicture()%>"
                width="100%" height="300px">

            <div id="coverLoad" class="loaderCover"></div>

            <div class="profile-picture">
                <div style="position: relative">
                    <div id="profileLoad" class="loaderProfile"></div>
                    <img onerror="this.src='/Images/facebook.png'" id="profileView"
                        style="position: absolute;left:10px;top:-154px;border-radius: 100%;border:4px dashed #0089ff;z-index: 1"
                        alt="profile picture" src="Images/<%= user.getProfilePicture()%>" width="150px" height="150px">
                    <h3 class="userFullName badge badge-secondary">
                        <%
                                out.println(user.getFirstName() + " " + user.getLastName());
                            %>
                    </h3>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog"
                    aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content" style="width:320px">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">Change Avatar<span
                                        style="font-weight:bold;font-size: 35px"> / </span>Cover</h5>
                            </div>
                            <div class="modal-body">
                                <div>
                                    <form id="form1">
                                        <label for="sampleFile" class="btn btn-primary">Change Avatar</label>
                                        <input onchange="performAjaxSubmit(1)" id="sampleFile" name="sampleFile"
                                            type="file" /> <br />
                                    </form>
                                    <form id="form2">
                                        <label for="sampleFile2" class="btn btn-primary">Change Cover</label>
                                        <input onchange="performAjaxSubmit(2)" id="sampleFile2" name="sampleFile2"
                                            type="file" /> <br />
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="wrapper">
        <!--posts-->
        <div class="posts" style="width:70%; margin:0 auto">
            <div id="timeline" class="timeline">
                <!-- posting box -->
                <div class="view create-post" style="margin-top:0;margin-bottom: 50px">
                    <div class="input">
                        <div class="user">
                            <div class="profile">
                                <img onerror="this.src='/Images/facebook.png'"
                                    src="Images/<%=user.getProfilePicture()%>" alt="">

                            </div>
                        </div>
                        <input type="text" placeholder="What on your mind, <%=user.getFirstName()%>?" name=""
                            id="postText">
                    </div>
                    <div class="media">
                        <div class="category">
                            <div style="margin:0 auto" class="option">
                                <div class="icon">
                                    <img id="postImage" style="
                                                    position: relative;
                                                    top: -10px;
                                                    left:350px;
                                                    height: 200%;
                                                    width: 250%;
" src="/Images/postIcon.png" alt="post icon">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                List<Post> posts = dbSession.createQuery("from Post where user_id="+user.getId()+" order by date desc").list();
                List<Comment> comments;
                User postUser;
                for(Post post : posts){
                    postUser = post.getUser();
                    comments = dbSession.createQuery("from Comment where post_id="+post.getId()).list();
                %>


                <!--post container-->
                <div class="view view-post-container smaller-margin">
                    <div id='postView<%=post.getId()%>' class="view-post">
                        <div class="upper">
                            <div class="d-flex">
                                <div class="user">
                                    <div class="profile">
                                        <img onerror="this.src='/Images/facebook.png'"
                                            src="Images/<%=postUser.getProfilePicture()%>" alt="">
                                    </div>
                                </div>

                                <div class="info">
                                    <h6 class="name">
                                        <%= postUser.getFirstName()+" "+ postUser.getLastName() %>
                                    </h6>
                                    <span class="time"><%=post.getDate()%></span>
                                </div>
                            </div>
                                
                            <div class="dropdown dots">
                                <button  class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  <div class="dot"></div>
                                </button>
                                    <div style="background-color:#1A4464;" class="dropdown-menu" aria-labelledby="dropdownMenu2">
                                <button onclick="deletePost(<%=post.getId()%>)" class="dropdown-item">Delete</button>
                                <button onclick="showEditBox(<%=post.getId()%>)" class="dropdown-item">Edit</button>
                              </div>
                            </div>

                        </div>

                        <div class="desc">
                            <p><%=post.getContent()%></p>
                        </div>

                        <div class="actions-container">
                            <div class="action">
                                <span id='<%="like"+post.getId()%>' class="likeCount"><%=post.getLikes().size()%>
                                    likes</span>
                                <button onclick="getLikes(<%=post.getId()%>,<%=user.getId()%>)"
                                    style="background:none;border:none" class="likeButton">
                                    <div class="icon">
<% 
    Query checkLiked = dbSession.createQuery("from LikeReact where user_id= :user and post_id= :post");
    checkLiked.setParameter("user", user.getId());
    checkLiked.setParameter("post", post.getId());
    if(checkLiked.uniqueResult()!=null){
        %>
        <img src="Images/liked.png" alt="">
        <%
    }else{
        %>
        <img src="img/icons/thumbs-up.svg" alt="">
        <%
    }
%>
                                    </div>
                                </button>
                                <span>
                                    like
                                </span>

                            </div>

                            <div id="commentIcon<%=post.getId()%>"  onclick="setInputFocus(<%=post.getId()%>)" class="action comment-button-section">
                                <div class="icon">
                                    <img src="img/icons/comment.svg" alt="">
                                </div>
                                <span>
                                    comment
                                </span>
                            </div>
                        </div>
                        <input style="visibility:hidden" type="text" value="<%=post.getId()%>" name="postId" />
                        <input style="visibility:hidden" type="text" value="<%=user.getId()%>" name="userId" />
                        <div class="write-comment">
                            <div class="user">
                                <div class="profile">
                                    <img onerror="this.src='/Images/facebook.png'"
                                        src="Images/<%= user.getProfilePicture() %>" alt="">
                                </div>
                            </div>

                            <div class="input">

                                <input id="comment<%=post.getId()%>" style="opacity:.5;color:white" type="text"
                                    placeholder="Write a comment" name="comment">
                                <div class="media">
                                    <div class="icon">
                                        <button style="background:none;border:none;"
                                            onclick="comment(<%=user.getId()%>, <%=post.getId()%>, 'comment<%=post.getId()%>','postView'+<%=post.getId()%>)"><img
                                                style="background: url(Images/send.png);
                                            background-size: cover;
                                            padding-left: 20px;
                                            cursor: pointer;
                                            width: 20px; height: 20px;
                                            border: none"></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                    for(Comment comment : comments){
                    %>
                        <div class="write-comment commentList">
                            <div class="user">
                                <div class="profile">
                                    <img onerror="this.src='/Images/facebook.png'"
                                        src="Images/<%=comment.getUser().getProfilePicture() %>" alt="">
                                </div>
                            </div>
                            <div style="justify-content: left;color:white" class="input" role="alert">
                                <%= comment.getCommentText()%>
                            </div>
                        </div>
                        <%
                    }
                    %>


                    </div>
                </div>
                <%
                }
                %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
    </script>
    <script>
        
        function setInputFocus(postId) {
            document.getElementById('comment'+postId).focus();
        }
        
        function performAjaxSubmit(e) {
            var formType = e;
            if (formType == 1) {
                var sampleFile = document.getElementById("sampleFile").files[0];
                var loader = document.getElementById('profileLoad');
                loader.style.visibility = 'visible';
                var formdata = new FormData();
                formdata.append("sampleFile", sampleFile);
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "/upload", true);
                xhr.send(formdata);
                xhr.onload = function (e) {
                    var profileView = document.getElementById('profileView');
                    if (this.status == 200) {
                        var imageName = this.responseText;
                        setTimeout(function () {
                            loader.style.visibility = 'hidden';
                            profileView.src = imageName;
                        }, 3000);
                    }
                };
            } else {
                var sampleFile = document.getElementById("sampleFile2").files[0];
                var loader = document.getElementById('coverLoad');
                loader.style.visibility = 'visible';
                var formdata = new FormData();
                formdata.append("sampleFile2", sampleFile);
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "/uploadCover", true);
                xhr.send(formdata);
                xhr.onload = function (e) {
                    var coverView = document.querySelector('.coverarea img');
                    if (this.status == 200) {
                        var imageName = this.responseText;
                        setTimeout(function () {
                            loader.style.visibility = 'hidden';
                            coverView.src = imageName;
                        }, 3000);
                    }
                };
            }
        }
        function getLikes(postId, userId) {
            var post = document.getElementById('postView'+postId);
            var likeButton = post.children[2].querySelector('.likeButton .icon img');
            var prevIcon = likeButton.src;
            console.log(prevIcon);
            if(prevIcon=='http://localhost:8084/img/icons/thumbs-up.svg'){
                console.log('equal');
                likeButton.src = 'Images/liked.png';
            }else{
                likeButton.src = 'img/icons/thumbs-up.svg';
            }
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '/like?post_id=' + postId + '&user_id=' + userId, true);
            xhr.onload = function () {
                if (this.status == 200) {
                    var count = this.responseText;
                    console.log("count is: ", count);
                    document.getElementById('like' + postId).textContent = count + ' likes';
                }
            }
            xhr.send();
        }
        function comment(userId, postId, inputId, postView) {
            var input = document.getElementById(inputId);
            var comment = input.value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", '/comment?comment=' + comment + '&postId=' + postId + '&userId=' + userId, true);
            xhr.onload = function () {
                if (this.status == 200) {
                    var newComment = this.responseText;
                    var commentScheme = "<div class='write-comment commentList'><div class='user'><div class='profile'><img src='Images/<%=user.getProfilePicture()%>'></div></div><div style='justify-content: left;color:white' class='input' role='alert'>" + newComment + "</div></div>";
                    var postViewScheme = document.getElementById(postView);
                    postViewScheme.innerHTML += commentScheme;

                    console.log(newComment);
                }
            }
            xhr.send();
            input.value = "";
        }

        var postImage = document.getElementById("postImage");

        postImage.onmouseenter = function () {
            this.src = "/Images/postIcon-dark.png";
        }

        postImage.onmouseout = function () {
            this.src = "/Images/postIcon.png";
        }

        postImage.onmousedown = function () {
            this.src = "/Images/postIcon.png";
        }

        postImage.onmouseup = function () {
            this.src = "/Images/postIcon-dark.png";
            var xhr = new XMLHttpRequest();
            var post = document.getElementById('postText');
            var postContent = post.value; post.value = "";
            var data = 'post=' + postContent;
            xhr.open('POST', 'post', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
            xhr.onload = function(){
                var timeline = document.getElementById('timeline');
                var newPostNode = document.createElement('div');
                newPostNode.classList = 'view view-post-container smaller-margin';
                newPostNode.innerHTML = this.responseText;
                timeline.insertBefore(newPostNode, timeline.children[0].nextSibling);
            }
            xhr.send(data);

        }
        function deletePost(postId) {
            // get the post DIV to delete
            var parentPost = document.getElementById('postView'+postId).parentElement;
            // delete post in html using javascript
            parentPost.style.display = 'none';
            
            // delete post in database asyncronously with ajax
            var xhr = new XMLHttpRequest();
            xhr.open('post', '/delete', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
            var data = 'postId='+postId;
            xhr.send(data);
        }
        function showEditBox(postId) {
            var postText = document.querySelector('#postView' + postId + ' .desc p');
            var newPostText = window.prompt("Edit Post",postText.innerText);
            if(newPostText!=null){   
                postText.innerText = newPostText;
                var xhr = new XMLHttpRequest();
                xhr.open('post', '/edit', true);
                xhr.setRequestHeader('content-type', 'application/x-www-form-urlencoded; charset=UTF-8');
                var data = 'newPost=' + newPostText + '&postId='+postId;
                xhr.send(data);
            }
        }
    </script>
    
    
    <script src="js/jquery.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/index.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
        crossorigin="anonymous"></script>
<%@include file="check2.jsp" %>
</body>

</html>