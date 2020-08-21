package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.SignUp;
import service.StoreFile;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// get sign up form data
		String firstName,lastName,email,reEmail,password,month,day,year,gender;
		firstName = request.getParameter("firstName");
		lastName = request.getParameter("lastName");
		email = request.getParameter("email");
		reEmail = request.getParameter("reEmail");
		password = request.getParameter("password");
		month = request.getParameter("month");
		day = request.getParameter("day");
		year = request.getParameter("year");
		gender = request.getParameter("gender");
		if(gender!=null && firstName!=null && lastName!=null && email!=null && reEmail!=null && password!=null && month!=null && day!=null && year!=null) {
			if(email.equals(reEmail)) {
				dto.User user = new dto.User();
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setEmail(email);
				user.setPassword(password);
				user.setMonth(month);
				user.setDay(day);
				user.setYear(year);
				user.setGender(gender);
                                StoreFile.store(user.getId(), "facebook.png", (java.sql.Connection)getServletContext().getAttribute("con"), "profile");
                                StoreFile.store(user.getId(), "cover.jpg", (java.sql.Connection)getServletContext().getAttribute("con"), "cover");
				java.sql.Connection con = (java.sql.Connection)getServletContext().getAttribute("con");
				SignUp.signUp(user,con);
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}
		}
		response.sendRedirect("index.jsp");
		
	}

}
