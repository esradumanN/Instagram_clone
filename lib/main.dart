import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/auth/view_model/auth_bloc/auth_bloc.dart';
import 'package:instagram_clone/pages/profile/view_model/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/story/view_model/bloc/story_bloc.dart';
import 'package:instagram_clone/pages/timeline/view_model/bloc/timeline_bloc.dart';
import 'package:instagram_clone/providers/auth_provider.dart';
import 'package:instagram_clone/providers/navbar_provider.dart';
import 'package:instagram_clone/core/routes/route_generator.dart';
import 'package:instagram_clone/utils/locator.dart';
import 'package:instagram_clone/utils/size_helper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => TimelineBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => StoryBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => NavbarProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

SizeHelper sizeHelper = SizeHelper();
