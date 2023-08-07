import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(PomodoroApp());

class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PomodoroTimerScreen(),
    );
  }
}

class PomodoroTimerScreen extends StatefulWidget {
  @override
  _PomodoroTimerScreenState createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  final int totalCycles = 4; // 총 사이클 수
  final int workMinutes = 25; // 작업 시간
  final int shortBreakMinutes = 5; // 짧은 휴식 시간
  final int longBreakMinutes = 15; // 긴 휴식 시간

  int currentCycle = 1; 
  bool isWorking = true; // 작업, 휴식 세션 표시.true는 작업, false는 휴식
  Timer? _timer; // 타이머 제어
  int _secondsRemaining = 0; // 남은 시간 표시. 초 단위

  void startTimer() { // 타이머 시작
    setState(() { // 1초마다 secondsRemaining 값 감소. 0이 되면 타이머 취소하고 nextCycle 호출하여 다음 사이클로 이동
      isWorking = true;
      _secondsRemaining = workMinutes * 60;
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          if (_secondsRemaining > 0) { 
            _secondsRemaining--;
          } else {
            timer.cancel();
            _nextCycle();
          }
        });
      });
    });
  }

  void _nextCycle() {
    setState(() {
      if (currentCycle < totalCycles) {
        currentCycle++;
        if (currentCycle == totalCycles) {
          _startBreakTimer(longBreakMinutes); // 마지막 사이클이면 긴 휴식 시작
        } else {
          _startBreakTimer(shortBreakMinutes);
        }
      } else {
        currentCycle = 1; // 다시 첫 번째 사이클로 돌아감
        isWorking = true; // 작업 세션 다시 시작
      }
    });
  }

  void _startBreakTimer(int breakMinutes) {
    setState(() {
      isWorking = false;
      _secondsRemaining = breakMinutes * 60;
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            timer.cancel();
            _nextCycle();
          }
        });
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
        title: Text('Pomodoro Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isWorking ? 'Work Cycle $currentCycle' : 'Break Time',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            Text(
              _formatTime(_secondsRemaining),
              style: TextStyle(fontSize: 64),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: Text(
                isWorking ? 'Start Work' : 'Start Break',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
