import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Adivinhação'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(level: 1)),
                );
              },
              child: Text('Nível 1', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                // onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ).copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(level: 2)),
                );
              },
              child: Text('Nível 2', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                // onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ).copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int level;

  GameScreen({required this.level});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int _randomNumber;
  int _attempts = 0;
  late int _maxAttempts;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _randomNumber = Random().nextInt(100) + 1;
    _maxAttempts = widget.level == 1 ? 10 : 5;
  }

  void _checkNumber() {
    int? number = int.tryParse(_controller.text);
    if (number != null) {
      setState(() {
        _attempts++;
        if (number == _randomNumber) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WinScreen(attempts: _attempts)),
          );
        } else if (_attempts >= _maxAttempts) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoseScreen(randomNumber: _randomNumber)),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira um número válido.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nível ${widget.level}'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tente adivinhar o número entre 1 e 100.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Tentativas restantes: ${_maxAttempts - _attempts}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Insira o número',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkNumber,
              child: Text('Verificar', style: TextStyle(fontSize: 18)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WinScreen extends StatelessWidget {
  final int attempts;

  WinScreen({required this.attempts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Você Ganhou!'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Parabéns! Você adivinhou o número em $attempts tentativas.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Jogar Novamente', style: TextStyle(fontSize: 18)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoseScreen extends StatelessWidget {
  final int randomNumber;

  LoseScreen({required this.randomNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Você Perdeu!'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Que pena! O número correto era $randomNumber.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Jogar Novamente', style: TextStyle(fontSize: 18)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
