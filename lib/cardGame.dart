import 'package:easy_count_timer/easy_count_timer.dart';
import 'package:flutter/material.dart';

class Cardgame extends StatefulWidget{

const Cardgame ({super.key});
@override
State<Cardgame> createState () => _CardgameState();
}
class _CardgameState extends State<Cardgame>{


@override
initState(){
   countController = CountTimerController();
   countController.start();
}
var countController;
@override
  Widget build(BuildContext context){
    return
    Scaffold(
      appBar: AppBar(
        title: CountTimer(
          controller: countController,
          format: CountTimerFormat.daysHoursMinutesSeconds,
          spacerWidth: 20.0,
          enableDescriptions: true,
          minutesDescription: 'Minutes',
          secondsDescription: 'Seconds',
          ),
      ),
      body: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
       ),

      ),
      
    );

  }
  
 
}
