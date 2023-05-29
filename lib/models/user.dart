import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType()
class User {
    @HiveField(typeId:0)
    String username;
    @HiveField(typeId:1)
    int password;

    User(this.username, this.password); 
}