import 'package:blog_app/core/common/app_theme/app_theme_cubit.dart';
import 'package:blog_app/features/theme/presentation/widgets/theme_item_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  static const String id = '/theme_page';

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Theme Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 20,
              children: [
                ThemeItemView(
                  title: 'Dark',
                  onTap: () {
                    context.read<AppThemeCubit>().updateTheme(1);
                  },
                  isSelected: state.themeIndex == 1,
                ),
                ThemeItemView(
                  title: 'Light',
                  onTap: () {
                    context.read<AppThemeCubit>().updateTheme(0);
                  },
                  isSelected: state.themeIndex == 0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
