package controller;

import dto.Test;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class AuthServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Test test = new Test();
        test.setName("farid");
        session.save(test);
        session.getTransaction().commit();
        session.close();
//        //GET parameters of login form
//
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//        String keepSigned = request.getParameter("keepSigned");
//
//        java.sql.Connection con = (java.sql.Connection)getServletContext().getAttribute("con");
//
//        //find user in the system
//        boolean isUser = service.ValidateLogin.validate(email, password, con);
//        if(isUser) {
//            dto.User user = service.UserData.getUser(email, password, con);
//            int id = user.getId();
//            String profilePicture = service.GetFile.get(id,con,"profile");
//            String coverPicture = service.GetFile.get(id,con,"cover");
//            if(profilePicture==null){
//                profilePicture = "facebook.png";
//            } 
//            if(coverPicture==null){
//                coverPicture = "cover.jpg";
//            }
//            user.setProfilePicture(profilePicture);
//            user.setCoverPicture(coverPicture);
//            HttpSession session = request.getSession(true);
//            session.setAttribute("user", user);
//            session.setMaxInactiveInterval(24*60*60);
//            // set attribute in session to keep the user signed in
//            if(keepSigned!=null) {
//                    request.getSession().setAttribute("keepSigned", "true");
//            }
//            response.sendRedirect("timeline.jsp");
//        }else {
//            response.sendRedirect("index.jsp");
//        }
    }
}
