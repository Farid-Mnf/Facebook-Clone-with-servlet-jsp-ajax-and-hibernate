package controller;

import dto.LikeReact;
import dto.Post;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class LikeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int post_id = Integer.parseInt(request.getParameter("post_id"));

        SessionFactory sessionFactory = (SessionFactory) getServletContext()
                .getAttribute("sessionFactory");
        Session dbSession = sessionFactory.openSession();
        dbSession.beginTransaction();

        LikeReact likeReact = new LikeReact();

        User user = (User) dbSession.get(User.class, user_id);
        likeReact.setUser(user);

        Post post = (Post) dbSession.get(Post.class, post_id);
        likeReact.setPost(post);

        dbSession.save(likeReact);
        dbSession.getTransaction().commit();
        dbSession.close();
        Session newSession = sessionFactory.openSession();
        newSession.beginTransaction();
        Query query = newSession.createQuery("from LikeReact where post_id= :postId");
        query.setInteger("postId", post_id);
        int count = query.list().size();
        response.getWriter().write(count + "");
        newSession.getTransaction().commit();
        newSession.close();
    }
}
