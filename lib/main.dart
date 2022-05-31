import 'package:flutter/material.dart';
import 'package:flutter_application_2/music.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final player = AudioPlayer();
  //var duration = await player.setUrl('https://foo.com/bar.mp3');

  int _counter = 0;
  bool isAdding = true;
  int indexMusic = 0;
  int indexIcon = 0;
  List<String> playPause = [
    "https://cdn-icons-png.flaticon.com/512/27/27223.png",
    "https://cdn-icons-png.flaticon.com/512/151/151859.png"
  ];
  List<Music> musics = [
    Music(
        "One",
        "Metallica",
        "https://upload.wikimedia.org/wikipedia/en/f/fb/Metallica_-_One_cover.jpg",
        "https://www.youtube.com/watch?v=WM8bTdBs-cw"),
    Music(
        "Fallen Leaves",
        "Billy Talent",
        "https://i.scdn.co/image/ab67616d0000b27351ad1636a7d0456ad972a71c",
        "https://www.youtube.com/watch?v=9BXNKyoW_Ow")
  ];

  void Play() async {
    final player = AudioPlayer();
    var duration = await player.setUrl(musics[indexMusic].urlSong);
    setState(() async {
      if (indexIcon == 0) {
        //var duration = await player.setUrl(musics[indexMusic].urlSong);
        player.play();
        indexIcon = 1;
      } else {
        player.stop();
        indexIcon = 0;
      }
    });
  }

  void Next() {
    setState(() {
      if (indexMusic == musics.length - 1) {
        indexMusic = 0;
      } else {
        indexMusic++;
      }
      indexIcon = 0;
    });
  }

  void Previous() {
    setState(() {
      if (indexMusic > 0) {
        indexMusic--;
      } else {
        indexMusic = musics.length - 1;
      }
      indexIcon = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Image(
                image: NetworkImage(musics[indexMusic].imagePath),
                height: 300,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                musics[indexMusic].title,
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  musics[indexMusic].singer,
                  style: TextStyle(fontSize: 25),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: Previous,
                    child: const Image(
                      image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/2/2147.png'),
                      height: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: Play,
                    child: Image(
                      image: NetworkImage(playPause[indexIcon]),
                      height: 50,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: InkWell(
                        onTap: Next,
                        child: const Image(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/1/1371.png'),
                          height: 50,
                        ))),
              ],
            )
            // InkWell(
            //   onTap: Previous,
            //   child: const Image(
            //     image: NetworkImage(
            //         'https://cdn-icons-png.flaticon.com/512/2/2147.png'),
            //     height: 50,
            //   ),
            // ),
            // InkWell(
            //   onTap: Play,
            //   child: const Image(
            //     image: NetworkImage(
            //         'https://cdn-icons-png.flaticon.com/512/27/27223.png'),
            //     height: 50,
            //   ),
            // )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.remove_circle),
      //       label: 'Less',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_circle),
      //       label: 'More',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
