import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:easy_count_timer/easy_count_timer.dart';

class Cardgame extends StatefulWidget {
  const Cardgame({super.key});

  @override
  State<Cardgame> createState() => _CardgameState();
}

class _CardgameState extends State<Cardgame> {
  late CountTimerController countController;
  List<int> cards = [0, 0, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6];
  List<int> isAMatch = []; // Stores indexes of selected cards
  late List<bool> matchedCards;
  late List<FlipCardController> flipCardControllers;
  int userScore = 0;

  @override
  void initState() {
    super.initState();
    countController = CountTimerController();
    countController.start();
    cards.shuffle(); // Shuffle cards at the start
    flipCardControllers = List.generate(12, (_) => FlipCardController());
    matchedCards = List.generate(12, (_) => false);
  }

  void onCardTap(int index) {
    if (matchedCards[index] || isAMatch.contains(index) || isAMatch.length == 2) {
      return; // Ignore tap if card is already flipped or two cards are selected
    }

    flipCardControllers[index].flipcard();
    isAMatch.add(index);

    if (isAMatch.length == 2) {
      int firstIndex = isAMatch[0];
      int secondIndex = isAMatch[1];

      if (cards[firstIndex] == cards[secondIndex]) {
        setState(() {
          matchedCards[firstIndex] = true;
          matchedCards[secondIndex] = true;
          userScore += 10;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You found a match! Score: $userScore")),
        );

        isAMatch.clear();
        if (matchedCards.every((card) => card)) {
          _showWinDialog();
        }
      } else {
        Future.delayed(Duration(seconds: 1), () {
          flipCardControllers[firstIndex].flipcard();
          flipCardControllers[secondIndex].flipcard();
          setState(() {
            userScore = (userScore - 5).clamp(0, double.infinity).toInt();
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No match! Score: $userScore")),
        );

        isAMatch.clear();
      }
    }
  }

  void _showWinDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You Win!!'),
            content: Text('Would you like to restart or end Game?!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    restartGame();
                  },
                  child: Text("Restart")),
              TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text("END GAME"))
            ],
          );
        });
  }

  void restartGame() {
    setState(() {
       for (int i = 0; i < flipCardControllers.length; i++) {
      if (flipCardControllers[i].state?.isFront == false) {
        flipCardControllers[i].flipcard();
      }
    }
      cards.shuffle();
      isAMatch.clear();
      matchedCards = List.generate(12, (_) => false);
      userScore = 0;
      flipCardControllers = List.generate(12, (_) => FlipCardController());
      countController.dispose();
      countController = CountTimerController();
      countController.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CountTimer(
          controller: countController,
          format: CountTimerFormat.minutesSeconds,
          enableDescriptions: true,
          minutesDescription: 'Minutes',
          secondsDescription: 'Seconds',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onCardTap(index),
                    child: FlipCard(
                      onTapFlipping: false,
                      controller: flipCardControllers[index],
                      animationDuration: const Duration(milliseconds: 400),
                      axis: FlipAxis.horizontal,
                      rotateSide: RotateSide.bottom,
                      frontWidget: matchedCards[index]
                          ? Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text('${cards[index]}',
                                    style: TextStyle(color: Colors.white, fontSize: 20)),
                              ),
                            )
                          : Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                      backWidget: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('${cards[index]}',
                              style: TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text('Your Score: $userScore', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
