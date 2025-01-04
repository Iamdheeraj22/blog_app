import 'package:blog_app/core/common/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/common/widgets/state_loading_view.dart';
import 'package:blog_app/core/common/widgets/user_profile_error_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:blog_app/features/profile/presentation/widgets/logout_view.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_item_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String id = '/profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = '';
  String _email = '';
  String _profile = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userCubit = context.read<AppUserCubit>().state as AppUserLoggedIn;
      _name = userCubit.user.name;
      _email = userCubit.user.email;
      _profile = userCubit.user.userProfile ?? '';
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, SignInPage.id, (predicate) => false);
          }
        },
        builder: (context, state) {
          return StateLoadingView(
            isLoading: state is ProfileLogout,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Image, Name, Email
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppPallete.borderColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                            imageUrl: _profile,
                            imageBuilder: (context, imageProvider) => Container(
                                  width: 45.0,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.transparent,
                                          BlendMode.colorBurn),
                                    ),
                                  ),
                                ),
                            placeholder: (context, url) =>
                                UserProfileErrorView(),
                            errorWidget: (context, url, error) =>
                                UserProfileErrorView()),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              _name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppPallete.whiteColor,
                              ),
                            ),
                            Text(
                              _email,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //Divider
                  Divider(
                    color: AppPallete.borderColor,
                    thickness: 1,
                  ),

                  ProfileItemView(
                    onTap: () {},
                    title: 'About Us',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileItemView(
                    onTap: () {},
                    title: 'Theme',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileItemView(
                    onTap: () {
                      showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return LogoutView(
                            onLogout: () {
                              Navigator.pop(
                                context,
                                true,
                              );
                            },
                          );
                        },
                      ).then(
                        (value) {
                          if (value != null && value && context.mounted) {
                            context.read<ProfileBloc>().add(
                                  UserProfileLogout(),
                                );
                          }
                        },
                      );
                    },
                    title: 'Logout',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
