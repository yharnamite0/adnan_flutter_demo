import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لعبة التخمين',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const GuessingGame(),
    );
  }
}

class GuessingGame extends StatefulWidget {
  const GuessingGame({super.key});

  @override
  State<GuessingGame> createState() => _GuessingGameState();
}

class _GuessingGameState extends State<GuessingGame> {
  final TextEditingController _controller = TextEditingController();
  final int _maxTries = 8;
  late int _targetNumber;
  int _tries = 0;
  String _message = 'مرحبًا بك في تطبيق عدنان! خمن رقمًا من 1 إلى 20';
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _targetNumber = Random().nextInt(20) + 1;
  }

  void _checkGuess() {
    if (_gameOver) return;

    final guess = int.tryParse(_controller.text);
    if (guess == null || guess < 1 || guess > 20) {
      setState(() {
        _message = 'من فضلك أدخل رقمًا بين 1 و 20';
      });
      return;
    }

    setState(() {
      _tries++;
      if (guess == _targetNumber) {
        _message = 'رائع! لقد خمنت الرقم الصحيح 🎉';
        _gameOver = true;
      } else if (_tries >= _maxTries) {
        _message = 'لقد انتهت المحاولات! الرقم كان $_targetNumber 😢';
        _gameOver = true;
      } else if (guess < _targetNumber) {
        _message = 'حاول برقم أكبر. المحاولة $_tries من $_maxTries';
      } else {
        _message = 'حاول برقم أصغر. المحاولة $_tries من $_maxTries';
      }
    });
  }

  void _resetGame() {
    setState(() {
      _targetNumber = Random().nextInt(20) + 1;
      _tries = 0;
      _controller.clear();
      _message = 'مرحبًا بك في تطبيق عدنان! خمن رقمًا من 1 إلى 20';
      _gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 لعبة التخمين'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'أدخل رقمك',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !_gameOver,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _checkGuess,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                  ),
                  child: const Text('تحقق'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_gameOver)
              ElevatedButton(
                onPressed: _resetGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text('ابدأ من جديد'),
              ),
          ],
        ),
      ),
    );
  }
}
