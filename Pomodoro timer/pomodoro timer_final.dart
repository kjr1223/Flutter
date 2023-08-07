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
  final int totalCycles = 4; // 총 사이클 수
  final int workMinutes = 25; // 작업 시간
  final int shortBreakMinutes = 5; // 짧은 휴식 시간
  final int longBreakMinutes = 15; // 긴 휴식 시간

  int currentCycle = 1; // 현재 사이클 번호
  bool isWorking = true; // 현재 작업 중인지 여부
  Timer? _timer; // 타이머 
  int _secondsRemaining = 0;// 남은 시간

  bool isTimerRunning = false; // 타이머가 현재 실행 중인지 여부
  bool isPaused = false; // 타이머가 일시 정지 상태인지 

  void startTimer() {
    setState(() {
      if (isPaused) { // 일시 정지 상태에서 시작
        isTimerRunning = true;
        isPaused = false;
      } else { // 새로운 사이클 시작
        isTimerRunning = true;
        isWorking = true;
        _secondsRemaining = workMinutes * 60;
      }
      _startTimer();
    });
  }

  void stopTimer() {
    setState(() { // 타이머를 중지하고 사이클 초기화
      isTimerRunning = false;
      isPaused = true;
      _timer?.cancel();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) { // 남은 시간이 있는 경우
          _secondsRemaining--;
        } else { // 남은 시간이 없는 경우 다음 사이크로 이동
          _timer?.cancel();
          _nextCycle();
        }
      });
    });
  }

  void _resetCycle() {
    setState(() { // 사이클 초기화
      currentCycle = 1;
      isWorking = true;
      _secondsRemaining = workMinutes * 60;
    });
  }

  void _nextCycle() { // 다음 사이클로 이동
    setState(() {
      currentCycle++;
      if (currentCycle > totalCycles * 2) { // 모든 사이클을 완료한 경우 초기 사이클로 돌아감
        currentCycle = 1;
      }
      isWorking = currentCycle % 2 == 1;
      int breakNumber = (currentCycle ~/ 2) - 1;
      _secondsRemaining = isWorking
          ? workMinutes * 60
          : (breakNumber == totalCycles - 1
                  ? longBreakMinutes
                  : shortBreakMinutes) *
              60;
      _startTimer();
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _nextCycle,
                  child: Icon(Icons.arrow_forward),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (isTimerRunning) {
                      stopTimer();
                    } else {
                      startTimer();
                    }
                  },
                  child: Icon(isTimerRunning ? Icons.pause : Icons.play_arrow),
                ),
                FloatingActionButton(
                  onPressed: _resetCycle,
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
