import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highlight/highlight_core.dart';
import 'package:highlight/languages/python.dart';

class FarawlaContainer extends StatefulWidget {
  const FarawlaContainer({super.key});

  @override
  State<FarawlaContainer> createState() => _FarawlaContainerState();
}

class _FarawlaContainerState extends State<FarawlaContainer> {
  Mode _language = python;
  late final CodeController _codeController;
  final CodeController _descriptionController = CodeController(params: const EditorParams(tabSpaces: 4));

  @override
  void initState() {
    _codeController = CodeController(language: _language, params: const EditorParams(tabSpaces: 4));
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: transparent,
      splashColor: transparent,
      focusColor: transparent,
      highlightColor: transparent,
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: grey, blurRadius: 5, blurStyle: BlurStyle.outer),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CodeField(
                    controller: _codeController,
                    maxLines: 8,
                    wrap: true,
                    gutterStyle: const GutterStyle(width: 20),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AnimSearchBar(
                                  width: width,
                                  textController: textController,
                                  onSuffixTap: onSuffixTap,
                                  onSubmitted: onSubmitted,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.code, size: 15, color: pink)),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CodeField(
                controller: _descriptionController,
                maxLines: 5,
                wrap: true,
                gutterStyle: const GutterStyle(width: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
