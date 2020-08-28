package controller;

import dto.Comment;
import dto.Post;
import dto.User;
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String comment = req.getParameter("comment");
        String postId = req.getParameter("postId");
        String userId = req.getParameter("userId");

        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Post post = (Post) session.get(Post.class, Integer.parseInt(postId));
        User user= (User) session.get(User.class, Integer.parseInt(userId));
        
        Comment commentObj = new Comment();
        commentObj.setCommentText(comment);
        commentObj.setPost(post);
        commentObj.setUser(user);
        session.save(commentObj);
        session.getTransaction().commit();
        session.close();
        
        resp.getWriter().print(comment);
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String comment = req.getParameter("comment");
        String postId = req.getParameter("postId");
        String userId = req.getParameter("userId");

        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Post post = (Post) session.get(Post.class, Integer.parseInt(postId));
        User user= (User) session.get(User.class, Integer.parseInt(userId));
        
        Comment commentObj = new Comment();
        commentObj.setCommentText(comment);
        commentObj.setPost(post);
        commentObj.setUser(user);
        session.save(commentObj);
        session.getTransaction().commit();
        session.close();
        
        resp.getWriter().print(comment);
    }
}