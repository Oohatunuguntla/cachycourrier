import 'package:flutter/material.dart';
import './home.dart';
import './timer.dart';
import './progressBar.dart';
import './avatarAndText.dart';
import './util.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class addOrderPage extends StatelessWidget{
  final String id;
  addOrderPage(this.id);
  
  // final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  // final timeFormat = DateFormat("h:mm a");
 
  @override
  Widget build(BuildContext context) {
    print('asd');
    print(id);
    // addOrderPage({Key key, this.id}) : super(key: key);
    // final String id;
    // addOrderPage(this.id);
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: id,

    //   theme: ThemeData(
    //     primarySwatch: Colors.pink,

    //   ),
    //   home: MyHomePage(title: id),
    // );
    return MyHomePage(id);
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;
    final String id;
    MyHomePage(this.id);
  @override

  // _MyHomePageState createState() => _MyHomePageState();
  State<StatefulWidget> createState() {
  return  _MyHomePageState(id);
  }
}
class _MyHomePageState extends State<MyHomePage> {

     final String id;
    _MyHomePageState(this.id);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
      print('add');
      print(id);
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final Button = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.pink,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => bookcourier(id));
          Navigator.push(context, route);
        },
        child: Text("Book a Courier",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final Button1 = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.pink,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => bookcourier1(id));
          Navigator.push(context, route);
        },
        child: Text("Hyperlocal",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Button,
                SizedBox(
                  height: 15.0,
                ),
                Button1,
                SizedBox(
                  height: 15.0,
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
class bookcourier extends StatelessWidget {
  
     final String id;
    bookcourier(this.id);
  @override
 
  Widget build(BuildContext context) {
    
    return Scaffold(


      body:
      MyCustomForm(id),
    );
  }
}
class bookcourier1 extends StatelessWidget {
     final String id;
    bookcourier1(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      MyCustomForm(id),
    );
  }
}


class MyCustomForm extends StatefulWidget {
     final String id;
    MyCustomForm(this.id);
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(id);
  }
}
//GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class MyCustomFormState extends State<MyCustomForm> {
  final String id;
  MyCustomFormState(this.id);
  final _formKey = GlobalKey<FormState>();
  // DateTime datetopick = new DateTime.now();
  // TimeOfDay timetopick = new TimeOfDay.now();
 

  // Future<Null> _selectDate(BuildContext context) async {
  //   print('date');
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: datetopick,
  //       firstDate: DateTime.now().subtract(Duration(days: 1)),
  //       lastDate: new DateTime(2050)
  //   );
  //   if(picked != null && picked != datetopick) {
  //     print('Date selected: ${datetopick.toString()}');
  //     setState((){
  //       datetopick = picked;
        
      
        
  //     });
  //   }
  // }

  // Future<Null> _selectTime(BuildContext context) async {
  //    TimeOfDay picked ;
  //    var now = new DateTime.now();
  //    var formatter = new DateFormat('yyyy-MM-dd');
  //    String presentdate = formatter.format(now);
  //    String _pickeddate = formatter.format(datetopick);
  //    if(_pickeddate==presentdate){
  //    picked= await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.now(),  
  //   );
  //   }
  //   else{
  //     picked= await showTimePicker(
  //       context: context,
  //       initialTime:timetopick,
  //   );
  //   }
    
  //   if(picked != null && picked != timetopick) {
  //       if (_pickeddate==presentdate)
  //       {
  //           if((((DateTime.now()).hour)>picked.hour)||((DateTime.now().minute>picked.minute)&&((DateTime.now()).hour)==picked.hour))
  //           {
      
  //               _scaffoldKey.currentState.showSnackBar(
        
  //               SnackBar(
          
  //               content: new Text('choose correct time'),
  //               duration: new Duration(seconds:5),
  //               backgroundColor: Colors.red,
                
  //              )
  //             );
  //           new RaisedButton(
  //                       child: new Text('Selectcorrect time'),
  //                       onPressed: (){_selectTime(context);}
  //                     );

  //             }
  
  //       } 
  //     print('time selected: ${timetopick.toString()}');
  //     setState((){
  //       timetopick = picked;
        
  //       String timeformettohoursandminutes='${timetopick.hour}'+':'+'${timetopick.minute}';
  //       print(timeformettohoursandminutes);
        
       
  //     });
  //    print('Time selected:');
  //    print(timetopick);
  //   } 
  // } 
 
