<%@page import="java.util.List"%>
<%@page import="model.Comment"%>
<%@page import="model.User"%>
<%@page import="model.Post"%>
<%!
Post newPost;
User newPostUser;
User user;
%>

<%
newPost = (Post) request.getAttribute("newPost");
newPostUser = newPost.getUser();
user = (User) session.getAttribute("user");

%>

<div id='postView<%=newPost.getId()%>' class="view-post">
    <div class="upper">
        <div class="d-flex">
            <div class="user">
                <div class="profile">
                    <img onerror="this.src='/Images/facebook.png'"
                         src="Images/<%=newPostUser.getProfilePicture()%>" alt="">
                </div>
            </div>

            <div class="info">
                <h6 class="name">
                    <%= newPostUser.getFirstName() + " " + newPostUser.getLastName()%>
                </h6>
                <span class="time"><%=newPost.getDate()%></span>
            </div>
        </div>

        <div class="dropdown dots">
            <button  class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <div class="dot"></div>
            </button>
                <div style="background-color:#1A4464;" class="dropdown-menu" aria-labelledby="dropdownMenu2">
            <button onclick="deletePost(<%=newPost.getId()%>)" class="dropdown-item">Delete</button>
            <button onclick="showEditBox(<%=newPost.getId()%>)" class="dropdown-item">Edit</button>
          </div>
        </div>
    </div>

    <div class="desc">
        <p><%=newPost.getContent()%></p>
    </div>

    <div class="actions-container">
        <div class="action">
            <span id='<%="like" + newPost.getId()%>' class="likeCount"><%=newPost.getLikes().size()%>
                likes</span>
            <button onclick="getLikes(<%=newPost.getId()%>,<%=user.getId()%>)"
                    style="background:none;border:none" class="likeButton">
                <div class="icon">
                    <img src="img/icons/thumbs-up.svg" alt="">
                </div>
            </button>
            <span>
                like
            </span>

        </div>

        <div id="commentIcon<%=newPost.getId()%>"  onclick="setInputFocus(<%=newPost.getId()%>)" class="action">
            <div class="icon">
                <img src="img/icons/comment.svg" alt="">
            </div>
            <span>
                comment
            </span>
        </div>
    </div>
    <input style="visibility:hidden" type="text" value="<%=newPost.getId()%>" name="postId" />
    <input style="visibility:hidden" type="text" value="<%=user.getId()%>" name="userId" />
    <div class="write-comment">
        <div class="user">
            <div class="profile">
                <img onerror="this.src='/Images/facebook.png'"
                     src="Images/<%= user.getProfilePicture()%>" alt="">
            </div>
        </div>

        <div class="input">

            <input id="comment<%=newPost.getId()%>" style="opacity:.5;color:white" type="text"
                   placeholder="Write a comment" name="comment">
            <div class="media">
                <div class="icon">
                    <button style="background:none;border:none;"
                            onclick="comment(<%=user.getId()%>, <%=newPost.getId()%>, 'comment<%=newPost.getId()%>', 'postView' +<%=newPost.getId()%>)"><img
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
        List<Comment> newPostComments = newPost.getComments();
        for (Comment comment : newPostComments) {
    %>
    <div class="write-comment commentList">
        <div class="user">
            <div class="profile">
                <img onerror="this.src='/Images/facebook.png'"
                     src="Images/<%=comment.getUser().getProfilePicture()%>" alt="">
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
