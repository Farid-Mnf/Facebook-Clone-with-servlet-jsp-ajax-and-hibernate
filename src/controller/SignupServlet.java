package controller;

import model.User;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        String enteredCode = request.getParameter("confirmationCode");
        User user = (User) request.getSession().getAttribute("user");
        String email = user.getEmail();
        
        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Code where email=:email and code=:code");
        query.setParameter("email", email);
        query.setParameter("code", enteredCode);
        
        
        if(query.uniqueResult()!=null){
            session.save(user);
            session.getTransaction().commit();
            session.close();
            request.getSession(true).setAttribute("user", user);
            response.sendRedirect("timeline.jsp");
        }else{
            // the code is wrong redirect again to input code confirmation
            response.sendRedirect("confirm.jsp?continue=true");
        }
        
    }
}
