package controller;

import model.Comment;
import model.Post;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

@WebServlet("/comment")
public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String commentText = req.getParameter("comment");
        String postId = req.getParameter("postId");
        String userId = req.getParameter("userId");

        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        User user = (User) session.get(User.class, Integer.parseInt(userId));
        Post post = (Post) session.get(Post.class, Integer.parseInt(postId));

        Comment comment = new Comment();
        comment.setCommentText(commentText);
        comment.setUser(user);
        comment.setPost(post);

        session.save(comment);
        session.getTransaction().commit();
        session.close();

        resp.getWriter().print(comment.getCommentText());
    }
}
