import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  Future<void> _runPostPhp() async {
    final response = await http.post(
      Uri.parse('127.0.0.1:8000/post.php'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      print('Request successful');
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is the second page'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: const Text('Go Back'),
            ),
            ElevatedButton(
              onPressed: _runPostPhp,
              child: const Text('Run post.php'),
            ),
          ],
        ),
      ),
    );
  }
}