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
      title: 'Leftover Link',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Leftover Link'),
      routes: {
        //<<<<<<< Updated upstream
        //'/second': (context) => const SwipingPage(sentMessages: sentMessages),
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
                      'isUserMessage':
                          'true', // Set it to 'true' for user messages
                      'imagePath': imagePath,
                      'timestamp':
                          DateTime.now()
                              .toIso8601String(), // Ensure each message has a timestamp
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
          // Center the title
          child: Text(widget.title),
        ),
        actions: <Widget>[
          IconButton(
            // Button in the AppBar
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
          ),
          IconButton(
            // Button in the AppBar
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SwipingPage(sentMessages: sentMessages),
                ),
              );
            },
          ),
          IconButton(
            // Button in the AppBar
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
              const Text(
                'Home Page',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                      const Text(
                        'Your Feed',
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
      ),
    );
  }
}

class InboxPage extends StatelessWidget {
  final List<Map<String, String>> sentMessages;

  const InboxPage({super.key, required this.sentMessages});

  // Method to format the timestamp to "1:32 PM" style
  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat(
      'hh:mm a',
    ).format(dateTime); // Format the timestamp to time format
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: Center(
        child:
            sentMessages.isEmpty
                ? const Text('No messages sent yet.')
                : ListView.builder(
                  itemCount: sentMessages.length,
                  itemBuilder: (context, index) {
                    final message = sentMessages[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text(
                          message['postDescription'] ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['message'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              formatTimestamp(message['timestamp'] ?? ''),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        trailing: CircleAvatar(
                          backgroundImage: AssetImage(
                            message['imagePath'] ?? '',
                          ),
                        ),
                        onTap: () {
                          // Open chat for the selected post
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ChatPage(
                                    postDescription:
                                        message['postDescription'] ?? '',
                                    messages:
                                        sentMessages
                                            .where(
                                              (msg) =>
                                                  msg['postDescription'] ==
                                                  message['postDescription'],
                                            )
                                            .toList(),
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
  TextEditingController _reportController =
      TextEditingController(); // Controller for report reason

  // Method to format the timestamp to "1:32 PM" style
  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat(
      'hh:mm a',
    ).format(dateTime); // Format the timestamp to time format
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        // Append the new message to the correct chat entry
        widget.messages.add({
          'postDescription': widget.postDescription,
          'message': _messageController.text,
          'isUserMessage': 'true',
          'timestamp': DateTime.now().toIso8601String(),
          'imagePath':
              'assets/groceryhaul4.jpeg', // Example image (can be dynamically set)
        });
      });

      _messageController.clear();
    }
  }

  // Show the alert dialog for reporting
  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report this conversation'),
          content: const Text(
            'Are you sure you want to report this conversation?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // After confirming report, show the reason prompt
                Navigator.of(context).pop(); // Close the first dialog
                _showReportReasonDialog(); // Show the reason dialog
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pop(); // Close the dialog without reporting
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show the dialog asking for the report reason
  void _showReportReasonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your report reason'),
          content: TextField(
            controller: _reportController,
            decoration: const InputDecoration(
              hintText: 'Enter reason for report',
            ),
            maxLines: 1, // Allow multiple lines for reason
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle the report submission here, like logging the reason
                String reportReason = _reportController.text;
                if (reportReason.isNotEmpty) {
                  // Perform report action (e.g., save to database, notify admin, etc.)
                  print(
                    'Reported with reason: $reportReason',
                  ); // Example action

                  Navigator.of(context).pop(); // Close the dialog
                  _showConfirmationDialog(); // Show confirmation message
                } else {
                  // Prompt to enter a reason if the field is empty
                  Navigator.of(context).pop();
                  _showErrorDialog();
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pop(); // Close the dialog without submitting
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show confirmation dialog after successful report submission
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Submitted'),
          content: const Text(
            'Thank you for your report. We will review it shortly.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Show error dialog if no reason was entered
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter a reason for the report.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the error dialog
              },
              child: const Text('OK'),
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
        title: Text('Chat: ${widget.postDescription}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.report_problem),
            onPressed: _showReportDialog, // Show the report dialog when pressed
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final message = widget.messages[index];

                bool isUserMessage = message['isUserMessage'] == 'true';

                return Align(
                  alignment:
                      isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: IntrinsicWidth(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12, // Compact padding for a smaller bubble
                      ),
                      decoration: BoxDecoration(
                        color:
                            isUserMessage ? Colors.blue[200] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize
                                .min, // Ensure the row shrinks to fit content
                        children: [
                          // Only show the image (avatar) on the left side if it's not a user message
                          if (!isUserMessage)
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                message['imagePath'] ?? '',
                              ),
                            ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message['message'] ?? '',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatTimestamp(message['timestamp'] ?? ''),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
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
