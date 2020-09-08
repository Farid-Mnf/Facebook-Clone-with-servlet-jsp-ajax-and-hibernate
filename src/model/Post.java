package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Post {

    @Id
    @GeneratedValue
    private int id;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "post")
    private List<LikeReact> likes = new ArrayList<>();

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "post")
    private List<Comment> comments = new ArrayList<>();

    @OneToOne
    private User user;

    private String content;

    private Date date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public List<LikeReact> getLikes() {
        return likes;
    }

    public void setLikes(List<LikeReact> likes) {
        this.likes = likes;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

}
