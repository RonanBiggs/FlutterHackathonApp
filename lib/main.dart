import 'package:flutter/material.dart';
import 'post_widget.dart';
import 'example_page.dart';
import '../ios/add_posts.dart';
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
        '/second': (context) => const SecondPage(),
        '/create': (context) => const AddPostPage(),
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

  bool isLoggedIn = false;

  void _loginSuccess() {
    setState(() {
      isLoggedIn = true;
    });
  }

  void _logout() {
    setState(() {
      isLoggedIn = false;
    });
  }

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
          IconButton( // Button in the AppBar
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
          ),
          IconButton(
            icon: Icon(isLoggedIn ? Icons.verified_user_rounded : Icons.person),
            onPressed: () {
              if (isLoggedIn) {
                _logout();
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      onLoginSuccess: _loginSuccess, // Pass callback for login success
                    ),
                  ),
                );
              }
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

class LoginPage extends StatefulWidget {
  final Function onLoginSuccess;
  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String validEmail = 'user@examplemail.com';
  final String validPassword = 'abc123';
  String errorMessage = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_emailController.text == validEmail &&
        _passwordController.text == validPassword) {
      widget.onLoginSuccess();
      Navigator.of(context).pop();
    } else {
      setState(() {
        errorMessage = 'Invalid email address or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email:',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password:',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _login, child: const Text('Submit')),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}