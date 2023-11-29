import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:farawla/farawla_container.dart';
import 'package:farawla/utils/callbacks.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uuid/v8.dart';

class Farawla extends StatefulWidget {
  const Farawla({super.key, required this.boxIndex});
  final int boxIndex;

  @override
  State<Farawla> createState() => _FarawlaState();
}

class _FarawlaState extends State<Farawla> {
  final GlobalKey<State> _tilesKey = GlobalKey<State>();
  final ScreenshotController _screenshotController = ScreenshotController();
  final FocusNode _keyFocusNode = FocusNode();

  @override
  void dispose() {
    _keyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _keyFocusNode,
      onKey: (RawKeyEvent event) async {
        if (event is RawKeyDownEvent) {
          if (event.isControlPressed && event.logicalKey == LogicalKeyboardKey.numpadAdd) {
            final List data = boxes[widget.boxIndex].get("data");
            data.add(<dynamic, dynamic>{"language": "Python", "code": "", "explication": ""});
            await boxes[widget.boxIndex].put("data", data);
            // ignore: use_build_context_synchronously
            showSnack('New Cell Is Added Successfully', context);
            _tilesKey.currentState!.setState(() {});
          }
          if (event.isControlPressed && event.logicalKey == LogicalKeyboardKey.numpadSubtract) {
            final List data = boxes[widget.boxIndex].get("data");
            data.removeLast();
            await boxes[widget.boxIndex].put("data", data);
            // ignore: use_build_context_synchronously
            showSnack('Last Cell Is Removed Successfully', context);
            _tilesKey.currentState!.setState(() {});
          }
          if (event.isControlPressed && const <LogicalKeyboardKey>[LogicalKeyboardKey.numpadEnter, LogicalKeyboardKey.enter].contains(event.logicalKey)) {
            _screenshotController.captureAndSave((await getApplicationDocumentsDirectory()).path, fileName: '${const UuidV8().generate()}.png');
            // ignore: use_build_context_synchronously
            showSnack('A Full Screen Snapshot Is Taken Successfully', context);
          }
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            WindowTitleBarBox(
              child: Row(
                children: <Widget>[
                  const Icon(FontAwesomeIcons.cubes, size: 10, color: pink),
                  const SizedBox(width: 5),
                  const Text("Farawla", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: pink)),
                  Expanded(child: MoveWindow()),
                  Flexible(child: TextField()),
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
                child: Stack(
                  children: <Widget>[
                    StatefulBuilder(
                      key: _tilesKey,
                      builder: (BuildContext context, void Function(void Function()) _) {
                        return Positioned.fill(
                          child: boxes[widget.boxIndex].get("data").isEmpty
                              ? const Center(child: Text("No Tiles Yet.", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: pink)))
                              : Screenshot(
                                  controller: _screenshotController,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: boxes[widget.boxIndex].get("data").length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(padding: const EdgeInsets.all(24), child: FarawlaContainer(data: boxes[widget.boxIndex].get("data")[index], boxIndex: widget.boxIndex, tileIndex: index));
                                    },
                                  ),
                                ),
                        );
                      },
                    ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
