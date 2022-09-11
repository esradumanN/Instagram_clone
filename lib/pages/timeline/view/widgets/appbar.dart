import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../main.dart';
import '../../../../utils/locator.dart';
import '../../../auth/repository/auth_repository.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        color: AppColors.appbar,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(children: [
                sizeHelper.sbw(15),
                Image.asset("assets/icons/private.png"),
                sizeHelper.sbw(5),
                Text(
                  _authRepository.auth!.data.name +
                      "_" +
                      _authRepository.auth!.data.surname,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: sizeHelper.getHeight(15)),
                  overflow: TextOverflow.clip,
                ),
                sizeHelper.sbw(5),
                Image.asset("assets/icons/account_list.png"),
              ]),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Image.asset("assets/icons/add_icon.png"),
                sizeHelper.sbw(5),
                Image.asset("assets/icons/like_icon.png"),
                sizeHelper.sbw(5),
                Image.asset("assets/icons/messenger_icon.png"),
                sizeHelper.sbw(15),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(sizeHelper.size!.width, 60);
}