DateTime datetopick;
   TimeOfDay timetopick;
  @override
  void initState() {
    super.initState();
    datetopick = DateTime.now();
    timetopick = TimeOfDay.now();
  }
  
  @override
  

  String radioItem = '';
  bool _value1 = false;
  bool _value2 = false;
  // String timetopick;
  String weight;
  String sourceaddress;
  String destinationaddress;
  String parceltype;
  String status;
  String promocode;
//  DateTime datetopick;
  void _onChanged1(bool value) => setState(() => _value1 = value);

  void _onChanged2(bool value) => setState(() => _value2 = value);

  Widget build(BuildContext context) {
     print('currentdate');
  print(datetopick);
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
        child: ListView(
      children: <Widget>[

        TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.home),
            hintText: 'Enter the source Address',
            labelText: 'sourceAddress',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter valid address';
            }
            return null;
          },
            onSaved: (value) {
                        sourceaddress = value;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.home),
            hintText: 'Enter the destination Address',
            labelText: 'destinationAddress',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter valid address';
            }
            return null;
          },
            onSaved: (value) {
                        destinationaddress = value;
                      },
        ),
             ListTile(
              title: Text("Date: ${datetopick.year}, ${datetopick.month}, ${datetopick.day}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap:()=> _pickDate(),
              
            ),
            ListTile(
              title: Text("Time: ${timetopick.hour}:${timetopick.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: ()=>_pickTime(),
            ),
            //   new RaisedButton(
            //     child: new Text('Select Date'),
            //     onPressed: (){
            //      print('clicked dtae');
              
            //   CupertinoDatePicker(
            //     mode: CupertinoDatePickerMode.date,
            //     initialDateTime: DateTime(1969, 1, 1),
            //     onDateTimeChanged: (DateTime newDateTime) {
            //       datetopick=newDateTime;
            //       print(datetopick);
            //     },
            //   );
          
                  
            // },
            //     color: Color.fromRGBO(40,80,40,0.8),
            //       padding: const EdgeInsets.all(8.0),
            //       textColor: Colors.white,
            //       shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            //   ),
            //   new Text('Date selected: ${datetopick}'),
            //    new RaisedButton(
            //     child: new Text('Select time'),
            //     onPressed: (){
            //            Container(
            //   height: 200,
            //   child: CupertinoDatePicker(
            //     mode: CupertinoDatePickerMode.time,
            //     initialDateTime:DateTime.now(),
            //     onDateTimeChanged: (DateTime newDateTime) {
            //       //Do Some thing
            //         timetopick=newDateTime;
            //     },
            //     use24hFormat: false,
            //     minuteInterval: 1,
            //   ),
            // );

            //     },
            //     color: Color.fromRGBO(40,80,40,0.8),
            //       padding: const EdgeInsets.all(8.0),
            //       textColor: Colors.white,
            //       shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            //   ),
            // new Text('Time selected: ${timetopick}'),
        
            
        // TextFormField(
        //   decoration: const InputDecoration(
        //     icon: const Icon(Icons.timer),
        //     hintText: 'Time to pickup',
        //     labelText: 'Time to pickup',
        //   ),
        //   validator: (value) {
        //     if (value.isEmpty) {
        //       return 'Please enter valid time';
        //     }
        //     return null;
        //   },
        //     onSaved: (value) {
        //                 timetopick = value;
        //               },
        // ),
        TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.question_answer),
            hintText: 'What are you sending?',
            labelText: 'What are you sending?',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter valid date';
            }
            return null;
          },
            onSaved: (value) {
                        parceltype = value;
                      },
        ),

        RadioListTile(
          groupValue: radioItem,
          title: Text('Upto 5 kg'),
          value: 'Upto 5kg',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          groupValue: radioItem,
          title: Text('Upto 10kg'),
          value: 'Upto 10kg',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          groupValue: radioItem,
          title: Text('Upto 15kg'),
          value: 'Upto 15kg',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          groupValue: radioItem,
          title: Text('Upto 20kg'),
          value: 'Upto 20kg',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),

        Text('Selected:  $radioItem', style: TextStyle(fontSize: 23),),


        TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.attach_money),
            hintText: 'Promocode?',
            labelText: 'Promocode',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter valid code';
            }
            return null;
          },
            onSaved: (value) {
                        promocode = value;
                      },
        ),


        // new SwitchListTile(
        //   value: _value2,
        //   onChanged: _onChanged2,
        //   title: new Text('Notify me by SMS', style: new TextStyle(
        //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink)),
        // ),
        // new SwitchListTile(
        //   value: _value2,
        //   onChanged: _onChanged2,
        //   title: new Text('Notify recipients by SMS', style: new TextStyle(
        //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink)),
        // ),


        new Container(
            width: double.infinity,
            height: 50.0,
            child: new RaisedButton(

              textColor: Colors.white,
              color: Colors.pink,

              child: const Text('Create Order'),

              onPressed: () {
                    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // print('firstname: $_firstName, lastname: $_lastName, gender: $_gender, email: $_email,dob: $_dob,password: $_password');
    }
                // It returns true if the form is valid, otherwise returns false
             print('crete ordre')     ;
          print(id);
          print(timetopick);
          
          print(weight);
          print(destinationaddress);
          print(sourceaddress);
          print(parceltype);
          
          print(promocode);
                Route route = MaterialPageRoute(builder: (context) => ConfirmOrderPage(id,sourceaddress,destinationaddress,
                                                                                      datetopick,timetopick,parceltype,radioItem,promocode));
                Navigator.push(context, route);
              },
            )),

      ],
        )
    );



  }
  
     _pickDate() async {
   DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: datetopick,
    );
    if(date != null)
      setState(() {
        datetopick = date;
      });
  }
   _pickTime() async {
   TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: timetopick
    );
    if(t != null)
      setState(() {
        timetopick = t;
      });
  }
}

