import 'package:flutter/material.dart';
import 'package:music_plaayer/functions/box.dart';
import 'package:music_plaayer/functions/drawer.dart';
import 'package:music_plaayer/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // conver the duration into min:sec

  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // get playlist
        final playlist = value.playlist;

        // get current song
        final currentsong = playlist[value.currentSongIndex ?? 0];

        //return UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.all(70),
              child: Text("V I B E   O N"),
            ),
          ),
          endDrawer: const MyDrawer(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(
                    child: Column(
                      children: [
                        //image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentsong.albumImagePath),
                        ),

                        // song , artist name and icon
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // song and artist name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentsong.songName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentsong.artistName),
                                ],
                              ),

                              // heart icon
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  //song duration progress

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //start timer

                            Text(formatTime(value.currentDuration)),

                            //shuffle icon

                            const Icon(Icons.shuffle),

                            //repeat icon

                            const Icon(Icons.repeat),
                            //end time
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 0)),
                    child: Slider(
                      min: 0,
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.currentDuration.inSeconds.toDouble(),
                      activeColor: Colors.green,
                      onChanged: (double double) {
                        // when user is dragging the slider
                      },
                      onChangeEnd: (double double) {
                        // slider has finished. go to that position
                        value.seek(Duration(seconds: double.toInt()));
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  //playback controls
                  Row(
                    children: [
                      //skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: const Box(
                              child: Icon(
                            Icons.skip_previous,
                          )),
                        ),
                      ),
                      const SizedBox(width: 20),

                      //play/Pause

                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: Box(
                            child: Icon(value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                          ),
                        ),
                      ),

                      const SizedBox(width: 25),

                      //skip forward

                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const Box(
                              child: Icon(
                            Icons.skip_next,
                          )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
