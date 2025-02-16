import 'package:flutter/material.dart';
import 'package:hackathon/swipingpage.dart';
import 'post_widget.dart';
//<<<<<<< Updated upstream
import 'add_posts.dart';
//=======
import 'example_page.dart';
import 'add_posts.dart';
//>>>>>>> Stashed changes
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Name',
      theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'App Name'),
      routes: {
//<<<<<<< Updated upstream
        '/second': (context) => const SwipingPage(),
      //  '/create': (context) => const AddPostPage(),
      //'/second': (context) => const SwipingPage(),
//=======
      //  '/second': (context) => const SecondPage(),
        '/create': (context) => const AddPostPage(),
//>>>>>>> Stashed changes
      },
            debugShowCheckedModeBanner: false, // Remove the debug banner



    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // int _counter = 0;

 /* void _incrementCounter() {
    setState(() {
     _counter++;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
actions: <Widget>[

          IconButton( // Button in the AppBar
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
          ),

        ],
        
      ),
      body: Center(

        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Feed'),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            
            child: Column(
              children: <Widget>[
                PostWidget(
                  imagePath: 'assets/dog.png',
                  description: 'a nice dog',
                  ),
                PostWidget(
                  imagePath: 'assets/dog.png',
                  description: 'this is the same dog',
                ),
                PostWidget(
                  imagePath: 'assets/dog.png',
                  description: 'this is the same dog',
                ),
                PostWidget(
                  imagePath: 'assets/dog.png',
                  description: 'this is the same dog',
                ),
                PostWidget(
                  imagePath: 'assets/dog.png',
                  description: 'this is the same dog',
                ),
                PostWidget(
                  imagePath: 'assets/dog.png',
                  description: 'this is the same dog',
                ),
                PostWidget(
                  imagePath: 'assets/dog.png',
                  description: 'this is the same dog',
                ),
              ],
            ),
            
        ),
        ],
        ),
        ),
      

    

 /*       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),*/
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}