import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/flush_helper.dart';
import '../../../utils/shared_preferences.dart';
import '../../../utils/size_helper.dart';
import '../../auth/view/login_page.dart';
import '../../auth/view_model/auth_bloc/auth_bloc.dart';
import '../../profile/view_model/bloc/profile_bloc.dart';
import '../../timeline/view/timeline_page.dart';

SizeHelper _sizeHelper = SizeHelper();

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await autoLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sizeHelper.context = context;
    _sizeHelper.setSize(MediaQuery.of(context).size);

    final _authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          _authBloc.add(ClearAuthEvent());
          return Future.value(false);
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return const LoginPage();
            }
            if (state is AuthSuccess) {
              return const TimelinePage();
            }
            if (state is AuthFailure) {
              FlushHelper.flush(
                  context: context, message: state.error, type: FlushType.fail);
              return const LoginPage();
            }

            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  Future<void> autoLogin() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final username =
          sharedPreferences.getString(SharedPreferencesHelper.username);

      final password =
          sharedPreferences.getString(SharedPreferencesHelper.password);

      if (username != "") {
        BlocProvider.of<AuthBloc>(context)
            .add(AutoLoginEvent(username: username!, password: password!));
      }
    } on Exception catch (e) {
      // TODOShowLoginScreenEvent
      BlocProvider.of<AuthBloc>(context).add(
        ClearAuthEvent(),
      );
    }
  }
}
