import 'package:blog_app/core/common/app_user/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/utils/internet_connection_checker.dart';
import 'package:blog_app/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:blog_app/features/authentication/domain/usercases/current_user.dart';
import 'package:blog_app/features/authentication/domain/usercases/user_sign_in.dart';
import 'package:blog_app/features/authentication/domain/usercases/user_sign_up.dart';
import 'package:blog_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/usercases/get_blogs.dart';
import 'package:blog_app/features/blog/domain/usercases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/blog/domain/repositories/blog_repository.dart';

part 'init_dependencies.main.dart';
