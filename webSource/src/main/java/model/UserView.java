package model;

// bảng join giữa user và userProfile
public class UserView {
    private User user;
    private UserProfile userProfile;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public UserProfile getUserProfile() {
        return userProfile;
    }

    public void setUserProfile(UserProfile userProfile) {
        this.userProfile = userProfile;
    }
}