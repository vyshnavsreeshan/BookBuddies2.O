import 'package:bookbuddies/features/community/screens/community_screen.dart';
import 'package:bookbuddies/features/community/screens/create_community_screen.dart';
import 'package:bookbuddies/features/community/screens/edit_community_screen.dart';
import 'package:bookbuddies/features/community/screens/mod_tools_screen.dart';
import 'package:bookbuddies/features/home/screens/home_screen.dart';
import 'package:bookbuddies/features/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(
        child: LoginScreen(),
      ),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(
        child: HomeSreen(),
      ),
  '/create-community': (_) => const MaterialPage(
        child: CreateCommunityScreen(),
      ),
      '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(
        name: route.pathParameters['name']!,
      ),
      ),
      '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(
        name: routeData.pathParameters['name']!,
      ),
    ),
    '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(
        name: routeData.pathParameters['name']!,
      ),
    ),
});
