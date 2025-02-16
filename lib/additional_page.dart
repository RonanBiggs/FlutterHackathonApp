import 'package:flutter/material.dart';
import 'map_page.dart';

class AdditionalPage extends StatelessWidget {
  const AdditionalPage({super.key});
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
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapPage()),
            );
          },
          child: const Text('Open Map'),
          ),
          ],
        ),
      ),
    );
  }
}
