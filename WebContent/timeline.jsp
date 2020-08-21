<%@page import="service.*"%>
<%@page import="dto.Comment"%>
<%@page import="java.util.List"%>
<%@page import="dto.Post"%>
<%@page import="java.sql.*"%>
<%@page import="dto.User"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/owl.theme.default.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <style>
        img:hover{
            cursor: pointer
        }
        .likeCount{
            position: relative;
            right: 150px
        }
        .likeButton{
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
    Connection con;
%>
    <%@ include file = "check.jsp" %>            
        
    <!--navbar-->
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
                    <a href="profile.jsp"><img src="Images/<%= user.getProfilePicture() %>" alt=""></a>
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
            <div class="timeline">

                <%
                List<Post> posts = service.TimelinePosts.getPosts(con,user.getId());
                List<Comment> comments;
                User postUser;
                for(Post post : posts){
                    postUser = UserData.getUserById(post.getUser_id(), con);
                    comments = post.getComments(con);
                %>
                    <!--post container-->
                <div class="view view-post-container smaller-margin">
                    <div id='postView<%=post.getPost_id()%>' class="view-post">
                        <div class="upper">
                            <div class="d-flex">
                                <div class="user">
                                    <div class="profile">
                                        <img src="Images/<%= service.GetFile.get(postUser.getId(), con, "profile") %>" alt="">
                                    </div>
                                </div>

                                <div class="info">
                                    <h6 class="name">
                                        <%= postUser.getFirstName()+" "+ postUser.getLastName() %>
                                    </h6>
                                    <span class="time"><%=post.getDate()%></span>
                                </div>
                            </div>

                            <div class="dots">
                                <div class="dot"></div>
                            </div>
                        </div>

                        <div class="desc">
                            <p><%=post.getContent()%></p>
                        </div>

                        <div class="actions-container">
                            <div class="action">
                                <span id='<%="like"+post.getPost_id()%>' class="likeCount"><%= post.getLikes(con)%> likes</span>
                                <button onclick="getLikes(<%=post.getPost_id()%>,<%=user.getId()%>)" style="background:none;border:none" class="likeButton">
                                    <div class="icon">
                                        <img src="img/icons/thumbs-up.svg" alt="">
                                    </div>
                                </button>
                                <span>
                                    like
                                </span>
                                
                            </div>

                            <div class="action">
                                <div class="icon">
                                    <img src="img/icons/comment.svg" alt="">
                                </div>
                                <span>
                                    comment
                                </span>
                            </div>
                        </div>
                        <input style="visibility:hidden" type="text" value="<%=post.getPost_id()%>" name="postId"/>
                                <input style="visibility:hidden" type="text" value="<%=user.getId()%>" name="userId"/>
                            <div class="write-comment">
                            <div class="user">
                                <div class="profile">
                                    <img src="Images/<%= user.getProfilePicture() %>" alt="">
                                </div>
                            </div>
                               
                            <div class="input">
                                
                                <input id="comment<%=post.getPost_id()%>" style="color:white" type="text" placeholder="Write a comment" name="comment">
                                <div class="media">
                                    <div class="icon">
                                        <button style="background:none;border:none;" onclick="comment(<%=user.getId()%>, <%=post.getPost_id()%>, 'comment<%=post.getPost_id()%>','postView'+<%=post.getPost_id()%>)"><img style="background: url(Images/send.png);
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
                                    <img src="Images/<%= service.GetFile.get(comment.getComment_user_id(), con, "profile") %>" alt="">
                                </div>
                            </div>
                            <div style="justify-content: left;color:white" class="input" role="alert">
                                <%= comment.getComment_text() %>
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

        <!--shortcuts 2 -events and chat- -->
        <div class="shortcuts shortcuts-2">
        </div>
    </div>
                




    <%@include file="check2.jsp"%>
    <script>
        function getLikes(postId,userId){
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '/like?post_id='+postId+'&user_id='+userId, true);
            xhr.onload = function(){
                if(this.status==200) {
                    var count = this.responseText;
                    document.getElementById('like'+postId).textContent = count+' likes';
                }
            }
            xhr.send();
            
        }
        function comment(userId,postId,inputId,postView){
            var input = document.getElementById(inputId);
            var comment = input.value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET",'/comment?comment='+comment+'&postId='+postId+'&userId='+userId,true);
            xhr.onload = function(){
                if(this.status==200){
                    var newComment = this.responseText;
                    var commentScheme = "<div class='write-comment commentList'><div class='user'><div class='profile'><img src='Images/<%=user.getProfilePicture()%>'></div></div><div style='justify-content: left;color:white' class='input' role='alert'>"+newComment+"</div></div>";
                    var postViewScheme = document.getElementById(postView);
                    postViewScheme.innerHTML+= commentScheme;
                    
                    console.log(newComment);
                }
            }
            xhr.send();
            input.value = "";
        }
        
        
        
    </script>
    <script src="js/jquery.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/index.js"></script>
</body>

</html>