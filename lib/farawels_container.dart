import 'package:farawla/farawla.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:hive/hive.dart';

class FarawelsContainer extends StatefulWidget {
  const FarawelsContainer({super.key, required this.box});
  final Box box;
  @override
  State<FarawelsContainer> createState() => _FarawelsContainerState();
}

class _FarawelsContainerState extends State<FarawelsContainer> {
  bool _state = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: transparent,
      splashColor: transparent,
      highlightColor: transparent,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Farawla())),
      onHover: (bool state) => setState(() => _state = state),
      child: Tilt(
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.none,
        lightConfig: const LightConfig(color: transparent, disable: true),
        shadowConfig: const ShadowConfig(disable: true, color: transparent),
        child: AnimatedScale(
          duration: 700.ms,
          scale: _state ? 1.1 : 1,
          child: AnimatedContainer(
            duration: 700.ms,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(16),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: _state ? blue.withOpacity(.3) : null,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const <BoxShadow>[BoxShadow(color: grey, blurRadius: 5, blurStyle: BlurStyle.outer)],
            ),
          ),
        ),
      ),
    );
  }
}
