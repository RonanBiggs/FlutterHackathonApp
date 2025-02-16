import 'package:flutter/material.dart';
import 'swipeposts_widget.dart'; // Import your PostWidget
import 'main.dart'; // Import InboxPage to manage chat entries

class SwipingPage extends StatefulWidget {
  final List<Map<String, String>> sentMessages;

  const SwipingPage({super.key, required this.sentMessages});

  @override
  State<SwipingPage> createState() => _SwipingPageState();
}

class _SwipingPageState extends State<SwipingPage> {
  List<SwipePostWidget> _posts = [
    SwipePostWidget(
      imagePath: 'groceries1.jpeg',
      description: 'Meet me at PCV',
    ),
    SwipePostWidget(
      imagePath: 'groceries2.jpg',
      description: 'Anyone want these?',
    ),
    SwipePostWidget(
      imagePath: 'groceries3.jpg',
      description: 'Free Leftovers!!',
    ),
  ];

  void _promptMessage(String postDescription) {
    String message = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Send a Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your message for the post owner:'),
              TextField(
                onChanged: (text) {
                  message = text;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your message',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (message.isNotEmpty) {
                  setState(() {
                    // Check if a chat already exists for this post
                    var existingChat = widget.sentMessages.firstWhere(
                      (chat) => chat['postDescription'] == postDescription,
                      orElse: () => {},
                    );

                    if (existingChat.isNotEmpty) {
                      // Append the new message to the existing chat
                      existingChat['message'] =
                          '${existingChat['message']}\n$message';
                    } else {
                      // Create a new chat entry
                      widget.sentMessages.add({
                        'postDescription': postDescription,
                        'message': message,
                        'isUserMessage': 'true',
                        'timestamp': DateTime.now().toIso8601String(),
                      });
                    }
                  });

                  Navigator.of(context).pop(); // Close message input
                  Navigator.of(context).pop(); // Close SwipingPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              InboxPage(sentMessages: widget.sentMessages),
                    ),
                  );
                }
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
      appBar: AppBar(title: const Text('Swipeable Cards')),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 300,
          child: Stack(
            clipBehavior: Clip.none,
            children:
                _posts.map((post) {
                  int index = _posts.indexOf(post);
                  return Positioned(
                    top: index * 10.0,
                    child: Dismissible(
                      key: Key(post.hashCode.toString()),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        setState(() {
                          _posts.removeAt(index);
                        });
                        if (direction == DismissDirection.startToEnd) {
                          print("Swiped right on card $index (Like)");
                          _promptMessage(post.description);
                        } else if (direction == DismissDirection.endToStart) {
                          print("Swiped left on card $index (Dislike)");
                        }
                      },
                      background: Container(
                        color: Colors.green,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.thumb_up, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(
                          Icons.thumb_down,
                          color: Colors.white,
                        ),
                      ),
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: 400,
                          width: 300,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  post.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  post.description,
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
