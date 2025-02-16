import 'package:flutter/material.dart';
import 'post_widget.dart'; // Import your PostWidget

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<PostWidget> _posts = [
    PostWidget(imagePath: 'assets/dog.png', description: 'Dog 1'),
    PostWidget(imagePath: 'assets/dog.png', description: 'Dog 2'),
    PostWidget(imagePath: 'assets/dog.png', description: 'Dog 3'),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipeable Cards'),
      ),
      body: Center(
        child: SizedBox(
          height: 400, // Fixed height for the card stack
          width: 300, // Fixed width for the card stack
          child: Stack(
            clipBehavior: Clip.none, // Allow cards to overflow slightly
            children: _posts.map((post) {
              int index = _posts.indexOf(post);
              return Positioned(
                top: index * 10.0, // Slightly offset each card for a stacked effect
                child: Dismissible(
                  key: Key(post.hashCode.toString()), // Unique key for each card
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    setState(() {
                      _posts.removeAt(index); // Remove the card from the list
                    });
                    if (direction == DismissDirection.endToStart) {
                      print("Swiped left on card $index (Dislike)");
                    } else if (direction == DismissDirection.startToEnd) {
                      print("Swiped right on card $index (Like)");
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.thumb_down, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.green,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.thumb_up, color: Colors.white),
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
                                  child: Icon(Icons.error, color: Colors.red),
                                ); // Show an error icon if the image fails to load
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