import 'package:code_text_field/code_text_field.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FarawlaContainer extends StatefulWidget {
  const FarawlaContainer({super.key});

  @override
  State<FarawlaContainer> createState() => _FarawlaContainerState();
}

class _FarawlaContainerState extends State<FarawlaContainer> {
  final CodeController _codeController = CodeController();
  final CodeController _descriptionController = CodeController();

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
        duration: 500.ms,
        scale: _state ? 1.02 : 1,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: <BoxShadow>[
              BoxShadow(color: grey, blurRadius: 5, blurStyle: BlurStyle.outer),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                child: CodeField(controller: _codeController, maxLines: 5),
              ),
              const SizedBox(height: 5),
              CodeField(controller: _descriptionController, maxLines: 3),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
