import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color backgroundColor;

  const Loading({Key? key, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
