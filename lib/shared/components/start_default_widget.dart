import 'package:flutter/material.dart';

class StartDefaultWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;

  const StartDefaultWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 48,
            color: Colors.deepPurpleAccent,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
