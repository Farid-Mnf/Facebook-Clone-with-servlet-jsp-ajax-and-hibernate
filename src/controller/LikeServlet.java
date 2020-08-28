
package controller;

import dto.Post;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;


public class LikeServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
//        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int post_id = Integer.parseInt(request.getParameter("post_id"));
        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session dbSession = sessionFactory.openSession();
        dbSession.beginTransaction();
        
        Post post = (Post) dbSession.get(Post.class, post_id);
        post.setLikes(post.getLikes()+1);
        dbSession.update(post);
        System.out.println("response is: "+post.getLikes());
        response.getWriter().write(post.getLikes()+"");
        dbSession.getTransaction().commit();
        dbSession.close();
    }
}
