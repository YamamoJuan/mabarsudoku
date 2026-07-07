import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/matchmaking_provider.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  String _selectedMode = 'coop';
  String _selectedDifficulty = 'medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Room')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Game Mode',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _ModeCard(
              title: 'Co-op',
              subtitle: 'Solve the same board together',
              icon: Icons.group,
              selected: _selectedMode == 'coop',
              onTap: () => setState(() => _selectedMode = 'coop'),
            ),
            const SizedBox(height: 8),
            _ModeCard(
              title: 'Versus',
              subtitle: 'Race to finish first',
              icon: Icons.swap_horiz,
              selected: _selectedMode == 'versus',
              onTap: () => setState(() => _selectedMode = 'versus'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Difficulty',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _DifficultyChip(
                  label: 'Easy',
                  selected: _selectedDifficulty == 'easy',
                  onTap: () => setState(() => _selectedDifficulty = 'easy'),
                ),
                const SizedBox(width: 8),
                _DifficultyChip(
                  label: 'Medium',
                  selected: _selectedDifficulty == 'medium',
                  onTap: () => setState(() => _selectedDifficulty = 'medium'),
                ),
                const SizedBox(width: 8),
                _DifficultyChip(
                  label: 'Hard',
                  selected: _selectedDifficulty == 'hard',
                  onTap: () => setState(() => _selectedDifficulty = 'hard'),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createRoom,
                child: const Text('Create Room'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createRoom() {
    context.go('/lobby');
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ModeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? Colors.indigo.shade50 : Colors.grey.shade50,
          border: Border.all(
            color: selected ? Colors.indigo : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.indigo : Colors.grey),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
            const Spacer(),
            if (selected) const Icon(Icons.check_circle, color: Colors.indigo),
          ],
        ),
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DifficultyChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.indigo : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
