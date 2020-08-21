package dto;

public class Comment {
	private int comment_id, comment_post_id, comment_user_id;
	private String comment_text;

        public int getComment_user_id() {
            return comment_user_id;
        }
        public void setComment_user_id(int comment_user_id) {
            this.comment_user_id = comment_user_id;
        }
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public int getComment_post_id() {
		return comment_post_id;
	}
	public void setComment_post_id(int comment_post_id) {
		this.comment_post_id = comment_post_id;
	}
	public String getComment_text() {
		return comment_text;
	}
	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}
	
}
