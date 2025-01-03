import 'package:blog_app/core/common/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/common/widgets/user_profile_error_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_item_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static route() => MaterialPageRoute(
        builder: (_) => ProfilePage(),
      );

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          return Padding(
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
                          imageUrl: state is AppUserLoggedIn
                              ? state.user.userProfile ?? ''
                              : '',
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
                          placeholder: (context, url) => UserProfileErrorView(),
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
                            state is AppUserLoggedIn
                                ? state.user.name
                                : 'Not Available',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppPallete.whiteColor,
                            ),
                          ),
                          Text(
                            state is AppUserLoggedIn
                                ? state.user.email
                                : 'Not Available',
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
                  onTap: () {},
                  title: 'Logout',
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
