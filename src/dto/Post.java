package dto;
import service.*;
import java.util.*;
import java.sql.*;
public class Post {
	int user_id;
	int post_id;
	String content;
	String date;
        List<Comment> comments;
        int likes;
        
        
        public List<Comment> getComments(Connection con){
            comments = LoadComments.getPostComments(post_id, con);
            return comments;
        }
	public int getLikes(Connection con){
            return GetLikes.get(post_id, con);
        }
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}