import 'package:flutter/material.dart';
import 'package:cachycourier/screens/authentication/signup.dart';
import 'package:cachycourier/screens/authentication/login.dart';
import 'package:cachycourier/screens/authentication/reset.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cachycourier/screens/customer/Home.dart';
import 'package:cachycourier/screens/customer/Usernew.dart';
import 'package:cachycourier/screens/customer/addorder.dart';
import 'package:cachycourier/screens/customer/Notifications.dart';
import 'package:cachycourier/screens/Statsofapp.dart';
void main(){
  runApp(Cachycourier());
}
class Cachycourier extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    DotEnv().load('.env');
    String id;
    String stats;
        return MaterialApp(
          // title: 'Cachycourier',
          // debugShowCheckedModeBanner: false,
          // theme:ThemeData(
          //   primarySwatch:Colors.pink
          // ),
          
          routes:<String,WidgetBuilder>{
            '/signuppage':(BuildContext context)=>Signup(),
            '/loginpage':(BuildContext context)=>Login(),
            '/resetpage':(BuildContext context)=>ResetPassword(),
            '/userpage':(BuildContext context)=>Usernew(),
            '/addorderpage':(BuildContext context)=>addOrderPage(id),
            //'/addorderpage':(BuildContext context)=>addOrderPage(),
        '/homepagecustomer':(BuildContext context)=>Homepagecustomer(id),
        '/notificationpage':(BuildContext context)=>NotificationsPage(),
         '/statsofapppage':(BuildContext context)=>StatsofappPage(stats),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Login();
  }
}