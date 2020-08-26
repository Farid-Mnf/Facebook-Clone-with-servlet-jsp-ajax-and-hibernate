package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/post")
public class PostServlet extends HttpServlet {


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String content = request.getParameter("post");
		int user_id = ((dto.User)request.getSession().getAttribute("user")).getId();
		dto.Post post = new dto.Post();
		post.setUser_id(user_id);
		post.setContent(content);
		java.sql.Connection con = (java.sql.Connection)getServletContext().getAttribute("con");
		service.StorePost.store(post, con);
		response.sendRedirect("profile.jsp");
	}
}
