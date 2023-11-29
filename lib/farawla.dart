import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:farawla/farawla_container.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class Farawla extends StatefulWidget {
  const Farawla({super.key, required this.boxIndex});
  final int boxIndex;

  @override
  State<Farawla> createState() => _FarawlaState();
}

class _FarawlaState extends State<Farawla> {
  final GlobalKey<State> _tilesKey = GlobalKey<State>();
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.numpadAdd, control: true): KeyboardNumPadAddIntent(),
        SingleActivator(LogicalKeyboardKey.enter, control: true): KeyboardEnterIntent(),
        SingleActivator(LogicalKeyboardKey.numpadEnter, control: true): KeyboardNumPadEnterIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          KeyboardNumPadAddIntent: CallbackAction<KeyboardNumPadAddIntent>(
            onInvoke: (KeyboardNumPadAddIntent intent) async {
              final List data = boxes[widget.boxIndex].get("data");
              data.add(<dynamic, dynamic>{"language": "Python", "code": "", "explication": ""});
              await boxes[widget.boxIndex].put("data", data);
              _tilesKey.currentState!.setState(() {});
              return true;
            },
          ),
          KeyboardNumPadEnterIntent: CallbackAction<KeyboardNumPadAddIntent>(
            onInvoke: (KeyboardNumPadAddIntent intent) async {
              _screenshotController.captureAndSave((await getApplicationDocumentsDirectory()).path, fileName: '${Random().nextInt(4000)}.png');
              return true;
            },
          ),
          KeyboardEnterIntent: CallbackAction<KeyboardNumPadAddIntent>(
            onInvoke: (KeyboardNumPadAddIntent intent) async {
              _screenshotController.captureAndSave((await getApplicationDocumentsDirectory()).path, fileName: '${Random().nextInt(4000)}.png');
              return true;
            },
          ),
        },
        child: Scaffold(
          body: InkWell(
            onTap: () {},
            child: Column(
              children: <Widget>[
                WindowTitleBarBox(
                  child: Row(
                    children: <Widget>[
                      Expanded(child: MoveWindow()),
                      MinimizeWindowButton(),
                      MaximizeWindowButton(),
                      CloseWindowButton(colors: WindowButtonColors(mouseOver: pink)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              highlightColor: transparent,
                              hoverColor: transparent,
                              splashColor: transparent,
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: pink.withOpacity(.6)),
                                child: const Icon(FontAwesomeIcons.chevronLeft, size: 20, color: white),
                              ),
                            ),
                            const Spacer(),
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                InkWell(
                                  highlightColor: transparent,
                                  hoverColor: transparent,
                                  splashColor: transparent,
                                  onTap: () async {
                                    final List data = boxes[widget.boxIndex].get("data");
                                    data.add(<dynamic, dynamic>{"language": "Python", "code": "", "explication": ""});
                                    await boxes[widget.boxIndex].put("data", data);
                                    _tilesKey.currentState!.setState(() {});
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: pink.withOpacity(.6)),
                                    child: const Icon(FontAwesomeIcons.plus, size: 20, color: white),
                                  ),
                                ),
                                IgnorePointer(ignoring: true, child: LottieBuilder.asset("assets/add.json", width: 60, height: 60)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        StatefulBuilder(
                          key: _tilesKey,
                          builder: (BuildContext context, void Function(void Function()) _) {
                            return Expanded(
                              child: boxes[widget.boxIndex].get("data").isEmpty
                                  ? const Center(child: Text("No Tiles Yet.", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: pink)))
                                  : Screenshot(
                                      controller: _screenshotController,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: boxes[widget.boxIndex].get("data").length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(padding: const EdgeInsets.all(24), child: FarawlaContainer(data: boxes[widget.boxIndex].get("data")[index], boxIndex: widget.boxIndex, tileIndex: index));
                                        },
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KeyboardNumPadAddIntent extends Intent {
  const KeyboardNumPadAddIntent();
}

class KeyboardNumPadEnterIntent extends Intent {
  const KeyboardNumPadEnterIntent();
}

class KeyboardEnterIntent extends Intent {
  const KeyboardEnterIntent();
}
