class User {
  public String username;
  public String password;
  public Portfolio f; 

  void setup() {
    this.username= "";
    this.password= "";
  }

  void draw() {
  }

  void setUsername(String usern) {
    this.username = usern;
  }

  void setPassword(String passw) {
    this.password = passw;
  }

  public User(String usrname, String passwrd) {
    this.username = usrname;
    this.password = passwrd;
  }
   public User(String usrname, String passwrd, ) {
    this.username = usrname;
    this.password = passwrd;
    f.setCurrentAmount();
    f.setInitialAmount();
  }

public String toString() {
    return (username+ ',' + password + '\n');
  }

  public String toString(Portfolio f) {
    String ret = (username+ ',' + password+ f.toString());
    return ret + '\n';
  }
}