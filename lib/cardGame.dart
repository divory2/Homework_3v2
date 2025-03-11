import 'package:easy_count_timer/easy_count_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class Cardgame extends StatefulWidget{

const Cardgame ({super.key});
@override
State<Cardgame> createState () => _CardgameState();
}

class _CardgameState extends State<Cardgame>{


@override
initState(){
  super.initState();
   countController = CountTimerController();
   countController.start();
}
int  userScore=0;
late CountTimerController countController;
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
          const SizedBox(height: 20,),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [

                GestureFlipCard(
                    animationDuration: const Duration(milliseconds: 400),
                    axis: FlipAxis.horizontal,
                    frontWidget: Container(
                      height: 20,
                      color: Colors.green,
                      child: Text('next'),
                    ),
                      backWidget: Container(
                        height: 20,
                        color: Colors.red,
                        child: Text('back')
                      ) ,),

                

              ],),
          )

        ],
       ),

      ),
      
    );

  }
  
 
}
