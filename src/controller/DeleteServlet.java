
package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Comment;
import model.LikeReact;
import model.Post;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class DeleteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        
        Query queryLikes = session.createQuery("delete from LikeReact where post_id="+postId);
        queryLikes.executeUpdate();
        
        Query queryComments = session.createQuery("delete from Comment where post_id="+postId);        
        queryComments.executeUpdate();
        
        Post post = new Post();
        post.setId(postId);
        session.delete(post);
        
        session.getTransaction().commit();
        session.close();
    }
}
