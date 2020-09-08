
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Post;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class EditPostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String newPostText = request.getParameter("newPost");
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        
        Post newPost = (Post) session.get(Post.class, postId);
        newPost.setContent(newPostText);
        session.update(newPost);
        
        session.getTransaction().commit();
        session.close();
    }
}
