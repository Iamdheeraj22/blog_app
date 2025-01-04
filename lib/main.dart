import 'package:blog_app/core/common/app_user/app_user_cubit.dart';
import 'package:blog_app/core/routes/navigation_routes.dart';
import 'package:blog_app/core/theme/app_theme.dart';

import 'package:blog_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';

import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()
            ..add(
              AuthIsUserLoggedIn(),
            ),
        ),
        BlocProvider(
          create: (_) => serviceLocator<BlogBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: NavigationRoutes.onGenerateRoute,
        theme: AppTheme.darkThemeMode,
        home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLogged) {
            if (isLogged) {
              return BlogPage();
            } else {
              return SignInPage();
            }
          },
        ),
      ),
    );
  }
}
