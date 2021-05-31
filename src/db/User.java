package db;

public class User {

	

	private String userID;

	private String userPassword;

	private String userName;

	private String userType;
	
	private String email;
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String _email) {
		this.email = _email;
	}

	public String getUserID() {

		return userID;

	}

	public void setUserID(String userID) {

		this.userID = userID;

	}

	public String getUserPassword() {

		return userPassword;

	}

	public void setUserPassword(String userPassword) {

		this.userPassword = userPassword;

	}

	public String getUserName() {

		return userName;

	}

	public void setUserName(String userName) {

		this.userName = userName;

	}

	public String getUserType() {

		return userType;

	}

	public void setUserType(String userType) {

		this.userType = userType;

	}

}