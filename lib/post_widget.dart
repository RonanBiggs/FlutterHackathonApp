import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String imagePath;
  final String description;

  const PostWidget({super.key, required this.imagePath, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        height: 400,
        width: 300,
        child: InkWell( // Added InkWell for tap functionality (optional)
          onTap: () {
            // Handle tap if needed
            print("Tapped on: $description");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch text to card width
            children: [
              Expanded(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, object, stackTrace) {
                    // Handle image loading errors
                    return const Center(child: Icon(Icons.error)); // Or a placeholder
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center, // Center the text
                  maxLines: 2, // Limit to two lines
                  overflow: TextOverflow.ellipsis, // Add ellipsis if it overflows
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}