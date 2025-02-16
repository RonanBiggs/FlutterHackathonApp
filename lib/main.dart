import 'package:flutter/material.dart';
import 'package:hackathon/swipingpage.dart';
import 'post_widget.dart';
//<<<<<<< Updated upstream
import 'package:intl/intl.dart';
import 'add_posts.dart';
import 'map_page.dart';
//=======
//import 'example_page.dart';
//import 'add_posts.dart';
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
        '/map': (context) => const MapPage(),
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
    bool isLoggedIn = false;
  List<Map<String, String>> sentMessages = [];

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
 // int _counter = 0;

 /* void _incrementCounter() {
    setState(() {
     _counter++;
    });
  }
  */
  void _sendMessage(String postDescription, String imagePath) {
  String message = '';
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Send a Message'),
        content: TextField(
          onChanged: (text) {
            message = text;
          },
          decoration: const InputDecoration(hintText: 'Enter your message'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (message.isNotEmpty) {
                setState(() {
                  // Add the message to the list with its post description, image path, and timestamp
                  sentMessages.add({
                    'postDescription': postDescription,
                    'message': message,
                    'isUserMessage': 'true',  // Set it to 'true' for user messages
                    'imagePath': imagePath,
                    'timestamp': DateTime.now().toIso8601String(),  // Ensure each message has a timestamp
                  });
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('Send'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
               leading: IconButton(
          icon: const Icon(Icons.inbox),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => InboxPage(
                      sentMessages: sentMessages,
                    ), // Pass the sentMessages list to the InboxPage
              ),
            );
          },
        ),
        title: Text(widget.title),
actions: <Widget>[

          IconButton( // Button in the AppBar
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
          ),
          IconButton( // Button in the AppBar
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
          ),
          IconButton( // Button in the AppBar
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.pushNamed(context, '/map');
            },
          ),

          IconButton(
            icon: Icon(isLoggedIn ? Icons.verified_user_rounded : Icons.person),
            onPressed: () {
              if (isLoggedIn) {
                _logout();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => LoginPage(
                          onLoginSuccess:
                              _loginSuccess, // Pass callback for login success
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
            const Text('Home Page',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            
             child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Your Feed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
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
                  onMessage: _sendMessage,
                  ),
                PostWidget(
                  imagePath: 'assets/groceryhaul5.jpg',
                  description: 'extra food!',
                  onMessage: _sendMessage,
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul6.webp',
                  description: 'leftover groceries',
                  onMessage: _sendMessage,
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul7.jpg',
                  description: 'some extra groceries!',
                  onMessage: _sendMessage,
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul8.jpg',
                  description: 'more extra groceries',
                  onMessage: _sendMessage,
                ),
                PostWidget(
                  imagePath: 'assets/groceryhaul9.jpg',
                  description: 'some more groceries',
                  onMessage: _sendMessage,
                ),
                PostWidget(
                  imagePath: 'assets/grocery10.jpg',
                  description: 'extra food for anyone who needs!',
                  onMessage: _sendMessage,
                ),
              ],
            ),
            ),
          ],

            
        ),
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

class InboxPage extends StatelessWidget {
  final List<Map<String, String>> sentMessages;

  const InboxPage({super.key, required this.sentMessages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: Center(
        child: sentMessages.isEmpty
            ? const Text('No messages sent yet.')
            : ListView.builder(
                itemCount: sentMessages.length,
                itemBuilder: (context, index) {
                  final message = sentMessages[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        message['postDescription'] ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        message['message'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                      trailing: CircleAvatar(
                        radius: 24, // Set the size of the circle
                        backgroundImage: AssetImage(message['imagePath'] ?? 'assets/default.png'), // Use imagePath from message
                      ),
                      onTap: () {
                        // Navigate to the ChatPage when tapping on the card
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              postDescription: message['postDescription'] ?? '',
                              messages: sentMessages.where((msg) => msg['postDescription'] == message['postDescription']).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
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
                decoration: InputDecoration(labelText: 'Email:'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password:'),
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



class ChatPage extends StatefulWidget {
  final String postDescription;
  final List<Map<String, String>> messages;

  const ChatPage({
    super.key,
    required this.postDescription,
    required this.messages,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        widget.messages.add({
          'postDescription': widget.postDescription,
          'message': _messageController.text,
          'isUserMessage': 'true',
          'timestamp': DateTime.now().toIso8601String(), // Add timestamp here
        });
      });
      _messageController.clear();
    }
  }

  // Function to calculate time passed
  String _formatTimeAgo(String timestamp) {
    try {
      final sentTime = DateTime.parse(timestamp);  // This should always succeed if the timestamp is correct
      final formattedTime = DateFormat('h:mm a').format(sentTime);
      return formattedTime;
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid time";  // Fallback in case of an invalid timestamp
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat: ${widget.postDescription}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final message = widget.messages[index];

                bool isUserMessage = message['isUserMessage'] == 'true';
                String timestamp = message['timestamp'] ?? '';

                // Place the Align widget here
                return Align(
                  alignment:
                      isUserMessage
                          ? Alignment.centerRight  // Align to the right for user messages
                          : Alignment.centerLeft,  // Align to the left for other messages
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          isUserMessage
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['message'] ?? '',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4), // Space between message and time
                        Text(
                          _formatTimeAgo(timestamp), // Display the time passed
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}