import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TicTacToePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  late List<String> board;
  late String currentPlayer;
  late String winner;
  late bool isDraw;
  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    board = List.generate(9, (_) => "");
    currentPlayer = "X";
    winner = "";
    isDraw = false;
  }

  void _handleTap(int index) {
    if (board[index] != "" || winner != "") return;
    setState(() {
      board[index] = currentPlayer;
      if (_checkWinner(currentPlayer)) {
        winner = currentPlayer;
      } else if (_checkDraw()) {
        isDraw = true;
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool _checkWinner(String player) {
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == player &&
          board[i * 3 + 1] == player &&
          board[i * 3 + 2] == player) {
        return true;
      }
      if (board[i] == player &&
          board[i + 3] == player &&
          board[i + 6] == player) {
        return true;
      }
    }
    if (board[2] == player && board[4] == player && board[6] == player) {
      return true;
    }
    if (board[0] == player && board[4] == player && board[8] == player) {
      return true;
    }
    return false;
  }

  bool _checkDraw() {
    return board.every((cell) => cell != '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 91, 226, 125),
        title: const Text("TicTacToe "),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          winner != ''
              ? Text("The winner is $winner")
              : isDraw
                  ? const Text("just draw stupid")
                  : Text(
                      "CurrentPlayer is $currentPlayer",
                      style: const TextStyle(
                          backgroundColor: Color.fromARGB(66, 243, 159, 159),
                          color: Color.fromARGB(173, 245, 96, 85),
                          fontSize: 20.0),
                    ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 219, 183, 219),
                        ),
                        color: Color.fromARGB(255, 149, 240, 131)),
                    child: MaterialButton(
                      onPressed: () => _handleTap(index),
                      child: Text(
                        board[index],
                        style: const TextStyle(
                            color: Colors.black, fontSize: 50.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          MaterialButton(
            color: Color.fromARGB(195, 231, 157, 114),
            child: const Text(
              "Restart the Game",
            ),
            onPressed: () {
              setState(() {
                _initializeGame();
              });
            },
          ),
        ],
      ),
    );
  }
}
