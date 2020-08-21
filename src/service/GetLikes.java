
package service;
import java.sql.*;
public class GetLikes {
    public static int get(int post_id,Connection con){
        String sql = "select count(*) from likes where post_id=?";
        try{
            PreparedStatement stat = con.prepareStatement(sql);
            stat.setInt(1, post_id);
            ResultSet result = stat.executeQuery();
            if(result.next()){
                return result.getInt(1);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return 0;
    }
}
