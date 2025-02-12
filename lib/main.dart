//Made by Skyler Plumley and Shawn
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Valentine's Day",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Valentine's Day"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool beating = false;
  String themessage = "";
  Timer? _timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 1, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void startbeat() {
    setState(() {
      if (beating) {
        _controller.stop();
        _timer?.cancel();
      } else {
        seconds = 0;
        _controller.repeat(reverse: true);
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            seconds++;
          });
        });
      }

      beating = !beating;
    });
  }

  void sendmessage(String message) {
    setState(() {
      themessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => sendmessage("You are my valentine!"),
                    child: const Text("Message 1")),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => sendmessage("XOXO!"),
                    child: const Text("Message 2")),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
              child: Image.asset('assets/heartnew.png'),
            ),
            const SizedBox(height: 20),
            Text(
              'Timer: $seconds',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startbeat,
              child: Text(beating ? 'Stop' : 'Start'),
            ),
            Text(
              themessage,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
