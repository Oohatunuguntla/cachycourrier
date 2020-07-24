//import 'package:flutter_appeadproject/main.dart';

import './FadeAnimation.dart';
//import './FindEvent.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Statsofapp.dart';

// void main() => runApp(
//     MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Homepagecustomer()
//     )
// );

class Homepagecustomer extends StatefulWidget {
  final String id;
  Homepagecustomer(this.id);
  @override
  _HomePageState createState() => _HomePageState(id);
}

class _HomePageState extends State<Homepagecustomer> with SingleTickerProviderStateMixin{
   final String id;
  _HomePageState(this.id);
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  bool hide = false;

  @override
  void initState() {

    super.initState();

    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(child:Homepagecustomer(id), type: PageTransitionType.fade));
      }
    });
  }

  @override
  void dispose() {

    super.dispose();

    _scaleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background1.png'),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.3),
                  ]
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(1, Text("We Deliver your package safely and fast.",
                style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold, height: 1.1),)),
              SizedBox(height: 30,),
              FadeAnimation(1.2, Text("On demand delivery app",
                style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 25, fontWeight: FontWeight.w100),)),
              SizedBox(height: 150,),
              FadeAnimation(1.4, InkWell(
                onTap: () {
                  setState(() {
                    hide = true;
                  });
                  _scaleController.forward();
                },
                child: AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                         width: double.infinity,
            child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _statsofapp(id);
                         
              },
              child: Text("Stats of company", style: TextStyle(
                  color: Colors.white
              ),),
            ),
                        // height: 60,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(50),
                        //     color: Colors.pink[700]
                        // ),
                        // child: hide == false ? Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: <Widget>[

                        //     Text("Stats of company", style: TextStyle(color: Colors.white, fontSize: 17),),
                        //     Icon(Icons.arrow_forward, color: Colors.white,)
                        //   ],
                        // ) : Container(),
                      ),
                    )
                ),
                
              )),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }
  
  void _statsofapp(id) async {
    try{
      print(DotEnv().env['ipadress']);
         var url="http://"+DotEnv().env['ipadress']+":"+DotEnv().env['port']+"/stats/statsofapp";
        http.Response resp =  await http.get(url);
     
        
     if (resp.statusCode == 200) {
    
      var jsonResponse = convert.jsonDecode(resp.body);
     
      print('$jsonResponse');
      print("success stats");
       
    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsofappPage(jsonResponse)),
                );
             
// Navigator.of(context).pushNamed('/statsofapppage',
//      arguments:jsonResponse);

     }
    else{
      print(resp.statusCode);
     print('fail');
      
    }  
  
    }
    catch(error){
      print(error);

    }

  }
}