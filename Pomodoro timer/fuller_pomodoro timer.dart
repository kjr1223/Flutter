import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(PomodoroApp());

class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: PomodoroTimerScreen(),
    );
  }
}

class PomodoroTimerScreen extends StatefulWidget {
  @override
  _PomodoroTimerScreenState createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  final int totalCycles = 4; 
  final int workMinutes = 25; 
  final int shortBreakMinutes = 5;
  final int longBreakMinutes = 15; 

  int currentCycle = 1;
  bool isWorking = true; 
  Timer? _timer; 
  int _secondsRemaining = 0; 

  bool isTimerRunning = false; // 타이머가 현재 실행 중인지 아닌지
  bool isPaused = false; // 타이머가 일시 정지된 상태

  void startTimer() {
    setState(() {
      if (isPaused) {
        
        isTimerRunning = true;
        isPaused = false;
        _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
          _updateTimer();
        });
      } else {
        
        isTimerRunning = true;
        isWorking = true;
        _secondsRemaining = workMinutes * 60;
        _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
          _updateTimer();
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      isTimerRunning = false;
      isPaused = true; 
      _timer?.cancel();
    });
  }

  void _updateTimer() {
    setState(() {
      if (_secondsRemaining > 0) { 
        _secondsRemaining--;
      } else {
        _timer?.cancel(); // 타이머 중지
        _nextCycle();
      }
    });
  }

void _nextCycle() {
  setState(() {
    currentCycle++;

    if (currentCycle > totalCycles * 2) {
      currentCycle = 1;
    }

    if (currentCycle % 2 == 1) {
      // 홀수 번째 사이클인 경우 (Work Cycle)
      isWorking = true;
      int cycleNumber = (currentCycle + 1) ~/ 2;
      _secondsRemaining = workMinutes * 60;
    } else {
      // 짝수 번째 사이클인 경우 (Break Time)
      isWorking = false;
      int breakNumber = (currentCycle ~/ 2) - 1;
      if (breakNumber == totalCycles - 1) {
        // 마지막 사이클인 경우 (긴 휴식)
        _secondsRemaining = longBreakMinutes * 60;
      } else {
        // 짝수 번째 사이클이지만 마지막 사이클이 아닌 경우 (짧은 휴식)
        _secondsRemaining = shortBreakMinutes * 60;
      }
    }

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _updateTimer();
    });
  });
}





  void _startBreakTimer(int breakMinutes) {
    setState(() {
      isWorking = false;
      _secondsRemaining = breakMinutes * 60;
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        _updateTimer();
      });
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor().toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isWorking ? 'Work Cycle $currentCycle' : 'Break Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isWorking ? 'Work Cycle $currentCycle' : 'Break Time',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              _formatTime(_secondsRemaining),
              style: TextStyle(fontSize: 64),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                if (isTimerRunning) {
                  stopTimer();
                } else {
                  startTimer();
                }
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              child: Text(
                isTimerRunning ? 'Stop' : (isPaused ? 'ReStart' : 'Start Work'),
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: _nextCycle,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Next Cycle',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
