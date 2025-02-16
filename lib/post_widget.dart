import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String imagePath;
  final String description;
 final void Function(String, String) onMessage; 
  const PostWidget({
    Key? key,
    required this.imagePath,
    required this.description,
    required this.onMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            imagePath,
            fit: BoxFit.cover, // Or BoxFit.contain, BoxFit.fill, etc. as needed
            width: MediaQuery.of(context).size.width/2, // Path to your local image
            height: 800,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 60),
          ),
          ElevatedButton(
          onPressed: () {
            // Pass both description and imagePath to onMessage
            onMessage(description, imagePath); // Pass imagePath along with description
          },
          child: const Text('Message'),
        ),
        const SizedBox(height: 16),
        ],
      ),
    );
  }
}