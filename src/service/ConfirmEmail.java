package service;

import java.util.Properties;
import java.util.UUID;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import model.Code;
import org.hibernate.SessionFactory;

public class ConfirmEmail {
    private String to;
    private String from;
    private String password;
    private String host;
    private String code;
    private HttpServletRequest request;
    
    
    public ConfirmEmail(String to, HttpServletRequest request) {
        this.to = to;
        this.code = UUID.randomUUID().toString();
        this.from = "facebookclone34@gmail.com";
        this.password = "facebookclone.app";  // change it to your own password
        this.host = "smtp.gmail.com";
        this.request = request;
    }
    
    public void storeCode() {
        SessionFactory sessionFactory = (SessionFactory) request.getServletContext().getAttribute("sessionFactory");
        org.hibernate.Session session = sessionFactory.openSession();
        session.beginTransaction();
        
        Code codeObject = new Code();
        codeObject.setEmail(to);
        codeObject.setCode(code);
        
        session.save(codeObject);
        
        session.getTransaction().commit();
        session.close();
    }
    
    public void sendCode(){
        Properties properties = System.getProperties();

        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");
        
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        session.setDebug(true);

        try {
            
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(from));

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            message.setSubject("FacebookClone Confirmation Code");
            
            message.setText("Your FacebookClone Confirmation Code is: " + code);
            
            Transport.send(message);

            storeCode();
            
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}