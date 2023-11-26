import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highlight/highlight_core.dart';
import 'package:highlight/languages/all.dart';
import 'package:highlight/languages/python.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: const <BoxShadow>[BoxShadow(color: grey, blurRadius: 5, blurStyle: BlurStyle.outer)]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                ClipRRect(borderRadius: BorderRadius.circular(15), child: CodeField(controller: _codeController, maxLines: 8, wrap: true, gutterStyle: const GutterStyle(width: 20))),
                IconButton(
                  onPressed: () {
                    final TextEditingController searchLanguageController = TextEditingController();
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          height: 300,
                          child: StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SearchBarAnimation(
                                    onChanged: (String text) {},
                                    textEditingController: searchLanguageController,
                                    isOriginalAnimation: true,
                                    buttonWidget: const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
                                    trailingWidget: const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
                                    secondaryButtonWidget: const Icon(FontAwesomeIcons.x, size: 15),
                                  ),
                                  const SizedBox(height: 10),
                                  ListView.builder(
                                    itemCount: allLanguages.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      bool hoverState = false;
                                      return StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) $) {
                                          return InkWell(
                                            highlightColor: transparent,
                                            hoverColor: transparent,
                                            splashColor: transparent,
                                            onHover: (bool state) => $(() => hoverState = state),
                                            child: AnimatedScale(
                                              duration: 700.ms,
                                              scale: hoverState ? 1.05 : 1,
                                              child: AnimatedContainer(
                                                duration: 700.ms,
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: hoverState ? pink : null),
                                                child: Row(
                                                  children: <Widget>[
                                                    const Icon(FontAwesomeIcons.codeCommit, size: 15, color: pink),
                                                    const SizedBox(width: 10),
                                                    Text(allLanguages.keys[index]),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.code, size: 15, color: pink),
                ),
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
