import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/profile/repository/profile_repository.dart';
import 'package:instagram_clone/providers/navbar_provider.dart';
import 'package:instagram_clone/utils/locator.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../utils/cached_network_image_helper.dart';

import '../../../profile/view_model/bloc/profile_bloc.dart';

ProfileRepository _profileRepository = locator<ProfileRepository>();

class Navbar extends StatelessWidget with PreferredSizeWidget {
  const Navbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavbarIcon(index: 0, path: "assets/icons/home.png"),
            NavbarIcon(index: 1, path: "assets/icons/Search.png"),
            NavbarIcon(index: 2, path: "assets/icons/Reels.png"),
            NavbarIcon(index: 3, path: "assets/icons/Shop.png"),
            NavbarIcon(index: 4, path: "assets/icons/home.png"),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(sizeHelper.size!.width, 60);
}

class NavbarIcon extends StatelessWidget {
  const NavbarIcon({
    Key? key,
    required this.index,
    required this.path,
  }) : super(key: key);
  final int index;
  final String path;

  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);
    final timelineBloc = BlocProvider.of<ProfileBloc>(context);

    return GestureDetector(
        onTap: () {
          navbarProvider.index = index;
        },
        child: index == 4
            ? BlocBuilder(
                bloc: timelineBloc,
                builder: (context, state) {
                  if (state is ProfileInitial) {
                    timelineBloc.add(GetProfile());
                  }

                  if (state is ProfileSuccess) {
                    return GestureDetector(
                      onTap: () {
                        navbarProvider.index = index;
                      },
                      child:
                          ImageHelper(imageUrl: state.profile.data.profilePhoto)
                              .getNetworkImage(),
                    );
                  }

                  return Icon(Icons.person_outline_outlined);
                },
              )
            : Image.asset(path));
  }
}
