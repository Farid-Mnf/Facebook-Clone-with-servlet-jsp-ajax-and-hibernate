package service;
import java.sql.*;
public class StoreFile {
    public static void store(int userId,String file,Connection con,String type) {
        try {
            PreparedStatement stat;
            if(type.equals("profile")){
                stat = con.prepareStatement("insert into photo(user_id, photo_name) "
                        + "values(?,?)");
            }else{
                stat = con.prepareStatement("insert into cover(user_id, photo_name) "
                        + "values(?,?)");
            }
            stat.setInt(1, userId);
            stat.setString(2, file);
            stat.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
