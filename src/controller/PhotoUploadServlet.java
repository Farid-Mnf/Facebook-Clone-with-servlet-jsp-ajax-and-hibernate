package controller;
import dto.User;
import java.io.*;
import java.util.*;
 

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

@WebServlet("/upload")
public class PhotoUploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = "facebook.png";
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);            
            FileItem fileItem = items.get(0);
            fileName = fileItem.getName();
            System.out.println("File Item name: "+fileItem.getName());
            File file = new File(getServletContext().getInitParameter("file-upload").toString()+"/"+fileItem.getName());
            System.out.println("File path: "+file.getAbsolutePath());
            fileItem.write(file);
            SessionFactory sessionFactory = (SessionFactory) getServletContext().getAttribute("sessionFactory");
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            User user = (User) request.getSession().getAttribute("user");
            user = (User) session.get(User.class, user.getId());
            user.setProfilePicture(fileName);
            session.update(user);
            request.getSession().setAttribute("user", user);
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.getWriter().print("/Images/"+fileName);
    }
}