import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../main.dart';
import '../../../../utils/cached_network_image_helper.dart';
import '../../model/timeline.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TimelineElement item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: sizeHelper.getHeight(420),
        width: sizeHelper.size!.width,
        child: Column(
          children: [
            TitleView(item: item),
            SliderImage(item: item),
            DescriptionView(item: item)
          ],
        ));
  }
}

class DescriptionView extends StatelessWidget {
  const DescriptionView({
    Key? key,
    required this.item,
  }) : super(key: key);
  final TimelineElement item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: sizeHelper.size!.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                ImageHelper(imageUrl: item.images.first.url).getNetworkImage(),
                sizeHelper.sbw(5),
                Text("Liked by "),
                Text(
                  item.likes.first,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(" and "),
                Text(
                  "${item.likes.length} others",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

class SliderImage extends StatefulWidget {
  const SliderImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TimelineElement item;

  @override
  State<SliderImage> createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  var ind = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeHelper.getHeight(244),
          child: PageView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: widget.item.images.length,
            onPageChanged: (value) {
              setState(() {
                ind = value;
              });
            },
            itemBuilder: (context, index) {
              return ImageHelper(
                      imageUrl: widget.item.images[index].url,
                      isRectangle: true,
                      height: sizeHelper.getHeight(250),
                      width: sizeHelper.size!.width)
                  .getNetworkImage();
            },
          ),
        ),
        sizeHelper.sbw(10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Image.asset("assets/icons/Like.png"),
                    sizeHelper.sbw(10),
                    Image.asset("assets/icons/Comment.png"),
                    sizeHelper.sbw(10),
                    Image.asset("assets/icons/Messanger.png"),
                  ],
                ),
              ),
              widget.item.images.length > 1
                  ? SizedBox(
                      height: sizeHelper.getHeight(20),
                      width:
                          sizeHelper.getWidth(widget.item.images.length * 20),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.item.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeHelper.getHeight(7)),
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  color: ind == index
                                      ? AppColors.lightBlue
                                      : AppColors.grey,
                                  shape: BoxShape.circle),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox(),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/icons/Save.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TimelineElement item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: sizeHelper.getHeight(54),
      child: Row(
        children: [
          ImageHelper(imageUrl: item.images.first.url).getNetworkImage(),
          sizeHelper.sbw(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.username,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: sizeHelper.getHeight(15)),
              ),
              Text(
                item.location,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: sizeHelper.getHeight(12)),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.more_horiz)
        ],
      ),
    );
  }
}
