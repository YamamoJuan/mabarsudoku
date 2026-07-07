import 'package:flutter/material.dart';

class GameCompletionScreen extends StatelessWidget {
  final Duration elapsedTime;
  final int errorsCount;
  final String difficulty;
  final VoidCallback onPlayAgain;
  final VoidCallback onBackHome;

  const GameCompletionScreen({
    Key? key,
    required this.elapsedTime,
    required this.errorsCount,
    required this.difficulty,
    required this.onPlayAgain,
    required this.onBackHome,
  }) : super(key: key);

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double _calculateAccuracy(int errors) {
    const maxErrors = 20;
    final accuracy = ((maxErrors - errors.clamp(0, maxErrors)) / maxErrors * 100).clamp(0, 100);
    return accuracy;
  }

  @override
  Widget build(BuildContext context) {
    final accuracy = _calculateAccuracy(errorsCount);
    final timeString = _formatTime(elapsedTime);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade100,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 60,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Congratulations!',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You completed the puzzle',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _StatRow(
                          label: 'Time',
                          value: timeString,
                          icon: Icons.timer,
                        ),
                        const SizedBox(height: 16),
                        _StatRow(
                          label: 'Difficulty',
                          value: difficulty.toUpperCase(),
                          icon: Icons.trending_up,
                        ),
                        const SizedBox(height: 16),
                        _StatRow(
                          label: 'Errors',
                          value: '$errorsCount',
                          icon: Icons.error_outline,
                        ),
                        const SizedBox(height: 16),
                        _StatRow(
                          label: 'Accuracy',
                          value: '${accuracy.toStringAsFixed(0)}%',
                          icon: Icons.check,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onBackHome,
                          child: const Text('Home'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onPlayAgain,
                          child: const Text('Play Again'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatRow({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
