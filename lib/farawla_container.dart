import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FarawlaContainer extends StatefulWidget {
  const FarawlaContainer({super.key});

  @override
  State<FarawlaContainer> createState() => _FarawlaContainerState();
}

class _FarawlaContainerState extends State<FarawlaContainer> {
  bool _state = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: transparent,
      splashColor: transparent,
      highlightColor: transparent,
      onTap: () {},
      onHover: (bool state) => setState(() => _state = state),
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
            boxShadow: <BoxShadow>[
              BoxShadow(color: grey, blurRadius: 5, blurStyle: BlurStyle.outer),
            ],
          ),
        ),
      ),
    );
  }
}
