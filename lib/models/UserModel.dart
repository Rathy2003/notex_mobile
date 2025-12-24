class User{
  String id;
  String username;
  String email;
  String? profile;

  User({required this.id,required this.username,required this.email,this.profile});

  factory User.fromJson(Map<String,dynamic> json){
    return User(email: json["email"],username: json["username"],id: json["id"],profile: json["profile"]);
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profile': profile,
    };
  }

}