import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arcitecture/core/data-helper/hive-helper.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/add-delete-update-post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/get-refresh-post/posts_bloc.dart';
import 'package:posts_clean_arcitecture/injection-container.dart' as di;

import 'features/posts/presentation/screens/posts-screen.dart';

//https://jsonplaceholder.typicode.com/posts/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddUpdateDeletePostBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostsScreen(),
      ),
    );
  }
}
