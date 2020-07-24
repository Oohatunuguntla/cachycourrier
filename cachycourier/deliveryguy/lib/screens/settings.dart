import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './Statsofdeliveryguy.dart';

class settings extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";
 final String id;
  settings(this.id);
  
  @override
  
  _SettingsOnePageState createState() => _SettingsOnePageState(id);
}

class _SettingsOnePageState extends State<settings> {
  bool _dark;
 final String id;
  _SettingsOnePageState(this.id);
  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    print('inside settings');
    print(id);
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Profile settings',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.pink,
                    child: ListTile(
                      onTap: () {
                        //open edit profile
                      },
                      title: Text(
                        "SAISREENITHYA",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.pink,
                          ),
                          title: Text("Change Password"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change password
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.language,
                            color: Colors.pink,
                          ),
                          title: Text("Change Language"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.pink,
                          ),
                          title: Text("Change Location"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change location
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                
                  RaisedButton(
                  color: Theme.of(context).primaryColor,
                      onPressed: () {
                         _statsofdeliveryguy(id);
                         
              },
              child: Text("statistics", style: TextStyle(
                  color: Colors.white
              ),),
            ),


//
//                  SwitchListTile(
//                    activeColor: Colors.pink,
//                    contentPadding: const EdgeInsets.all(0),
//                    value: true,
//                    title: Text("Received App Updates"),
//                    onChanged: null,
//                  ),

                  const SizedBox(height: 60.0),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );

  }
  void  _statsofdeliveryguy(id) async{
       print(id.toString().split(":")[1]);
    Map<String, String> queryParameters={'id':id.toString().split(":")[1]};
    
    try{
       print(DotEnv().env['ipadress']);
       print('hiiiii');
      var url=DotEnv().env['ipadress']+":"+DotEnv().env['port'];
         print(url);
     
       var uri =Uri.http(url,'/stats/statsofdeliveryguy', queryParameters);
        var resp = await http.get(uri);
     
   // http.Response resp = await http.get(url,queryParameters);  // 10.0.2.2 for emulator
    if (resp.statusCode == 200) {
      print("success");
      var jsonResponse = convert.jsonDecode(resp.body);
      print('stats of user');
     print('$jsonResponse');
    
     // Navigator.of(context).pushNamed('/userpage');
     Navigator.of(context).pushNamed('/statsofdeliveryguypage',
     arguments:{jsonResponse});
            
     
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