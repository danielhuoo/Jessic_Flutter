import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

abstract class MusicServiceModel extends ChangeNotifier {
  void playSong() {}
  void resume() {}
  void pause() {}
  void prev() {}
  void next() {}
  void init(data) {}

  get songInfo;
  AudioPlayerState get audioPlayerState;
  bool get showPlayBtn;
  double get progressValue;
  String get durationText;
  String get positionText;
}

class MusicServiceImplementation extends MusicServiceModel {
  var _songInfo;
  Duration _audioPlayerDuration;
  Duration _audioPlayerPosition;
  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  bool _showPlayBtn = true;
  double _progressValue = 0.0;
  String _durationText = '';
  String _positionText = '';
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _completeSubscription;

  @override
  AudioPlayerState get audioPlayerState => _audioPlayerState;

  @override
  String get durationText => _durationText;

  @override
  String get positionText => _positionText;

  @override
  double get progressValue => _progressValue;

  @override
  bool get showPlayBtn => _showPlayBtn;

  @override
  get songInfo => _songInfo;

  @override
  void playSong() {
    if (audioPlayerState != AudioPlayerState.PLAYING) {
      resume();
    } else {
      pause();
    }
  }

  @override
  void resume() async {
    int result = await _audioPlayer.resume();
    if (result == 1) {
      print('play');
      _showPlayBtn = false;
      notifyListeners();
    }
  }

  @override
  void pause() async {
    int result = await _audioPlayer.pause();
    if (result == 1) {
      print('pause');
      _showPlayBtn = true;
      notifyListeners();
    }
  }

  @override
  void prev() {
    print('prev');
  }

  @override
  void next() {
    print('next');
  }

  void _onComplete() {
    //state会变为 AudioPlayerState.COMPLETED
    _showPlayBtn = true;
    notifyListeners();
    // setState(() {
    //   audioPlayerState =
    // });
  }

  // release() async {
  //   print('release');
  //   await audioPlayer.release();
  // }

  void _dispose() {
    _audioPlayer.stop();
    _durationSubscription.cancel();
    _positionSubscription.cancel();
    _completeSubscription.cancel();
  }

  @override
  void init(data) {
    if (_songInfo == null) {
      print('第一次播放');
      _initPlayerState(data);
    } else if (data['id'] != _songInfo['id']) {
      print('换歌了');
      _dispose();
      _initPlayerState(data);
    } else {
      print('相同的歌');
    }
  }

  void _initPlayerState(data) async {
    _songInfo = data;
    //init durationText & positionText to 0:00:00
    Duration zeroDuration = Duration(hours: 0, minutes: 0, seconds: 0);
    _positionText = _durationText =
        zeroDuration?.toString()?.split('.')?.first?.substring(2);

    //create the instance of audioplayer
    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      _audioPlayerState = s;
      notifyListeners();
    });

    _durationSubscription = _audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration================= $d');
      _audioPlayerDuration = d;
      _durationText = d?.toString()?.split('.')?.first?.substring(2) ?? '';
      notifyListeners();
    });

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      _audioPlayerPosition = p;
      _positionText = p?.toString()?.split('.')?.first?.substring(2) ?? '';
      try {
        _progressValue =
            _audioPlayerPosition.inSeconds / _audioPlayerDuration.inSeconds;
      } catch (e) {}

      notifyListeners();
    });

    _completeSubscription = _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      next();
    });

    String url =
        'https://music.163.com/song/media/outer/url?id=${songInfo['id']}.mp3';
    // String url = 'https://music.163.com/song/media/outer/url?id=158655.mp3';
    int result = await _audioPlayer.setUrl(url);
    if (result == 1) {
      playSong();
    }
  }
}
