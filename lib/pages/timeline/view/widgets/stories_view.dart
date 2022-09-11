import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/constants/app_colors.dart';
import 'package:instagram_clone/pages/story/view_model/bloc/story_bloc.dart';
import 'package:instagram_clone/ui/error_page.dart';
import 'package:instagram_clone/ui/loading_screen.dart';
import 'package:instagram_clone/utils/push_helper.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../main.dart';
import '../../../../utils/cached_network_image_helper.dart';
import '../../../auth/view_model/auth_bloc/auth_bloc.dart';
import '../../../profile/view_model/bloc/profile_bloc.dart';
import '../../../story/view/story_page.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyBloc = BlocProvider.of<StoryBloc>(context);
    final timelineBloc = BlocProvider.of<ProfileBloc>(context);

    return SizedBox(
      height: sizeHelper.getHeight(110),
      child: BlocBuilder(
        bloc: storyBloc,
        builder: (context, state) {
          if (state is StoryInitial) {
            storyBloc.add(GetStory());
          }
          if (state is StoryLoading) {
            return LoadingScreen();
          }
          if (state is StoryFailure) {
            return ErrorPage(message: state.error);
          }
          if (state is StorySuccess) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.story.data.stories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return BlocBuilder(
                    bloc: timelineBloc,
                    builder: (context, state) {
                      if (state is ProfileInitial) {
                        timelineBloc.add(GetProfile());
                      }

                      if (state is ProfileSuccess) {
                        return Row(
                          children: [
                            sizeHelper.sbw(10),
                            Column(
                              children: [
                                StoryCard(
                                  url: state.profile.data.profilePhoto,
                                  func: () {},
                                ),
                                Text("Your Story")
                              ],
                            ),
                          ],
                        );
                      }

                      return Container();
                    },
                  );
                }
                var item = state.story.data.stories[index - 1];
                return Column(
                  children: [
                    StoryCard(
                      url: item.profilePhoto,
                      func: () {
                        PushHelper.push(
                            context: context,
                            to: StoryPage(
                              stories: item.images,
                            ));
                      },
                    ),
                    Text(item.username)
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return sizeHelper.sbw(10);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  const StoryCard({
    Key? key,
    required this.url,
    required this.func,
  }) : super(key: key);
  final String url;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: EdgeInsets.all(sizeHelper.getHeight(3)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.Linear1, AppColors.Linear2, AppColors.Linear3],
              end: Alignment.centerRight,
              begin: Alignment.bottomLeft),
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: EdgeInsets.all(sizeHelper.getHeight(5)),
          height: sizeHelper.getHeight(75),
          width: sizeHelper.getHeight(75),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: ImageHelper(imageUrl: url).getNetworkImage(),
        ),
      ),
    );
  }
}
