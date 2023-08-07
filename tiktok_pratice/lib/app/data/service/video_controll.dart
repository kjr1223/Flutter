import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:tiktok_practice/app/data/model/video.dart';
import 'package:tiktok_practice/app/data/service/post_service.dart';
import 'package:video_player/video_player.dart';

class ViedeoControll with ChangeNotifier {
  VideoPlayerController? controller;
  int videoBefore = 0;
  int currentScreen = 0;
  List