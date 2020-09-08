<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="service.*"%>
<%@page import="model.Comment"%>
<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@page import="java.sql.*"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Facebook</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/owl.theme.default.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <style>
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
            <div class="tab-icon active">
                <div class="icon">
                    <img src="img/icons/home.svg" alt="">
                </div>
            </div>

            <div class="tab-icon">
                <div class="icon has-notification">
                    <img src="img/icons/flag.svg" alt="">
                </div>
            </div>

            <div class="tab-icon">
                <div class="icon">
                    <img src="img/icons/tv.svg" alt="">
                </div>
            </div>

            <div class="tab-icon">
                <div class="icon">
                    <img src="img/icons/users.svg" alt="">
                </div>
            </div>


            <div class="tab-icon">
                <div class="icon has-notification">
                    <img src="img/icons/calendar.svg" alt="">
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
                <div class="icon">
                    <img src="img/icons/plus.svg" alt="">
                </div>

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
        
    <!--content-->
    <div class="wrapper">
        <!--posts-->
        <div class="posts" style="width:70%; margin:0 auto">
            <!--create post-->
            <div id="timeline" class="timeline">
                <!-- posting box -->
                <div class="view create-post" style="margin-top:0">
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
                                                    height: 200%;
                                                    width: 250%;
" src="/Images/postIcon.png" alt="post icon">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                dbSession.beginTransaction();
                List<Post> posts = dbSession.createQuery("from Post where not user_id="+user.getId()+" order by date desc").list();
                List<Comment> comments;
                User postUser;
                for(Post post : posts){
                    postUser = post.getUser();
                    comments = dbSession.createQuery("from Comment where post_id="+post.getId()).list();
                %>


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

                                <input id="comment<%=post.getId()%>" style="color:white" type="text"
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


                <!--people you may know-->
                <div class="view friends smaller-margin">
                    <div class="upper">
                        <h6>people you may know</h6>
                        <div class="dots">
                            <div class="dot"></div>
                        </div>
                    </div>

                    <div class="owl-carousel owl-theme people">
                        <div class="item">
                            <div class="person-img">
                                <div class="icon">
                                    &times;
                                </div>
                                <img src="img/avatar/1.jpg" alt="">
                            </div>

                            <div class="info">
                                <h4>
                                    rosie pie
                                </h4>
                                <span>4 mutual friend</span>
                                <button>
                                    add friend
                                </button>
                            </div>
                        </div>
                        <!---->

                        <div class="item">
                            <div class="person-img">
                                <div class="icon">
                                    &times;
                                </div>
                                <img src="img/avatar/4.jpg" alt="">
                            </div>

                            <div class="info">
                                <h4>
                                    sarah jones
                                </h4>
                                <span>4 mutual friend</span>
                                <button>
                                    add friend
                                </button>
                            </div>
                        </div>
                        <!---->

                        <div class="item">
                            <div class="person-img">
                                <div class="icon">
                                    &times;
                                </div>
                                <img src="img/avatar/3.jpg" alt="">
                            </div>

                            <div class="info">
                                <h4>
                                    chris doe
                                </h4>
                                <span>4 mutual friend</span>
                                <button>
                                    add friend
                                </button>
                            </div>
                        </div>
                        <!---->

                        <div class="item">
                            <div class="person-img">
                                <div class="icon">
                                    &times;
                                </div>
                                <img src="img/avatar/2.jpg" alt="">
                            </div>

                            <div class="info">
                                <h4>
                                    katie adam
                                </h4>
                                <span>4 mutual friend</span>
                                <button>
                                    add friend
                                </button>
                            </div>
                        </div>
                        <!---->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        
        
        function setInputFocus(postId) {
            document.getElementById('comment'+postId).focus();
        }
        
        function getLikes(postId, userId) {
            var post = document.getElementById('postView'+postId);
            var likeButton = post.children[2].querySelector('.likeButton .icon img');
            var prevIcon = likeButton.src;
            if(prevIcon=='http://localhost:8084/img/icons/thumbs-up.svg'){
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
                
                var posts = document.getElementsByClassName('dots');
                for(var i =0 ; i< posts.length-1;++i){ posts[i].style.display = 'none'; }
            }
            xhr.send(data);

        }

    </script>

    
    
    <script src="js/jquery.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/index.js"></script>

<%@include file="check2.jsp"%>
</body>

</html>