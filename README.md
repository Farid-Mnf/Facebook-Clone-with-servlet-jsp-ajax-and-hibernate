# Facebook Clone

A social media web application implementing core Facebook features, built with Java EE (Servlets, JSP), AJAX, Hibernate, and MySQL.

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Backend | Java EE (Servlets) |
| Frontend | JSP, HTML, CSS, JavaScript |
| Async Requests | AJAX |
| ORM | Hibernate |
| Database | MySQL |
| Build | NetBeans / Eclipse |

## Features

- **User registration** -- sign up with email confirmation
- **Authentication** -- login/logout with session management
- **Posts** -- create, edit, and delete posts
- **Likes & comments** -- react to and comment on posts
- **Profile pages** -- dedicated profile page showing user's posts
- **Photo uploads** -- update profile and cover photos
- **Home timeline** -- scroll through posts from all users
- **Password recovery** -- forgot password flow with email verification

## Project Structure

```
.
├── src/
│   ├── controller/        # Servlets (Auth, Post, Like, Comment, Upload, etc.)
│   ├── model/             # Hibernate entities (User, Post, Comment, LikeReact)
│   ├── service/           # Business logic (DB connection, email services)
│   ├── listeners/         # Context initialization
│   └── hibernate.cfg.xml  # Hibernate configuration
├── WebContent/
│   ├── css/               # Stylesheets
│   ├── img/               # Static images and icons
│   ├── Images/            # UI assets (like button, icons)
│   └── *.jsp              # JSP pages (login, home, profile, etc.)
```

## How to Run

**Prerequisites:** Java 8+, MySQL, Apache Tomcat, NetBeans or Eclipse

1. **Set up the database:**
   - Create a MySQL database
   - Update connection details in `src/hibernate.cfg.xml`

2. **Configure the project:**
   - Import as a Dynamic Web Project in Eclipse or open in NetBeans
   - Ensure Tomcat is configured as the application server

3. **Deploy and run:**
   - Build and deploy to Tomcat
   - Access at `http://localhost:8080/Facebook-Clone`
