package controller;

import model.Post;
import model.User;
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
        System.out.println("Content of post: " + content);
        User user = (User) request.getSession().getAttribute("user");

        Post post = new Post();
        post.setContent(content);
        post.setDate(new Date());
        post.setUser(user);

        SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        session.save(post);
        session.getTransaction().commit();
        session.close();
        request.setAttribute("newPost", post);
        request.getRequestDispatcher("post.jsp").forward(request, response);
    }
}
