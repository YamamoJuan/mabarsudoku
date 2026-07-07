import 'package:flutter/material.dart';

class Numpad extends StatelessWidget {
  final void Function(int number) onNumberSelected;
  final VoidCallback onErase;
  final VoidCallback onNote;

  const Numpad({
    Key? key,
    required this.onNumberSelected,
    required this.onErase,
    required this.onNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NumPadButton(number: 1, onTap: () => onNumberSelected(1)),
              _NumPadButton(number: 2, onTap: () => onNumberSelected(2)),
              _NumPadButton(number: 3, onTap: () => onNumberSelected(3)),
              _NumPadButton(number: 4, onTap: () => onNumberSelected(4)),
              _NumPadButton(number: 5, onTap: () => onNumberSelected(5)),
              _NumPadButton(number: 6, onTap: () => onNumberSelected(6)),
              _NumPadButton(number: 7, onTap: () => onNumberSelected(7)),
              _NumPadButton(number: 8, onTap: () => onNumberSelected(8)),
              _NumPadButton(number: 9, onTap: () => onNumberSelected(9)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.auto_fix_high),
                tooltip: 'Notes',
                onPressed: onNote,
              ),
              const SizedBox(width: 32),
              IconButton(
                icon: const Icon(Icons.backspace_outlined),
                tooltip: 'Erase',
                onPressed: onErase,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NumPadButton extends StatelessWidget {
  final int number;
  final VoidCallback onTap;

  const _NumPadButton({
    Key? key,
    required this.number,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '$number',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
