import 'package:flutter/material.dart';
import 'package:homework_03v2/cardGame.dart';

class StartScreen extends StatefulWidget{



   const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}
class _StartScreenState extends State<StartScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Card Game'),
        
      ),
      body: Center(
         
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome To the Card Game Click Start to Begin the fun!'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const Cardgame()),
                      );

                    }, 
                  child: Text('Start'),
                  )
                ],
              ),

          ],),
        
      ),
      );
  }
}