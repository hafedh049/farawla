import 'package:farawla/farawla.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class FarawelsContainer extends StatefulWidget {
  const FarawelsContainer({super.key, required this.boxIndex});
  final int boxIndex;
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
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => widget(child: Farawla(boxIndex: widget.boxIndex)))),
      onHover: (bool state) => setState(() => _state = state),
      child: Tilt(
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.none,
        lightConfig: const LightConfig(color: transparent, disable: true),
        shadowConfig: const ShadowConfig(disable: true, color: transparent),
        child: TiltParallax(
          child: AnimatedContainer(
            duration: 700.ms,
            padding: const EdgeInsets.all(16),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(image: MemoryImage(boxes[widget.boxIndex].get("picture")), fit: BoxFit.cover),
              color: _state ? blue.withOpacity(.3) : null,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const <BoxShadow>[BoxShadow(color: grey, blurRadius: 5, blurStyle: BlurStyle.outer)],
            ),
            child: Center(child: Text(boxes[widget.boxIndex].get("title"), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: white))),
          ),
        ),
      ),
    );
  }
}
