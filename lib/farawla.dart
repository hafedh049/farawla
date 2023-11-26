import 'package:farawla/farawla_container.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class Farawla extends StatefulWidget {
  const Farawla({super.key});

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
                      onTap: () => print(1),
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(padding: EdgeInsets.all(24), child: FarawlaContainer());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
