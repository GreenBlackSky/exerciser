import 'dart:async';
import 'package:exerciser/config/exercises.dart';
import 'package:exerciser/config/tags.dart';
import 'package:exerciser/models/exercise.dart';
import 'package:exerciser/models/tag.dart';
import 'package:exerciser/pages/exercise_page.dart';
import 'package:flutter/material.dart';

import 'package:textfield_tags/textfield_tags.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextfieldTagsController _controller = TextfieldTagsController();
  Iterable<Exercise> _searchResults = [];
  late double _distanceToField;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSearchField(),
        getSearchResultsView(),
      ],
    );
  }

  void updateSearchResults() {
    if (!_controller.hasTags) {
      _searchResults = [];
    } else {
      List<String> tagNames = _controller.getTags!;
      Iterable<Tag> tags = tagNames.map((tagName) {
        return Tags.getByName(tagName)!;
      });
      _searchResults = Exercises.getByTags(tags);
    }
  }

  Autocomplete<String> getSearchField() {
    return Autocomplete<String>(
      optionsViewBuilder: optionsViewBuilder,
      optionsBuilder: optionsBuilder,
      onSelected: (String selectedTag) {
        _controller.addTag = selectedTag;
      },
      fieldViewBuilder: fieldViewBuilder,
    );
  }

  FutureOr<Iterable<String>> optionsBuilder(TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty();
    }
    return Tags.getAllTags().where((Tag option) {
      return option.name.contains(textEditingValue.text.toLowerCase());
    }).map((Tag tag) {
      return tag.name;
    });
  }

  Widget optionsViewBuilder(context, onSelected, options) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          elevation: 4.0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final dynamic option = options.elementAt(index);
                return getOptionButton(onSelected, option);
              },
            ),
          ),
        ),
      ),
    );
  }

  TextButton getOptionButton(onSelected, option) {
    return TextButton(
      onPressed: () {
        setState(() {
          onSelected(option);
          updateSearchResults();
        });
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            '#$option',
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Color.fromARGB(255, 74, 137, 92),
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldViewBuilder(context, ttec, tfn, onFieldSubmitted) {
    return TextFieldTags(
      textEditingController: ttec,
      focusNode: tfn,
      textfieldTagsController: _controller,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      // validator: (String tag) {
      //   if (tag == 'php') {
      //     return 'No, please just no';
      //   } else if (_controller.getTags!.contains(tag)) {
      //     return 'you already entered that';
      //   }
      //   return null;
      // },
      inputfieldBuilder: inputfieldBuilder,
    );
  }

  Function(BuildContext, ScrollController, List<String>, void Function(String))
      inputfieldBuilder(
          BuildContext context,
          TextEditingController tec,
          FocusNode fn,
          String? error,
          void Function(String)? onChanged,
          void Function(String)? onSubmitted) {
    return ((context, sc, tags, onTagDelete) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          controller: tec,
          focusNode: fn,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 74, 137, 92), width: 3.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 74, 137, 92), width: 3.0),
            ),
            helperText: 'Enter tags...',
            helperStyle: const TextStyle(
              color: Color.fromARGB(255, 74, 137, 92),
            ),
            hintText: _controller.hasTags ? '' : "Enter tag...",
            errorText: error,
            prefixIconConstraints:
                BoxConstraints(maxWidth: _distanceToField * 0.74),
            prefixIcon: tags.isNotEmpty
                ? SingleChildScrollView(
                    controller: sc,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: tags.map((String tag) {
                      return getTagButton(tag, onTagDelete);
                    }).toList()),
                  )
                : null,
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        ),
      );
    });
  }

  Container getTagButton(String tag, void Function(String) onTagDelete) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Color.fromARGB(255, 74, 137, 92),
      ),
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Text(
              '#$tag',
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          const SizedBox(width: 4.0),
          InkWell(
            child: const Icon(
              Icons.cancel,
              size: 14.0,
              color: Color.fromARGB(255, 233, 233, 233),
            ),
            onTap: () {
              setState(() {
                onTagDelete(tag);
                updateSearchResults();
              });
            },
          )
        ],
      ),
    );
  }

  Widget getSearchResultsView() {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _searchResults.length,
          itemBuilder: (BuildContext context, int index) {
            final dynamic option = _searchResults.elementAt(index);
            return TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisePage(currentExercise: option),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(option.name, textAlign: TextAlign.left),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
