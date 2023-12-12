import 'package:exerciser/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:exerciser/widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [HomeButton(title: title)],
      ),
      body: const SearchWidget(),
    );
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(title: title),
          ),
        );
      },
      icon: const Icon(Icons.home),
    );
  }
}
