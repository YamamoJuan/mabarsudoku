import 'package:flutter/material.dart';

class DifficultyPickerModal extends StatelessWidget {
  final Function(String) onDifficultySelected;

  const DifficultyPickerModal({
    Key? key,
    required this.onDifficultySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Difficulty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _DifficultyCard(
              title: 'Easy',
              description: '36 clues',
              difficulty: 'easy',
              onTap: () {
                onDifficultySelected('easy');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            _DifficultyCard(
              title: 'Medium',
              description: '30 clues',
              difficulty: 'medium',
              onTap: () {
                onDifficultySelected('medium');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            _DifficultyCard(
              title: 'Hard',
              description: '24 clues',
              difficulty: 'hard',
              onTap: () {
                onDifficultySelected('hard');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyCard extends StatelessWidget {
  final String title;
  final String description;
  final String difficulty;
  final VoidCallback onTap;

  const _DifficultyCard({
    Key? key,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.onTap,
  }) : super(key: key);

  Color _getColor() {
    switch (difficulty) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: _getColor(), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _getColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward, color: _getColor()),
          ],
        ),
      ),
    );
  }
}
