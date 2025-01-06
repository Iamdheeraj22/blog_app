import 'package:blog_app/core/common/app_theme/app_theme_cubit.dart';
import 'package:blog_app/core/common/app_user/app_user_cubit.dart';
import 'package:blog_app/core/routes/navigation_routes.dart';
import 'package:blog_app/core/storage/app_user_local_storage.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile_bloc.dart';

import 'package:blog_app/init_dependencies.dart';
import 'package:blog_app/main_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  final isUserLoggedIn = AppUserLocalStorage().isUserLoggedIn();
  runApp(MyApp(
    isUserLoggedIn: isUserLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isUserLoggedIn});

  final bool isUserLoggedIn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<AppUserCubit>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<AppThemeCubit>()..fetchTheme(),
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
          BlocProvider(
            create: (_) => serviceLocator<ProfileBloc>(),
          ),
        ],
        child: MainAppPage(
          isLoggedIn: isUserLoggedIn,
        ),
      ),
    );
  }
}
