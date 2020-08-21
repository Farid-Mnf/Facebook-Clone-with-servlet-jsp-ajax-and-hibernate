
package service;
import dto.*;
import java.util.*;
import java.sql.*;
public class LoadComments {
    public static List<Comment> comments;
    public static String getComment(int postId,int userId,Connection con){
        String sql = "select comment_text from comment where comment_post_id=? and comment_user_id=?";
        try{
            PreparedStatement stat = con.prepareStatement(sql);
            stat.setInt(1, postId);
            stat.setInt(2, userId);
            ResultSet result = stat.executeQuery();
            if(result.next()){
                return result.getString(1);
            }else{
                return null;
            }
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public static List<Comment> getPostComments(int post_id, Connection con){
        comments = new ArrayList<>();
        String sql = "select * from comment where comment_post_id=?";
        try{
            PreparedStatement stat = con.prepareStatement(sql);
            stat.setInt(1, post_id);
            ResultSet result = stat.executeQuery();
            Comment comment;
            while(result.next()){
                comment = new Comment();
                comment.setComment_id(result.getInt(1));
                comment.setComment_user_id(result.getInt(2));
                comment.setComment_post_id(result.getInt(3));
                comment.setComment_text(result.getString(4));
                comments.add(comment);
            }
            return comments;
        }catch(Exception e){
            return null;
        }
    }
}
