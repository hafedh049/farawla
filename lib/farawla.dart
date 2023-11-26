import 'package:farawla/farawla_container.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class Farawla extends StatefulWidget {
  const Farawla({super.key, required this.box, required this.boxIndex});
  final Box box;
  final int boxIndex;

  @override
  State<Farawla> createState() => _FarawlaState();
}

class _FarawlaState extends State<Farawla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      onTap: () {},
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
            Expanded(
              child: widget.box.get("data").isEmpty
                  ? const Center(child: Text("No Tiles Yet.", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: pink)))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.box.get("data").length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(padding: const EdgeInsets.all(24), child: FarawlaContainer(data: widget.box.get("data")[index], boxIndex: widget.boxIndex, tileIndex: index));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
