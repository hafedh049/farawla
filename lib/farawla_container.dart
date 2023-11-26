import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highlight/highlight_core.dart';
import 'package:highlight/languages/all.dart';
import 'package:highlight/languages/python.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class FarawlaContainer extends StatefulWidget {
  const FarawlaContainer({super.key, required this.data, required this.boxIndex, required this.tileIndex});
  final int tileIndex;
  final int boxIndex;
  final Map<dynamic, dynamic> data;
  @override
  State<FarawlaContainer> createState() => _FarawlaContainerState();
}

class _FarawlaContainerState extends State<FarawlaContainer> {
  Mode _languageMode = python;
  String _languageName = "Python";

  CodeController _codeController = CodeController(language: python, params: const EditorParams(tabSpaces: 4));
  final CodeController _descriptionController = CodeController(params: const EditorParams(tabSpaces: 4));
  final GlobalKey<State> _codeKey = GlobalKey<State>();
  final GlobalKey<State> _languageNameKey = GlobalKey<State>();

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _codeController.text = widget.data["code"];
    _descriptionController.text = widget.data["explication"];
    _languageName = widget.data["language"];
    _languageMode = allLanguages.entries.firstWhere((MapEntry<String, Mode> element) => element.key.toUpperCase() == _languageName.toUpperCase()).value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tilt(
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.none,
      lightConfig: const LightConfig(color: transparent, disable: true),
      shadowConfig: const ShadowConfig(disable: true, color: transparent),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: const <BoxShadow>[BoxShadow(color: grey, blurRadius: 5, blurStyle: BlurStyle.outer)]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: StatefulBuilder(
                    key: _codeKey,
                    builder: (BuildContext context, void Function(void Function()) _) {
                      return CodeTheme(
                        data: CodeThemeData(styles: darculaTheme),
                        child: CodeField(
                          controller: _codeController,
                          maxLines: 8,
                          wrap: true,
                          gutterStyle: const GutterStyle(width: 20),
                          onChanged: (String text) {
                            final List data = boxes[widget.boxIndex].get("data");
                            data[widget.tileIndex] = <dynamic, dynamic>{"language": _languageName, "code": _codeController.text.trim(), "explication": _descriptionController.text.trim()};
                            boxes[widget.boxIndex].put("data", data);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: pink.withOpacity(.2), borderRadius: BorderRadius.circular(5)),
                      child: StatefulBuilder(
                        key: _languageNameKey,
                        builder: (BuildContext context, void Function(void Function()) _) {
                          return Text(_languageName, style: const TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w400));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () async {
                        final TextEditingController searchLanguageController = TextEditingController();
                        final GlobalKey<State> searchKey = GlobalKey<State>();
                        await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SearchBarAnimation(
                                    hintText: "Pick your language",
                                    onChanged: (String text) => searchKey.currentState!.setState(() {}),
                                    textEditingController: searchLanguageController,
                                    isOriginalAnimation: true,
                                    buttonWidget: const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
                                    trailingWidget: const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
                                    secondaryButtonWidget: const Icon(FontAwesomeIcons.x, size: 15),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: StatefulBuilder(
                                      key: searchKey,
                                      builder: (BuildContext context, void Function(void Function()) _) {
                                        final List<String> languages = allLanguages.keys.where((String element) => element.toLowerCase().startsWith(searchLanguageController.text.trim().toLowerCase())).toList();
                                        return ListView.builder(
                                          itemCount: languages.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            bool hoverState = false;
                                            return StatefulBuilder(
                                              builder: (BuildContext context, void Function(void Function()) $) {
                                                return InkWell(
                                                  highlightColor: transparent,
                                                  hoverColor: transparent,
                                                  splashColor: transparent,
                                                  onHover: (bool state) => $(() => hoverState = state),
                                                  onTap: () async {
                                                    _codeKey.currentState!.setState(() => _languageMode = allLanguages[languages[index]]!);
                                                    _codeController = CodeController(text: _codeController.text, language: _languageMode, params: const EditorParams(tabSpaces: 4));
                                                    _languageNameKey.currentState!.setState(() => _languageName = languages[index][0].toUpperCase() + languages[index].substring(1));
                                                    final List data = boxes[widget.boxIndex].get("data");
                                                    data[widget.tileIndex] = <dynamic, dynamic>{"language": _languageName, "code": _codeController.text.trim(), "explication": _descriptionController.text.trim()};
                                                    await boxes[widget.boxIndex].put("data", data);
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.pop(context);
                                                  },
                                                  child: AnimatedScale(
                                                    duration: 700.ms,
                                                    scale: hoverState ? 1.02 : 1,
                                                    child: AnimatedContainer(
                                                      margin: const EdgeInsets.all(4),
                                                      duration: 700.ms,
                                                      padding: const EdgeInsets.all(8),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: hoverState ? pink : null),
                                                      child: Row(
                                                        children: <Widget>[
                                                          const Icon(FontAwesomeIcons.code, size: 15, color: pink),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                            languages[index][0].toUpperCase() + languages[index].substring(1),
                                                            style: TextStyle(
                                                              fontSize: hoverState ? 17 : 16,
                                                              fontWeight: hoverState ? FontWeight.w500 : FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.code, size: 15, color: pink),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CodeTheme(
                data: CodeThemeData(styles: darculaTheme),
                child: CodeField(
                  controller: _descriptionController,
                  maxLines: 5,
                  wrap: true,
                  gutterStyle: const GutterStyle(width: 20),
                  onChanged: (String text) {
                    final List data = boxes[widget.boxIndex].get("data");
                    data[widget.tileIndex] = <dynamic, dynamic>{"language": _languageName, "code": _codeController.text.trim(), "explication": _descriptionController.text.trim()};
                    boxes[widget.boxIndex].put("data", data);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
