import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: GuessTheNumberGame(),
  ));
}

class GuessTheNumberGame extends StatefulWidget {
  const GuessTheNumberGame({super.key});

  @override
  _GuessTheNumberGameState createState() => _GuessTheNumberGameState();
}

class _GuessTheNumberGameState extends State<GuessTheNumberGame> {
  late int _targetNumber;
  dynamic _guess;
  int _attempts = 0;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    final random = Random();
    _targetNumber = random.nextInt(100) + 1;
    _guess = null;
    _attempts = 0;
    _message = 'Can you guess the number between 1 and 100!?';
  }

  void _makeGuess() {
    setState(() {
      if (_guess == null) {
        _message = 'Please enter a number.';
      } else {
        _attempts++;
        if (_guess == _targetNumber) {
          _message = 'Congratulations! You guessed it in $_attempts attempts!';
        } else if (_guess < _targetNumber) {
          _message = 'Try a higher number.';
        } else {
          _message = 'Try a lower number.';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess The Number Game By Nacir'),
        backgroundColor: Colors.deepPurple, // Custom background color
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  fontSize: 20,
                  color: _guess == _targetNumber ? Colors.green : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(_message),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _guess = int.tryParse(value);
                        });
                      },
                      style: const TextStyle(color: Colors.black), // Input text color
                      decoration: const InputDecoration(
                        labelText: 'Your guess:',
                        labelStyle: TextStyle(color: Colors.white), // Label text color
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Border color when focused
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _makeGuess,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple, // Button background color
                    ),
                    child: const Text(
                      'Guess',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startNewGame,
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple, // Button background color
                ),
                child: const Text(
                  'New Game',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
