import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int rating;
  final double size;

  const Rating({super.key, required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final bool isStarred = index < rating;
        final IconData icon = isStarred ? Icons.star : Icons.star_border;

        return Icon(
          icon,
          color: isStarred ? Colors.amber : Colors.grey[500],
          size: size,
        );
      }),
    );
  }
}
