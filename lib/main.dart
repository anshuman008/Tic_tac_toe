import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];

  var current = 'X';
  var winnerplayer = "";
  void drawxo(i) {
    if (grid[i] == '-') {
      setState(() {
        grid[i] = current;
        current = current == 'X' ? 'O' : 'X';
      });
      winner(grid[i]);
    }
  }

  bool checkMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void winner(currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
            checkMove(3, 4, 5, currentsign) ||
            checkMove(6, 7, 8, currentsign) || // rows
            checkMove(0, 3, 6, currentsign) ||
            checkMove(1, 4, 7, currentsign) ||
            checkMove(2, 5, 8, currentsign) || // column
            checkMove(0, 4, 8, currentsign) ||
            checkMove(2, 4, 6, currentsign) // digonals
        ) {
      setState(() {
        winnerplayer = currentsign;
      });
    }
  }

  void reset() {
    setState(() {
      winnerplayer = "";
      grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('tic toe game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (winnerplayer != "") Text('Player $winnerplayer won the game',style: TextStyle(fontSize: 30),),
              Container(
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
                color: Colors.black,
                margin: EdgeInsets.all(20),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: grid.length,
                  itemBuilder: (context, index) => Material(
                    color: Colors.deepOrange,
                    child: InkWell(
                      splashColor: Colors.black,
                      onTap: () {
                        drawxo(index);
                      },
                      child: Center(
                        child: Text(
                          grid[index],
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  onPressed: reset,
                  icon: Icon(Icons.refresh),
                  label: Text('Play again'))
            ],
          ),
        ),
      ),
    );
  }
}
