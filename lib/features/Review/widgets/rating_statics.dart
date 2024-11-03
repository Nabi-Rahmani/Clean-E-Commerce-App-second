// Create a widget to show rating statistics
import 'package:flutter/material.dart';

class RatingStatistics extends StatelessWidget {
  final double averageRating;
  final int reviewCount;

  const RatingStatistics({
    super.key,
    required this.averageRating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  index < averageRating.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
            Text('Based on $reviewCount reviews'),

            // Add rating distribution
            ...List.generate(5, (index) {
              final starNumber = 5 - index;
              return Row(
                children: [
                  Text('$starNumber star'),
                  const Expanded(
                    child: LinearProgressIndicator(
                      value: 0.7, // You'll calculate this from actual data
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
