import 'dart:async';
import 'package:exerciser/config/tags.dart';
import 'package:exerciser/models/tag.dart';
import 'package:flutter/material.dart';

import 'package:textfield_tags/textfield_tags.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextfieldTagsController _controller = TextfieldTagsController();
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
        getClearTagsButton(),
      ],
    );
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
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
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
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: Color.fromARGB(255, 74, 137, 92),
                            ),
                            margin: const EdgeInsets.only(right: 10.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '#$tag',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    //print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Color.fromARGB(255, 233, 233, 233),
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          );
        });
      },
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
                return TextButton(
                  onPressed: () {
                    onSelected(option);
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
              },
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton getClearTagsButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 74, 137, 92),
        ),
      ),
      onPressed: () {
        _controller.clearTags();
      },
      child: const Text('CLEAR TAGS'),
    );
  }
}
