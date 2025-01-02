import 'dart:io';

import 'package:blog_app/core/common/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/state_loading_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/image_pick.dart';
import 'package:blog_app/core/utils/snackbar_message.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_edittor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  static route() => MaterialPageRoute(
        builder: (_) => AddNewBlogPage(),
      );

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  XFile? image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (image == null) {
                SnackBarMessage(context, message: "Please select an image")
                    .show();
                return;
              }
              if (selectedTopics.isEmpty) {
                SnackBarMessage(context, message: "Please select a topic")
                    .show();
                return;
              }
              if (!_formKey.currentState!.validate()) {
                return;
              }
              final posterId =
                  (context.read<AppUserCubit>().state as AppUserLoggedIn)
                      .user
                      .id;
              context.read<BlogBloc>().add(
                    BlogUpload(
                      image: File(image!.path),
                      title: titleController.text.trim(),
                      description: contentController.text.trim(),
                      posterId: posterId,
                      topics: selectedTopics,
                    ),
                  );
            },
            icon: Icon(
              Icons.done_rounded,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogSuccess) {
            SnackBarMessage(context, message: "Blog uploaded successfully")
                .show();
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (_) => false,
            );
            return;
          }
          if (state is BlogFailure) {
            print(state.message);
            SnackBarMessage(context, message: state.message).show();
          }
        },
        builder: (context, state) {
          return StateLoadingView(
            isLoading: state is BlogLoading,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: image != null
                            ? SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(
                                      image!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : DottedBorder(
                                borderType: BorderType.RRect,
                                color: AppPallete.borderColor,
                                dashPattern: [10, 4],
                                radius: Radius.circular(12),
                                strokeCap: StrokeCap.round,
                                child: SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      Text(
                                        "Select your image",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 10,
                          children: [
                            "Technology",
                            "Science",
                            "Health",
                            "Business",
                          ]
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(e)) {
                                      selectedTopics.remove(e);
                                    } else {
                                      selectedTopics.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppPallete.whiteColor,
                                      ),
                                    ),
                                    side: selectedTopics.contains(e)
                                        ? null
                                        : const BorderSide(
                                            color: AppPallete.borderColor),
                                    color: selectedTopics.contains(e)
                                        ? WidgetStatePropertyAll(
                                            AppPallete.gradient1,
                                          )
                                        : null,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      BlogEditor(
                        hintText: "Blog Title",
                        maxLines: 1,
                        controller: titleController,
                      ),
                      BlogEditor(
                        hintText: "Blog Content",
                        controller: contentController,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void pickImage() async {
    final pickedFile = await ImagePick.pickImage();
    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
      return;
    }
  }
}
