
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class LikeServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int post_id = Integer.parseInt(request.getParameter("post_id"));
        service.StoreLike.store(user_id, post_id, (Connection)getServletContext().getAttribute("con"));
        int count = service.GetLikes.get(post_id, (Connection)getServletContext().getAttribute("con"));
        System.out.println("Count is: "+count);
        response.getWriter().print(count);
    }
}
