package controller;

import dto.Post;
import dto.User;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

@WebServlet("/post")
public class PostServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String content = request.getParameter("post");
        
        User user = new User();
        user = (User) request.getSession().getAttribute("user");

        Post post = new Post();
        post.setContent(content);
        post.setDate(new Date());
        post.setLikes(0);
        post.setUser(user);
        
        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        session.save(post);
        session.getTransaction().commit();
        session.close();
        response.sendRedirect("profile.jsp");
    }
}
