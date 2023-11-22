import 'package:code_text_field/code_text_field.dart';
import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';

class FarawlaContainer extends StatefulWidget {
  const FarawlaContainer({super.key});

  @override
  State<FarawlaContainer> createState() => _FarawlaContainerState();
}

class _FarawlaContainerState extends State<FarawlaContainer> {
  final CodeController _codeController = CodeController(language: );
  final CodeController _descriptionController = CodeController();

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: transparent,
      splashColor: transparent,
      highlightColor: transparent,
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CodeField(controller: _codeController, maxLines: 8),
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CodeField(
                controller: _descriptionController,
                maxLines: 5,
                lineNumbers: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
