import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String imagePath;
  final String description;

  const PostWidget({
    super.key,
    required this.imagePath,
    required this.description,
  });

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
            imagePath, // Path to your local image
            width: MediaQuery.of(context).size.width/2,
            height: 100,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}