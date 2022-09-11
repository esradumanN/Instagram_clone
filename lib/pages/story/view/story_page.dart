import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone/core/constants/app_colors.dart';
import 'package:instagram_clone/pages/profile/repository/profile_repository.dart';
import 'package:instagram_clone/utils/locator.dart';

import '../../../main.dart';
import '../../../utils/cached_network_image_helper.dart';

ProfileRepository _profileRepository = locator<ProfileRepository>();
TextEditingController _controller = TextEditingController();

class StoryPage extends StatefulWidget {
  const StoryPage({super.key, required this.stories});
  final List<String> stories;
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;

  int _currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);
    _loadStory(story: widget.stories.first, animateToPage: false);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.stories.length) {
            _currentIndex += 1;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            Navigator.pop(context);
            _currentIndex = 0;
            _loadStory(story: widget.stories[_currentIndex]);
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, story),
        child: Stack(
          children: [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: widget.stories.length,
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                return CachedNetworkImage(
                  imageUrl: story,
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                  children: widget.stories
                      .asMap()
                      .map((key, value) {
                        return MapEntry(
                            key,
                            AnimatedBar(
                              animationController: _animationController,
                              currentIndex: _currentIndex,
                              position: key,
                            ));
                      })
                      .values
                      .toList()),
            ),
            Positioned(
              top: 60,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  ImageHelper(
                          imageUrl:
                              _profileRepository.profile!.data.profilePhoto)
                      .getNetworkImage(),
                  sizeHelper.sbw(10),
                  Text(
                    _profileRepository.profile!.data.username,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: sizeHelper.getHeight(15)),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: sizeHelper.getHeight(40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: _controller,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration.collapsed(
                              hintText: 'Send Message',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  sizeHelper.sbw(10),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: sizeHelper.getHeight(30),
                      ),
                      sizeHelper.sbw(10),
                      RotationTransition(
                          turns: AlwaysStoppedAnimation(310 / 360),
                          child: Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                            size: sizeHelper.getHeight(30),
                          )),
                      sizeHelper.sbw(5),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTapDown(TapDownDetails details, String story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > screenWidth * 2 / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.stories.length) {
          _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
        } else {
          _currentIndex = 0;
          Navigator.pop(context);

          // _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else {}
  }

  void _loadStory({required String story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = Duration(seconds: 3);
    _animationController.forward();

    if (animateToPage) {
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar(
      {super.key,
      required this.animationController,
      required this.position,
      required this.currentIndex});

  final AnimationController animationController;
  final int position;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5)),
              position == currentIndex
                  ? AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return _buildContainer(
                            constraints.maxWidth * animationController.value,
                            Colors.white);
                      },
                    )
                  : SizedBox.shrink(),
            ],
          );
        },
      ),
    ));
  }

  _buildContainer(double width, Color color) {
    return Container(
      height: 5,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black26, width: 0.8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
