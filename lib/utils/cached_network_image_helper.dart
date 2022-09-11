import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';

class ImageHelper {
  final String? imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final bool? isRectangle;
  ImageHelper({
    this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.height,
    this.width,
    this.isRectangle,
  });

  Widget getCachedImage() => SizedBox(
        height: height ?? 32,
        width: width ?? 32,
        child: CachedNetworkImage(
          // maxWidthDiskCache: 100,
          // maxHeightDiskCache: 100,
          // memCacheHeight: 100,
          // memCacheWidth: 100,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              placeholder ??
              Center(
                child: CircularProgressIndicator(
                  color: AppColors.darkBlue,
                ),
              ),
          errorWidget: (context, url, error) =>
              errorWidget ?? Icon(Icons.error),
          imageUrl: imageUrl ?? "",
          // imageUrl: "$imageUrl?v=${UniqueKey()}",
          imageBuilder: (context, imageProvider) => Container(
            width: width ?? 32,
            height: height ?? 32,
            decoration: BoxDecoration(
              shape: isRectangle != null && isRectangle == true
                  ? BoxShape.rectangle
                  : BoxShape.circle,
              image: DecorationImage(
                  image: imageProvider,
                  fit: isRectangle != null && isRectangle == true
                      ? BoxFit.contain
                      : BoxFit.cover),
            ),
          ),
        ),
      );

  Widget getNetworkImage() {
    return Container(
      key: ValueKey(Random().nextInt(100)),
      height: height ?? 32,
      width: width ?? 32,
      decoration: BoxDecoration(
        shape: isRectangle != null && isRectangle == true
            ? BoxShape.rectangle
            : BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(imageUrl ?? ""),
            fit: isRectangle != null && isRectangle == true
                ? BoxFit.fill
                : BoxFit.cover),
      ),
    );
  }
}
