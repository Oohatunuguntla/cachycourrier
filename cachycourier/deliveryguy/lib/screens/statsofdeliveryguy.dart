import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_core/core.dart';

class StatsofdeliveryguyPage extends StatefulWidget{
  var stats;
  StatsofdeliveryguyPage(this.stats);
    @override
  State<StatefulWidget> createState() {
    return _StatsofdeliveryguypageState(stats);
  }
}
class _StatsofdeliveryguypageState extends State<StatsofdeliveryguyPage>{

 final  stats;
_StatsofdeliveryguypageState(this.stats);
  

  @override
 
  Widget build(BuildContext context) {
    final Map arguments = stats as Map;

    //final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    print('statspageinside');
    print(arguments);
    // final List<ChartData>chartdata=[
    //     ChartData('created_but_not_assigned', arguments['created_but_not_assigned']),
    //     ChartData('ongoing', arguments['ongoing']),
    //     ChartData('completed', arguments['completed'])
    // ];
    final List<Chartdata>chartdata=[
      Chartdata('January',arguments['january']),
      Chartdata('Febraury', arguments['febraury']),
      Chartdata('March',arguments['march']),
      Chartdata('Apil', arguments['april']),
      Chartdata('May',arguments['may']),
      Chartdata('June',arguments['june']),
      Chartdata('July', arguments['july']),
      Chartdata('August', arguments['august']),
      Chartdata('September', arguments['september']),
      Chartdata('October', arguments['october']),
      Chartdata('November', arguments['november']),
      Chartdata('December',arguments['december'])    

    ];
    return Scaffold(
            body: SafeArea(
                child: Center(
                  child:Container(height: 400, // height of the Container widget
              width: 450,
                child: SfCircularChart(
              //       borderColor: Colors.red,
              // borderWidth: 2,
              // // Sets 15 logical pixels as margin for all the 4 sides.
              // margin: EdgeInsets.all(15),
              //  backgroundColor: Colors.lightGreen,
                // backgroundImage: const AssetImage('background.jpg'),
                        legend: Legend(isVisible: true,
                        
                          overflowMode: LegendItemOverflowMode.wrap,
                            borderColor: Colors.black,
                            position: LegendPosition.bottom,
                borderWidth: 2),
                    
                    series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<Chartdata, String>(
                            dataSource: chartdata,
                            pointColorMapper:(Chartdata data,  _) => data.color,
                            xValueMapper: (Chartdata data, _) => data.x,
                            yValueMapper: (Chartdata data, _) => data.y,
                             dataLabelSettings: DataLabelSettings(
                                    // Renders the data label
                                    
                                    isVisible: true,
                                    
                                     
                                    labelPosition: ChartDataLabelPosition.inside
                                )
                        )
                    ]
                    // child: SfCircularChart(series: <CircularSeries>[
                    //     // Render pie chart
                    //     PieSeries<ChartData, String>(
                    //         dataSource: chartdata,
                    //         pointColorMapper:(ChartData data,  _) => data.color,
                    //         xValueMapper: (ChartData data, _) => data.x,
                    //         yValueMapper: (ChartData data, _) => data.y
                    //     )
                    // ]
                )
               ),
                
            )
            )
        );
  
  }
   
  }

  class Chartdata {
    Chartdata(this.x, this.y, [this.color]);
    final String x;
    final  y;
    final Color color;
}