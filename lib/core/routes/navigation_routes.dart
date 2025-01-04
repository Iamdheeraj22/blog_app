import 'package:blog_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:blog_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../init_dependencies.dart';

class NavigationRoutes {
  NavigationRoutes._internal();

  static final NavigationRoutes _instance = NavigationRoutes._internal();

  factory NavigationRoutes() => _instance;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInPage.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SignInPage(),
        );
      case ProfilePage.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<ProfileBloc>(),
            child: ProfilePage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
