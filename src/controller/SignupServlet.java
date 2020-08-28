package controller;

import dto.User;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;


@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        String firstName;
        String lastName;
        String email;
        String reEmail;
        String password;
        String month;
        String day;
        String year;
        String gender;
        
        firstName = request.getParameter("firstName");
        lastName = request.getParameter("lastName");
        email = request.getParameter("email");
        reEmail = request.getParameter("reEmail");
        password = request.getParameter("password");
        month = request.getParameter("month");
        day = request.getParameter("day");
        year = request.getParameter("year");
        gender = request.getParameter("gender");
        
        if (gender != null && firstName != null && lastName != null && email != null && reEmail != null && password != null && month != null && day != null && year != null) {
            if (email.equals(reEmail)) {
                User user = new User();
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setPassword(password);
                user.setMonth(month);
                user.setDay(day);
                user.setYear(year);
                user.setGender(gender);
                user.setProfilePicture("facebook.png");
                user.setCoverPicture("cover.jpg");
                SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
                System.out.println("SessionFactory:"+sessionFactory);
                Session session = sessionFactory.openSession();
                session.beginTransaction();
                session.save(user);
                session.getTransaction().commit();
                session.close();
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }
        response.sendRedirect("index.jsp");
    }
}
