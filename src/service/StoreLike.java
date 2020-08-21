
package service;

import java.sql.*;

public class StoreLike {
    public static void store(int user_id, int post_id, Connection con){
        try{
            String sql = "insert into likes(user_id, post_id) values(?,?)";
            PreparedStatement stat = con.prepareStatement(sql);
            stat.setInt(1, user_id);
            stat.setInt(2, post_id);
            stat.execute();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
