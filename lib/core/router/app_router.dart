import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/widgets/splash_screen.dart';
import '../../features/auth/presentation/widgets/login_screen.dart';
import '../../features/home/presentation/widgets/home_screen.dart';
import '../../features/game/presentation/screens/solo_game_screen.dart';

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
  ],
);
