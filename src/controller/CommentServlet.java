package controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/comment")
public class CommentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String comment = req.getParameter("comment");
        String postId = req.getParameter("postId");
        String userId = req.getParameter("userId");

        Connection con = (Connection) getServletContext().getAttribute("con");
        service.StoreComment.store(Integer.parseInt(userId), Integer.parseInt(postId), comment, con);
        resp.getWriter().print(comment);
    }
}
