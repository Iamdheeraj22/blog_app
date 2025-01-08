import 'package:blog_app/core/common/app_theme/app_theme_cubit.dart';
import 'package:blog_app/core/routes/navigation_routes.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({
    super.key,
    required this.isLoggedIn,
  });

  final bool isLoggedIn;

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  @override
  void initState() {
    if (widget.isLoggedIn) {
      context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Blog App',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: NavigationRoutes.onGenerateRoute,
          theme: state.themeIndex == 0
              ? AppTheme.lightThemMode
              : AppTheme.darkThemeMode,
          home: widget.isLoggedIn ? BlogPage() : SignInPage(),
        );
      },
    );
  }
}
