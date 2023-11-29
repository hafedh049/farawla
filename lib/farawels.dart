import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:farawla/farawels_container.dart';
import 'package:farawla/utils/callbacks.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class Farawels extends StatefulWidget {
  const Farawels({super.key});

  @override
  State<Farawels> createState() => _FarawelsState();
}

class _FarawelsState extends State<Farawels> {
  final GlobalKey<State> _boxesKey = GlobalKey<State>();
  final FocusNode _keyFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _keyFocusNode.dispose();
    super.dispose();
  }

  Future<void> tool() async {
    final GlobalKey<State> pictureKey = GlobalKey<State>();
    Uint8List picture = (await rootBundle.load("assets/default.jpg")).buffer.asUint8List();
    final TextEditingController titleController = TextEditingController();

    // ignore: use_build_context_synchronously
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: dark,
                    boxShadow: <BoxShadow>[BoxShadow(color: pink.withOpacity(.2), blurStyle: BlurStyle.outer, offset: const Offset(2, 4))],
                  ),
                  child: TextField(
                    controller: titleController,
                    style: const TextStyle(color: pink, fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title *",
                      hintStyle: const TextStyle(color: pink, fontSize: 16, fontWeight: FontWeight.w500),
                      suffixIcon: IconButton(
                        splashColor: pink.withOpacity(.6),
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.x, color: pink, size: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                StatefulBuilder(
                  key: pictureKey,
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return Container(
                      height: 200,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: MemoryImage(picture), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                        color: dark,
                        boxShadow: <BoxShadow>[BoxShadow(color: pink.withOpacity(.2), blurStyle: BlurStyle.outer, offset: const Offset(3, 4))],
                      ),
                      child: Center(
                        child: InkWell(
                          highlightColor: transparent,
                          hoverColor: transparent,
                          splashColor: transparent,
                          onTap: () async {
                            final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (file != null) {
                              picture = await file.readAsBytes();
                              _(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: dark,
                              border: Border.all(color: pink, width: 2),
                              boxShadow: <BoxShadow>[BoxShadow(color: pink.withOpacity(.2), blurStyle: BlurStyle.outer, offset: const Offset(2, 2))],
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(FontAwesomeIcons.plus, size: 25, color: pink),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    InkWell(
                      highlightColor: transparent,
                      hoverColor: transparent,
                      splashColor: transparent,
                      onTap: () async => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: dark,
                          border: Border.all(color: pink, width: 2),
                          boxShadow: <BoxShadow>[BoxShadow(color: pink.withOpacity(.2), blurStyle: BlurStyle.outer, offset: const Offset(3, 4))],
                        ),
                        child: const Text("Cancel", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: pink)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      highlightColor: transparent,
                      hoverColor: transparent,
                      splashColor: transparent,
                      onTap: () async {
                        if (titleController.text.trim().isNotEmpty) {
                          final Box box = await Hive.openBox(titleController.text.trim());
                          box.putAll(
                            <dynamic, dynamic>{
                              "title": titleController.text.trim(),
                              "data": [],
                              "picture": picture,
                            },
                          );
                          // ignore: use_build_context_synchronously
                          showSnack('New Category Is Added Successfully', context);
                          _boxesKey.currentState!.setState(() {});
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: dark,
                          border: Border.all(color: pink, width: 2),
                          boxShadow: <BoxShadow>[BoxShadow(color: pink.withOpacity(.2), blurStyle: BlurStyle.outer, offset: const Offset(3, 4))],
                        ),
                        child: const Text("OK", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: pink)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((void value) => titleController.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _keyFocusNode,
      onKey: (RawKeyEvent event) async {
        if (event is RawKeyDownEvent) {
          if (event.isControlPressed && event.logicalKey == LogicalKeyboardKey.numpadAdd) {
            await tool();
          }
        }
      },
      child: Scaffold(
        body: Column(
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
            Row(
              children: <Widget>[
                const Spacer(),
                SearchBarAnimation(
                  hintText: "Pick your language",
                  onChanged: (String text) => searchKey.currentState!.setState(() {}),
                  textEditingController: _searchController,
                  isOriginalAnimation: true,
                  buttonWidget: const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
                  trailingWidget: const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
                  secondaryButtonWidget: const Icon(FontAwesomeIcons.x, size: 15),
                ),
                const Spacer(),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    InkWell(
                      highlightColor: transparent,
                      hoverColor: transparent,
                      splashColor: transparent,
                      onTap: tool,
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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(48),
                  child: Center(
                    child: StatefulBuilder(
                      key: _boxesKey,
                      builder: (BuildContext context, void Function(void Function()) _) {
                        return FutureBuilder<void>(
                          future: load(),
                          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                            if (snapshot.hasData) {
                              return boxes.isEmpty
                                  ? const Text("No Boxes Yet.", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: pink))
                                  : Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      runSpacing: 20,
                                      spacing: 20,
                                      children: <Widget>[for (int index = 0; index < boxes.length; index++) FarawelsContainer(boxIndex: index)],
                                    );
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator(color: pink);
                            } else {
                              return Text(snapshot.error.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: pink));
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
