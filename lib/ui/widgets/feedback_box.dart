import 'package:flutter/material.dart';

class FeedbackBox extends StatelessWidget {
  final String text;

  const FeedbackBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text("'$text'", style: TextStyle(fontSize: 14)),
    );
  }
}