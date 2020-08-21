package service;
import java.sql.*;
public class GetFile {
    public static String get(int userId,Connection con,String type) {
        try {
            PreparedStatement stat;
            if(type.equals("cover")){
                stat = con.prepareStatement("select photo_name from cover where user_id=? order by cover_id desc");
            }else{
                stat = con.prepareStatement("select photo_name from photo where user_id=? order by photo_id desc");
            }
            stat.setInt(1, userId);
            ResultSet result = stat.executeQuery();
            if(result.next()) {
                    String file = result.getString(1);
                    return file;
            }else {
                    System.out.println("select statement didn't find photo for that user");
                    return null;
            }
        } catch (SQLException e) {
                e.printStackTrace();
                return null;
        }
    }
}
