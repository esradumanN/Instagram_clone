import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/constants/app_colors.dart';
import 'package:instagram_clone/core/constants/app_constants.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/pages/auth/repository/auth_repository.dart';
import 'package:instagram_clone/pages/timeline/model/timeline.dart';
import 'package:instagram_clone/pages/timeline/repository/timeline_repository.dart';
import 'package:instagram_clone/pages/timeline/view/widgets/appbar.dart';
import 'package:instagram_clone/pages/timeline/view/widgets/navbar.dart';
import 'package:instagram_clone/pages/timeline/view/widgets/stories_view.dart';
import 'package:instagram_clone/pages/timeline/view/widgets/timeline_card.dart';
import 'package:instagram_clone/pages/timeline/view_model/bloc/timeline_bloc.dart';
import 'package:instagram_clone/utils/locator.dart';
import 'package:provider/provider.dart';

import '../../../providers/navbar_provider.dart';
import '../../../ui/error_page.dart';
import '../../../ui/loading_screen.dart';
import '../../../utils/cached_network_image_helper.dart';
import '../../auth/view_model/auth_bloc/auth_bloc.dart';
import '../../profile/view/profile_page.dart';
import '../../profile/view_model/bloc/profile_bloc.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: _selectBody(navbarProvider),
      bottomNavigationBar: Navbar(),
    );
  }

  _selectBody(NavbarProvider navbarProvider) {
    switch (navbarProvider.index) {
      case 0:
        return TimelineBody();
      case 4:
        return ProfileBody();
      default:
        return TimelineBody();
    }
  }
}

class TimelineBody extends StatelessWidget {
  const TimelineBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timelineBloc = BlocProvider.of<TimelineBloc>(context);
    return Container(
      child: Column(children: [
        Expanded(
          child: BlocBuilder(
            bloc: timelineBloc,
            builder: (context, state) {
              if (state is TimelineInitial) {
                timelineBloc.add(GetTimeline());
              }
              if (state is TimelineLoading) {
                return LoadingScreen();
              }
              if (state is TimelineFailure) {
                return ErrorPage(message: state.error);
              }
              if (state is TimelineSuccess) {
                return ListView.separated(
                    itemCount: state.timeline.data.timeline.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            StoriesView(),
                            Container(
                              height: 1,
                              color: AppColors.lightGrey,
                            ),
                          ],
                        );
                      }
                      var item = state.timeline.data.timeline[index - 1];
                      return TimelineCard(item: item);
                    },
                    separatorBuilder: (context, index) {
                      if (index == 0) {
                        return SizedBox();
                      }
                      return sizeHelper.sbh(20);
                    });
              }
              return Container();
            },
          ),
        )
      ]),
    );
  }
}
