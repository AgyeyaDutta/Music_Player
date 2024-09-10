import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'songs.dart';

class PlaylistProvider extends ChangeNotifier {
  // playlist of songs

  final List<Song> _playlist = [
    // song 1
    Song(
      songName: "Until I found You",
      artistName: "Stephen Sanchez",
      albumImagePath: "assets/images/until.png",
      audioPath: "audio/until.mp3",
    ),

    // song 2
    Song(
      songName: "Out",
      artistName: "Twenty One Pilots",
      albumImagePath: "assets/images/out.png",
      audioPath: "audio/out.mp3",
    ),

    // song 3
    Song(
      songName: "Psycho",
      artistName: "Post Malone",
      albumImagePath: "assets/images/psycho.png",
      audioPath: "audio/psycho.mp3",
    ),

    // song 4
    Song(
      songName: "Reminder",
      artistName: "The Weekend",
      albumImagePath: "assets/images/reminder.png",
      audioPath: "audio/reminder.mp3",
    )
  ];

// current song

  int? _currentSongIndex;

//// A U D I O   P L A Y E R

// audio player

  final AudioPlayer _audioPlayer = AudioPlayer();

//duration

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

//constructor

  PlaylistProvider() {
    listenToDuration();
  }

// initially not playing
  bool _isPlaying = false;

// play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    // await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

// pause the song

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

// resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

// pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

// seek  to specific timestamp
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

//play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // go to next song if not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if last song go to the 1st song
        currentSongIndex = 0;
      }
    }
  }

// play previous song
  void playPreviousSong() async {
    // if more than 5sec has passed, restart the current song

    if (_currentDuration.inSeconds > 5) {
      seek(Duration.zero);
    }

    // if it is less than 5 sec, go to previous song
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // if its the 1st song, go to the last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

//// LISTEN TO DURATION

  void listenToDuration() {
//totAL Duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

// current Duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

// song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

//// dispose the audio player

// Getters

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // setter
  set currentSongIndex(int? newIndex) {
//update current osng index

    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(); //play the index song
    }

//update UI

    notifyListeners();
  }
}
