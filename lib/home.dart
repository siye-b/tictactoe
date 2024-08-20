import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  bool ohTurn = true; 
  int _counter = 0;
  int ohScore = 0;
  int exScore = 0;
  List<String> displayExo = ['','','','','','','','','',];
  int filleboxes = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
  
        backgroundColor: Colors.blueGrey.shade800,//Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title, style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text('Player O', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 20),),
                        Text(ohScore.toString(), style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 20),),
                      ],
                    ),
                  ),
                  SizedBox(width: 50,),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text('Player X', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 20),),
                        Text(exScore.toString(), style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 20),),
                      ],
                    ),
                  ),
                ],
                
              ),
            )
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                bool isTopRow = index < 3;
                bool isBottomRow = index >= 6;
                bool isLeftColumn = index % 3 == 0;
                bool isRightColumn = (index + 1) % 3 == 0;
              return GestureDetector(
                onTap: (){
                  _tapped(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: isTopRow ? BorderSide.none : BorderSide(color: Colors.blueGrey),
                      bottom: isBottomRow ? BorderSide.none : BorderSide(color: Colors.blueGrey),
                      left: isLeftColumn ? BorderSide.none : BorderSide(color: Colors.blueGrey),
                      right: isRightColumn ? BorderSide.none : BorderSide(color: Colors.blueGrey),
                      
                    ),
                  ),
                  child: Center(
                    child: Text(displayExo[index], style: TextStyle(fontSize: 40),)
                  ),
                ),
              );
            }),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          
                        ),
                        onPressed: () {
                          _newGame();
                        }, child: Text('New Game', 
                        style: TextStyle(color: Colors.white, fontSize: 20),),
                      )

                    ],
                  ),
                ),
              ),
            )
          ),
        ],
      )
    );
  }

  void _newGame() {
    ohScore = 0;
    exScore = 0;
    _clearBoard();
  }

  void _tapped (int index) {
    
    setState(() {
      if (ohTurn == true && displayExo[index] == '') {
        displayExo[index] = 'o';
        filleboxes += 1;
      } else if(!ohTurn && displayExo[index] == ''){
        displayExo[index] = 'x';
        filleboxes += 1;
      }
      ohTurn = !ohTurn;
      checkWinner();
    });
    
  }

  void checkWinner() {

    if (displayExo[0] == displayExo[1] && displayExo[0] == displayExo[2] && displayExo[0] != '') {
      _showInDialogue(displayExo[0]);
    }
    if (displayExo[3] == displayExo[4] && displayExo[3] == displayExo[5] && displayExo[3] != '') {
      _showInDialogue(displayExo[3]);
    }
    if (displayExo[6] == displayExo[7] && displayExo[6] == displayExo[8] && displayExo[6] != '') {
      _showInDialogue(displayExo[6]);
    }
    if (displayExo[0] == displayExo[3] && displayExo[0] == displayExo[6] && displayExo[0] != '') {
      _showInDialogue(displayExo[0]);
    }
    if (displayExo[1] == displayExo[4] && displayExo[1] == displayExo[7] && displayExo[1] != '') {
      _showInDialogue(displayExo[1]);
    }
    if (displayExo[2] == displayExo[5] && displayExo[2] == displayExo[8] && displayExo[2] != '') {
      _showInDialogue(displayExo[2]);
    }
    if (displayExo[0] == displayExo[4] && displayExo[0] == displayExo[8] && displayExo[0] != '') {
      _showInDialogue(displayExo[0]);
    }
    if (displayExo[2] == displayExo[4] && displayExo[2] == displayExo[6] && displayExo[2] != '') {
      _showInDialogue(displayExo[2]);
    }
    else if (filleboxes == 9) {
      _showDrawDialogue();
    }
    

  }
  void _showDrawDialogue () {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Draw'),
          actions: <Widget>[
            TextButton(
              onPressed: () { 
                _clearBoard();
                Navigator.of(context).pop();
              }, 
              child: Text('Play again', style: TextStyle(color: Colors.blue),),

            )
          ]
        );
    });
  }

  void restartGame() {
    displayExo = ['','','','','','','','','',];
  }

  void _showInDialogue(String winner) {
    
  
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Winner is Player: $winner'),
          actions: <Widget>[
            TextButton(
              onPressed: () { 
                _clearBoard();
                Navigator.of(context).pop();
              }, 
              child: Text('Play again', style: TextStyle(color: Colors.blue),),

            )
          ]
        );
    });
    
    if (winner == 'o') {
      ohScore += 1;
    } else if(winner == 'x') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i=0; i<9; i++) {
        displayExo[i] = ''; 
      }
    });
    filleboxes = 0;
    
  }
}
