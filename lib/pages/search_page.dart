// import 'package:exerciser/pages/exercise_page.dart';
import 'package:exerciser/config/config.dart';
import 'package:exerciser/models/tag.dart';
import 'package:flutter/material.dart';

import 'package:exerciser/widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, this.initialTag});
  final Tag? initialTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(title),
        // actions: [HomeButton(title: title)],
      ),
      body: SearchWidget(initialTag:initialTag),
    );
  }
}

// class HomeButton extends StatelessWidget {
//   const HomeButton({
//     super.key,
//     required this.title,
//   });

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ExercisePage(title: title),
//           ),
//         );
//       },
//       icon: const Icon(Icons.home),
//     );
//   }
// }
