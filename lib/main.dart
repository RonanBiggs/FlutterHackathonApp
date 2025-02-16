import 'package:flutter/material.dart';
import 'post_widget.dart';
import 'example_page.dart';
import 'additional_page.dart';


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
        '/second': (context) => const AdditionalPage(),
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
          IconButton(
            
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pushNamed(context, '/second'); // Navigate to the second page
            },

          ),

        ],
        
      ),
      body: Center(

        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('posts:'),
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
                  imagePath: 'assets/groceryhaul4.jpeg',
                  description: 'groceries in SLO',
                  ),
                PostWidget(
                  imagePath: 'assets/groceryhaul5.jpg',
                  description: 'extra food!',
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul6.webp',
                  description: 'leftover groceries',
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul7.jpeg',
                  description: 'some extra groceries!',
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul8.jpeg',
                  description: 'more extra groceries',
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul9.jpeg',
                  description: 'some more groceries',
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul10.jpeg',
                  description: 'extra food for anyone who needs!',
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
