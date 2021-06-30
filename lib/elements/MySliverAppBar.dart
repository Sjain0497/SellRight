import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         'assets/splash_screen.png',
        //       ),
        //       fit: BoxFit.cover,
        //     ),
        //     /* color: Theme.of(context).accentColor*/
        //   ),
        // ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "About SellRight App",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        // Positioned(
        //   top: expandedHeight / 2 - shrinkOffset,
        //   left: MediaQuery.of(context).size.width / 3,
        //   child: Opacity(
        //     opacity: (1 - shrinkOffset / expandedHeight),
        //     child: Card(
        //       color: Colors.transparent,
        //       elevation: 10,
        //       child: SizedBox(
        //         height: MediaQuery.of(context).size.height / 6,
        //         width: MediaQuery.of(context).size.width / 4,
        //         child: Image.asset(
        //           'assets/logo.png',
        //           width: 60,
        //           fit: BoxFit.contain,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
