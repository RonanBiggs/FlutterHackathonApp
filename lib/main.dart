import 'package:flutter/material.dart';
import 'post_widget.dart';
import 'example_page.dart';
import '../add_posts.dart';
import 'package:intl/intl.dart';

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
        title: Center(
          // Center the title in the AppBar
          child: Text(widget.title),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/second',
              ); // Navigate to the second page
            },
          ),
          IconButton(
            // Button in the AppBar
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
                      description: 'An Evil Dog',
                      onMessage: _sendMessage,
                    ),
                    PostWidget(
                      imagePath: 'assets/dog.png',
                      description: 'this is the same dog',
                      onMessage: _sendMessage,
                    ),
                    PostWidget(
                      imagePath: 'assets/dog.png',
                      description: 'this is the same dog',
                      onMessage: _sendMessage,
                    ),
                    PostWidget(
                      imagePath: 'assets/dog.png',
                      description: 'this is the same dog',
                      onMessage: _sendMessage,
                    ),
                    PostWidget(
                      imagePath: 'assets/dog.png',
                      description: 'this is the same dog',
                      onMessage: _sendMessage,
                    ),
                    PostWidget(
                      imagePath: 'assets/dog.png',
                      description: 'this is the same dog',
                      onMessage: _sendMessage,
                    ),
                    PostWidget(
                      imagePath: 'assets/dog.png',
                      description: 'this is the same dog',
                      onMessage: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

class PostWidget extends StatelessWidget {
  final String imagePath;
  final String description;
  final void Function(String, String) onMessage; // Update to accept imagePath

  const PostWidget({
    super.key,
    required this.imagePath,
    required this.description,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath),
        Text(description),
        ElevatedButton(
          onPressed: () {
            // Pass both description and imagePath to onMessage
            onMessage(description, imagePath); // Pass imagePath along with description
          },
          child: const Text('Message'),
        ),
        const SizedBox(height: 16),
      ],
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

