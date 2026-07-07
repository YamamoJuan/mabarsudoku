import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/widgets/splash_screen.dart';
import '../../features/auth/presentation/widgets/login_screen.dart';
import '../../features/home/presentation/widgets/home_screen.dart';
import '../../features/game/presentation/screens/solo_game_screen.dart';
import '../../features/matchmaking/presentation/widgets/create_room_screen.dart';
import '../../features/matchmaking/presentation/widgets/join_room_screen.dart';
import '../../features/matchmaking/presentation/widgets/lobby_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/game/solo',
      builder: (context, state) => const SoloGameScreen(),
    ),
    GoRoute(
      path: '/create-room',
      builder: (context, state) => const CreateRoomScreen(),
    ),
    GoRoute(
      path: '/join-room',
      builder: (context, state) => const JoinRoomScreen(),
    ),
    GoRoute(
      path: '/lobby',
      builder: (context, state) => const LobbyScreen(),
    ),
  ],
);
