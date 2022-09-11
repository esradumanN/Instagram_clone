import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/auth/view_model/auth_bloc/auth_bloc.dart';
import 'package:instagram_clone/providers/navbar_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../main.dart';
import '../../../ui/error_page.dart';
import '../../../ui/loading_screen.dart';
import '../../../utils/cached_network_image_helper.dart';
import '../../timeline/view/widgets/stories_view.dart';
import '../view_model/bloc/profile_bloc.dart';

int tabIndex = 0;
ScrollController _controller = ScrollController();

class ProfileBody extends StatefulWidget {
  const ProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder(
      bloc: profileBloc,
      builder: (context, state) {
        if (state is ProfileInitial) {
          profileBloc.add(GetProfile());
        }
        if (state is ProfileLoading) {
          return LoadingScreen();
        }
        if (state is ProfileFailure) {
          return ErrorPage(message: state.error);
        }
        if (state is ProfileSuccess) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            controller: _controller,
            child: SizedBox(
              height: sizeHelper.size!.height * 5 / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeHelper.sbh(10),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: ProfilePhoto(
                              url: state.profile.data.profilePhoto)),
                      Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              FollowerCard(
                                count: 54,
                                title: "Posts",
                              ),
                              FollowerCard(
                                count: 834,
                                title: "Follower",
                              ),
                              FollowerCard(
                                count: 162,
                                title: "Following",
                              )
                            ],
                          ))
                    ],
                  ),
                  sizeHelper.sbh(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.profile.data.fullName,
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: sizeHelper.getHeight(17),
                          ),
                        ),
                        Text(
                          state.profile.data.profileText,
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: sizeHelper.getHeight(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizeHelper.sbh(10),
                  Center(
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(ClearAuthEvent());
                      },
                      child: Container(
                        height: sizeHelper.getHeight(35),
                        width: sizeHelper.getWidth(340),
                        decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                            child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: sizeHelper.getHeight(15),
                          ),
                        )),
                      ),
                    ),
                  ),
                  sizeHelper.sbh(10),
                  SizedBox(
                    height: sizeHelper.getHeight(75),
                    width: sizeHelper.size!.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.profile.data.highlights.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ProfilePhoto(url: "");
                        }
                        return ProfilePhoto(
                          url: state.profile.data.highlights[index - 1].url,
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 50,
                    width: sizeHelper.size!.width,
                    child: Row(children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() {
                            tabIndex = 0;
                          }),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                  child: Image.asset(
                                      "assets/icons/Grid Icon.png")),
                              Container(
                                height: 2,
                                color:
                                    tabIndex == 0 ? Colors.black : Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() {
                            tabIndex = 1;
                          }),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                  child: Image.asset(
                                      "assets/icons/Tags Icon.png")),
                              Container(
                                height: 2,
                                color:
                                    tabIndex == 1 ? Colors.black : Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: state.profile.data.posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = state.profile.data.posts[index];
                        return ImageHelper(
                                imageUrl: item.images.first.url,
                                isRectangle: true)
                            .getNetworkImage();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class FollowerCard extends StatelessWidget {
  const FollowerCard({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);
  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
              color: AppColors.textGrey,
              fontSize: sizeHelper.getHeight(20),
              fontWeight: FontWeight.w600),
        ),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: sizeHelper.getHeight(15),
          ),
        ),
      ],
    );
  }
}

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(sizeHelper.getHeight(1)),
      decoration: BoxDecoration(
        color: AppColors.grey,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(sizeHelper.getHeight(5)),
        height: sizeHelper.getHeight(100),
        width: sizeHelper.getHeight(100),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: url == ""
            ? Icon(
                Icons.add,
                size: 35,
              )
            : ImageHelper(imageUrl: url).getNetworkImage(),
      ),
    );
  }
}
