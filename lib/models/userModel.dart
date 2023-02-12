class UserModel{

    String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  String? phone;
  bool? booktable= false;
  bool? panalty= false;


    UserModel({this.uid, this.fullname, this.email, this.profilepic,this.phone,this.booktable=false,this.panalty=false});


      UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
    phone=map['phone'];
    booktable=map["booktable"];
    panalty =map["panalty"];



  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
      "phone":phone,
      "booktable":booktable,
      "panalty":panalty
    };
  }

}