class ConfirmOrderPage extends StatefulWidget{
  final String id,sourceaddress,destinationaddress,parceltype,weight,promocode;
  final DateTime datetopick;
  final TimeOfDay timetopick;
  ConfirmOrderPage(this.id,this.sourceaddress,this.destinationaddress,this.datetopick,this.timetopick,this.parceltype,this.weight,this.promocode);
  @override
  State<StatefulWidget> createState() {
    return _ConfirmOrderPageState(id,sourceaddress,destinationaddress,datetopick,timetopick,parceltype,weight,promocode);
  }
}
class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final String id,sourceaddress,destinationaddress,parceltype,weight,promocode;
   final DateTime datetopick;
  final TimeOfDay timetopick;
  _ConfirmOrderPageState(this.id,this.sourceaddress,this.destinationaddress,this.datetopick,this.timetopick,this.parceltype,this.weight,this.promocode);
  static final String path = "lib/src/pages/ecommerce/confirm_order1.dart";

  String total;
  final double delivery = 100;

  @override
  
  Widget build(BuildContext context) {

      if (weight=='Upto 5kg'){
          total = '500';
      }
      else if(weight=='Upto 10kg'){
           total = '750';
      }
      else if(weight =='Upto 15kg'){
        total = '1000';
      }
      else{
        total = '1500';
      }
            
          print(id);
          print(timetopick);
          print(weight);
          print(destinationaddress);
          print(sourceaddress);
          print(parceltype);
          print(total);
          print(promocode);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Subtotal"),
              Text("Rs. $total"),
            ],
          ),
          // SizedBox(height: 10.0,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text("Delivery fee"),
          //     Text("Rs. $delivery"),
          //   ],
          // ),
          // SizedBox(height: 10.0,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text("Total", style: Theme.of(context).textTheme.title,),
          //     Text("Rs. ${total+delivery}", style: Theme.of(context).textTheme.title),
          //   ],
          // ),
          
          SizedBox(height: 20.0,),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text("Delivery Address".toUpperCase())
          ),
          Column(
            children: <Widget>[
              RadioListTile(
                selected: true,
                value: destinationaddress,
                groupValue: destinationaddress,
                title: Text('address'),
                onChanged: (value){},
              ),
              // RadioListTile(
              //   selected: false,
              //   value: "New Address",
              //   groupValue: address,
              //   title: Text("Choose new delivery address"),
              //   onChanged: (value){},
              // ),
              // Container(
              //     color: Colors.grey.shade200,
              //     padding: EdgeInsets.all(8.0),
              //     width: double.infinity,
              //     child: Text("Contact Number".toUpperCase())
              // ),
              // RadioListTile(
              //   selected: true,
              //   value: phone,
              //   groupValue: phone,
              //   title: Text(phone),
              //   onChanged: (value){},
              // ),
              // RadioListTile(
              //   selected: false,
              //   value: "New Phone",
              //   groupValue: phone,
              //   title: Text("Choose new contact number"),
              //   onChanged: (value){},
              // ),
            ],
          ),
          SizedBox(height: 20.0,),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text("Payment Option".toUpperCase())
          ),
          RadioListTile(
            groupValue: true,
            value: true,
            title: Text("Cash on Delivery"),
            onChanged: (value){},
          ),
          RadioListTile(
            groupValue: true,
            value: false,
            title: Text("PayPal"),
            onChanged: (value){},
          ),
          RadioListTile(
            groupValue: true,
            value: false,
            title: Text("Paytm"),
            onChanged: (value){},
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _addorder(id,sourceaddress,destinationaddress,datetopick,timetopick,parceltype,weight,total,promocode);
             
              },
              child: Text("Confirm Order", style: TextStyle(
                  color: Colors.white
              ),),
            ),
          )
        ],
      ),
    );
  }
   void _addorder(id,sourceaddress,destinationaddress,datetopick,timetopick,parceltype,weight,total,promocode) async {
    try {
        print('addorderfun');
        print(DotEnv().env['ipadress']);
         var url="http://"+DotEnv().env['ipadress']+":"+DotEnv().env['port']+"/addorder";
         print(url);
          print(id);
          var storedTime = timetopick.hour * 3600 +timetopick.minute;
         
         print(storedTime.runtimeType);
          print(datetopick.year.runtimeType);
          print(timetopick);
          print(weight);
          print(destinationaddress);
          print(sourceaddress);
          print(parceltype);
          print(total);
          print(promocode);
          print('complet');
          // 
          //                                           
          //                                           ,
          //                                          
     http.Response resp = await http.post(url,body:{'sourceid':id,'weight':weight,'sourceaddress':sourceaddress,'destinationaddress':destinationaddress,
                                                         'parceltype':parceltype,'cost':total,'promocode':promocode,'status':'created but not assigned',
                                                         'year':datetopick.year.toString(),'month':datetopick.month.toString(),'day':datetopick.day.toString(),
                                                         'timetopick':storedTime.toString()});
        
      if (resp.statusCode == 200) {
    
      var jsonResponse = convert.jsonDecode(resp.body);
      var url1="http://"+DotEnv().env['ipadress']+":"+DotEnv().env['port']+"/notifications/sendnotification";
      print('$jsonResponse');
      print("success order");
       http.Response resp1=await http.post(url1,body:{'parcelid':jsonResponse['parcelid']});
       if(resp.statusCode==200){
          print('notification sent');
       }
      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Order(id)),
                );

    // //   Navigator.pushNamed(
    // //   context,
    // //   ExtractArgumentsScreen.routeName,
    // //   arguments: ScreenArguments(
    // //     'Extract Arguments Screen',
    // //     'This message is extracted in the build method.',
    // //   ),
    // // );
     }
    else{
      print(resp.statusCode);
     print('fail');
      
    }  
   }   
   catch(error){

         print('error: $error');
        _showAlertDialog('Error', error.toString());      
                         }                      // 10.0.2.2 for emulator

    // if (resp.statusCode == 200) {
    //   print("ghjkl");
    //   var jsonResponse = convert.jsonDecode(resp.body);
    //   print('$jsonResponse');
    //   print("success");
    //   print(jsonResponse['currentuser']);
    //   Navigator.of(context).pushNamed('/userpage');
    // }
    // else{
    //   print(resp.statusCode);
    //   print("fail");
    //   Navigator.of(context).pushNamed('/loginpage');
    //   }
    // } 
    //   catch (error) {
    //     print('error: $error');
    //     _showAlertDialog('Error', error.toString());
        
    //   }
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

class Order extends StatefulWidget {
  final String id;
  Order(this.id);
  @override
  _OrderState createState() => _OrderState(id);
}

class _OrderState extends State<Order> with TickerProviderStateMixin {
  // final timerDuration = Duration(milliseconds: 2500);
  final String id;
  _OrderState(this.id);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'Order#568',
                style:
                TextStyle(color: Color.fromRGBO(0, 0, 0, 0.2), fontSize: 12),
              ),
            ),
            Timer(),
            ProgressBar(),
            SizedBox(height: 50),
            AvatarAndText(),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: OutlineButton(
                borderSide: BorderSide(width: 1.0, color: FoodColors.Blue),
                color: FoodColors.Blue,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 50),
                      Text(
                        'Go to Homepage',
                        style: TextStyle(fontSize: 15, color: FoodColors.Blue),
                      ),
                      SizedBox(width: 50),
                      Image.asset(
                        'assets/images/icon_direction.png',
                        scale: 2,
                      )
                    ],
                  ),
                ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(id)),
                    );
                  },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
