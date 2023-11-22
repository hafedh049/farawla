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
  final TextEditingController _descriptionController = TextEditingController();

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
        duration: 700.ms,
        scale: _state ? 1.1 : 1,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(16),
          height: 200,
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
              SizedBox(height: 300, child: CodeField(controller: _codeController)),
              SizedBox(height: 500, child: TextField(controller: _descriptionController)),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
