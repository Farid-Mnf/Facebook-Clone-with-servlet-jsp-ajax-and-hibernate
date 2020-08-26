package controller;
import java.io.*;
import java.util.*;
 

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/upload")
public class PhotoUploadServlet extends HttpServlet {
//   private boolean isMultipart;
//   private String filePath;
//   private int maxFileSize = 10000 * 1024;
//   private int maxMemSize = 4 * 1024;
//   private File file;
//
//   public void init( ){
//      filePath = getServletContext().getInitParameter("file-upload");
//   }
//   
//   public void doPost(HttpServletRequest request, HttpServletResponse response)
//      throws ServletException, java.io.IOException {
//   
//
//       
//      // Check that we have a file upload request
//      isMultipart = ServletFileUpload.isMultipartContent(request);
//      response.setContentType("text/html");
//      java.io.PrintWriter out = response.getWriter( );
//   
//   
//      if( !isMultipart ) {
//         out.println("<html>");
//         out.println("<head>");
//         out.println("<title>Servlet upload</title>");  
//         out.println("</head>");
//         out.println("<body>");
//         out.println("<p>No file uploaded</p>"); 
//         out.println("</body>");
//         out.println("</html>");
//         return;
//      }
//  
//      DiskFileItemFactory factory = new DiskFileItemFactory();
//   
//      // maximum size that will be stored in memory
//      factory.setSizeThreshold(maxMemSize);
//   
//      // Location to save data that is larger than maxMemSize.
//      factory.setRepository(new File("/var/tmp"));
//
//      // Create a new file upload handler
//      ServletFileUpload upload = new ServletFileUpload(factory);
//   
//      // maximum file size to be uploaded.
//      upload.setSizeMax( maxFileSize );
//
//      try { 
//         // Parse the request to get file items.
//         List fileItems = upload.parseRequest(request);
//	
//         // Process the uploaded file items
//         Iterator i = fileItems.iterator();
//
//         out.println("<html>");
//         out.println("<head>");
//         out.println("<title>Servlet upload</title>");  
//         out.println("</head>");
//         out.println("<body>");
//   
//         while ( i.hasNext () ) {
//            FileItem fi = (FileItem)i.next();
//            if ( !fi.isFormField () ) {
//
//               String fileName = fi.getName();
//
//               
//               // Write the file
//               if( fileName.lastIndexOf("/") >= 0 ) {
//                  file = new File( filePath + fileName.substring( fileName.lastIndexOf("/")));
//                   System.out.println("File name is: "+file.getName());
//               } else {
//                  file = new File( filePath + fileName.substring(fileName.lastIndexOf("/")+1));
//                  System.out.println("File name is: "+file.getName());
//               }
//               fi.write( file );
//               out.println("Uploaded Filename: " + fileName + "<br>");
//               java.sql.Connection con = (java.sql.Connection)getServletContext().getAttribute("con");
//               String type = "profile";
//               service.StoreFile.store(((dto.User)request.getSession().getAttribute("user")).getId(),fileName,con,type);
//                System.out.println("file stored successfully");
//               response.sendRedirect("index.jsp");
//            }
//         }
//         out.println("</body>");
//         out.println("</html>");
//         } catch(Exception ex) {
//            System.out.println(ex);
//         }
//      }
//      
//      public void doGet(HttpServletRequest request, HttpServletResponse response)
//         throws ServletException, java.io.IOException {
//
//         throw new ServletException("GET method used with " +
//            getClass( ).getName( )+": POST method required.");
//      }
   }

