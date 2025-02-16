import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String imagePath;
  final String description;

  const PostWidget({
    Key? key,
    required this.imagePath,
    required this.description,
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
        ],
      ),
    );
  }
}