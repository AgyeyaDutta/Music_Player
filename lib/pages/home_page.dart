// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_plaayer/functions/drawer.dart';
import 'package:music_plaayer/models/playlist_provider.dart';
import 'package:music_plaayer/models/songs.dart';
import 'package:music_plaayer/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the playlist provider

  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();

    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

// go to the Song
  void goToSong(int songIndex) {
// update current index
    playlistProvider.currentSongIndex = songIndex;

    // navigate to song page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text("P L A Y L I S T"),
        ),
        drawer: const MyDrawer(),
        body: Consumer<PlaylistProvider>(builder: (context, value, child) {
          //get the playlist

          final List<Song> playlist = value.playlist;

          // return lisrt view UI
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // get individual song
              final Song song = playlist[index];

              // return list title ui

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumImagePath),
                onTap: () => goToSong(index),
              );
            },
          );
        }));
  }
}
