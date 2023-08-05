class User{
  late int id;
  late String name;
  late String email;
  late String password;

  static const String tableName ='users';
  User();


  //Read: Convert row map to user object
  User.fromMap(Map<String , dynamic> rowMap){
    id = rowMap['id'];
    name = rowMap['name'];
    email = rowMap['email'];
    password = rowMap['password'];
  }

  //Store: convert object to map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = <String, dynamic>{};
    map['name']=name;
    map['email']=email;
    map['password']=password;
    return map ;

  }
}