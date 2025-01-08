import 'package:blog_app/core/common/app_theme/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeSwitcher extends StatelessWidget {
  const AppThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<AppThemeCubit>().updateTheme(0);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: state.themeIndex == 0
                        ? Border.all(
                            color: Colors.grey,
                            width: 1,
                          )
                        : null,
                    //borderRadius: BorderRadius.circular(7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.wb_sunny_rounded),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  context.read<AppThemeCubit>().updateTheme(1);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: state.themeIndex == 1
                        ? Border.all(
                            color: Colors.grey,
                            width: 1,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.nightlight),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
