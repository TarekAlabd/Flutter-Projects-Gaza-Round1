import 'package:flutter/material.dart';

class TopHeadlinesPage extends StatelessWidget {
  const TopHeadlinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: const Center(
        child: Text('Top Headlines'),
      ),
    );
  }
}
