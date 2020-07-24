
// import 'package:cachycourier/screens/customer/Home.dart';
// import 'package:flutter/material.dart';
// //import './home.dart';
// import './addorder.dart';
// import './settings.dart';
// //import './Notifications.dart';
// class Usernew extends StatefulWidget {
//   @override
//   // final String data;
//   // Usernew({
//   //   Key key,
//   //   @required this.data,
//   //   print(data)
//   // }) :super(key: key);

//   State<StatefulWidget> createState() {
    
    
//     return _UsernewState();
//   }
// }
// class _UsernewState extends State<Usernew> {
  

//   @override
//   Widget build(BuildContext context) {
    
//      final Map arguments = ModalRoute.of(context).settings.arguments as Map;
//       print('usernew');
      
//     if (arguments != null) print(arguments['id']);
//   int _selectedTab = 0;

//   final _pageOptions = [
//     Homepagecustomer(),
//     addOrderPage(arguments['id']),
//    // addOrderPage(),
//     StatsScreen(),
//   ];
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           primarySwatch: Colors.pink,
//           primaryTextTheme: TextTheme(
//             title: TextStyle(color: Colors.white),
//           )),
//       home: Scaffold(
//       appBar:AppBar(
//           title: Text('Cachycourier'),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.alarm,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 // do something
//                  Navigator.of(context).pushNamed('/notificationpage',arguments: {'id':arguments['id']});
//               },
//             )
//           ],
//         ),
//         body: _pageOptions[_selectedTab],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _selectedTab,
//           onTap: (int index) {
//             setState(() {
//               _selectedTab = index;
//             });
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               title: Text('Home'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add_box),
//               title: Text('New Order'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.help),
//               title: Text('Profile'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
   
//   }









import 'package:cachycourier/screens/customer/Home.dart';
import 'package:flutter/material.dart';

import './addorder.dart';
import './settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';

void main() => runApp(new Usernew());
class Usernew extends StatefulWidget {
  @override
// final Map arguments = ModalRoute.of(context).settings.arguments as Map;
//       print('usernew');
      
//     if (arguments != null) print(arguments['id']); 
  State<StatefulWidget> createState() {

    return MyAppState();
  }
}
class MyAppState extends State<Usernew> {
  
  int _selectedTab = 0;

  @override
  

  Widget build(BuildContext context) {
      final Map arguments = ModalRoute.of(context).settings.arguments as Map;
        final _pageOptions = [
    Homepagecustomer(arguments['id']),
    addOrderPage(arguments['id']),
    StatsScreen(),
  ];
//       print('usernew');
      
//     if (arguments != null) print(arguments['id']);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          )),
      home: Scaffold(
   appBar:AppBar(
          title: Text('Cachycourier'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.alarm,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
               _notifications(arguments['id']);
                   },
            )
          ],
        ),
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              title: Text('New Order'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Setting'),
            ),
          ],
        ),
      ),
    );
  }
  void _notifications(id) async {
    print('notifications');
    print(id.toString().split(":")[1]);
    Map<String, String> queryParameters={'id':id.toString().split(":")[1]};
    print('helloo');
    try{
       print(DotEnv().env['ipadress']);
       print('hiiiii');
      var url=DotEnv().env['ipadress']+":"+DotEnv().env['port'];
         print(url);
     
       var uri =Uri.http(url,'notifications', queryParameters);
        var resp = await http.get(uri);
     
   // http.Response resp = await http.get(url,queryParameters);  // 10.0.2.2 for emulator
    if (resp.statusCode == 200) {
      print("success");
      var jsonResponse = convert.jsonDecode(resp.body);
      print('notifications of user');
     print('$jsonResponse');
     print(jsonResponse['notification'][0]['notificationtext']);
     // Navigator.of(context).pushNamed('/userpage');
     Navigator.of(context).pushNamed('/notificationpage',
     arguments:{'notifications':jsonResponse['notification']});
            
     
    }
    else{
      print(resp.statusCode);
      print("fail");
     // Navigator.of(context).pushNamed('/loginpage');
    }
      } catch (error) {
        print('error: $error');
        _showAlertDialog('Error', error.toString());
        
      }
    
  }


  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) {
          return alertDialog;
        });
  }
  }

