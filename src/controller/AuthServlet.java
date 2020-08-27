package controller;

import dto.*;
import java.io.IOException;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class AuthServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //GET parameters of login form

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String keepSigned = request.getParameter("keepSigned");
        
        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        //find user in the system
        User user = service.UserData.getUser(email, password, session);
        if(user!=null) {
            System.out.println("Email: "+user.getEmail());
            System.out.println("Password: "+user.getPassword());
            System.out.println("Name: "+user.getFirstName()+" "+user.getLastName());
            System.out.println(": "+user.getCoverPicture());
            System.out.println(": "+user.getProfilePicture());
            System.out.println(": "+user.getGender());
            
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
            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("user", user);
            httpSession.setMaxInactiveInterval(24*60*60);
            // set attribute in session to keep the user signed in
            if(keepSigned!=null) {
                    request.getSession().setAttribute("keepSigned", "true");
            }
            response.sendRedirect("index.jsp");
        }else {
            response.sendRedirect("index.jsp");
        }
    }
}
