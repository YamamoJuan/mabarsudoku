import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  bool _playerReady = false;
  bool _opponentReady = false;
  String _inviteCode = 'ABC123XYZ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    'Game Room',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Invite Code: $_inviteCode',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _PlayerCard(
                        name: 'You',
                        ready: _playerReady,
                        isYou: true,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.sync),
                      ),
                      _PlayerCard(
                        name: 'Opponent',
                        ready: _opponentReady,
                        isYou: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.amber.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Waiting for opponent to join...',
                            style: TextStyle(color: Colors.amber.shade900),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _playerReady && _opponentReady
                        ? () => context.go('/game/multiplayer')
                        : null,
                    child: Text(_playerReady ? 'Waiting for opponent...' : 'Ready to Play'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Leave Room'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final String name;
  final bool ready;
  final bool isYou;

  const _PlayerCard({
    Key? key,
    required this.name,
    required this.ready,
    required this.isYou,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ready ? Colors.green.shade100 : Colors.grey.shade100,
            border: Border.all(
              color: ready ? Colors.green : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.person,
                size: 50,
                color: ready ? Colors.green : Colors.grey,
              ),
              if (ready)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(
          ready ? 'Ready' : 'Not ready',
          style: TextStyle(
            fontSize: 12,
            color: ready ? Colors.green : Colors.orange,
          ),
        ),
      ],
    );
  }
}
