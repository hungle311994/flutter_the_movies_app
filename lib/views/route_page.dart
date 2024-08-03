import 'package:flutter/material.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/views/home_page.dart';
import 'package:the_movie_app/views/movie/movie_page.dart';
import 'package:the_movie_app/views/tv/tv_page.dart';
import 'package:the_movie_app/views/wish_list/wish_list_page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const RoutePage(),
    );
  }

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final _controller = ScrollController();
  int _tabIndex = 0;
  final _pages = [
    const HomePage(),
    const MoviePage(),
    const TVPage(),
    const WishListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color(AppColor.background),
      body: SafeArea(
        child: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: SliverAppBar(
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        appTitle(),
                        GestureDetector(
                          onTap: () async {
                            await navToAccountPage(context: context);
                          },
                          child: Icon(
                            Icons.menu,
                            size: 30,
                            color: color(AppColor.lightGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: _pages[_tabIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: color(AppColor.defaultText),
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 24,
          backgroundColor: color(AppColor.background),
          unselectedItemColor: color(AppColor.brightGrey),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: color(AppColor.primary),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: color(AppColor.brightGrey),
          ),
          currentIndex: _tabIndex,
          onTap: _onTapBottomNavigationBarItem,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.home,
                  color: _tabIndex == 0
                      ? color(AppColor.primary)
                      : color(AppColor.brightGrey),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.movie,
                  color: _tabIndex == 1
                      ? color(AppColor.primary)
                      : color(AppColor.brightGrey),
                ),
              ),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.tv,
                  color: _tabIndex == 2
                      ? color(AppColor.primary)
                      : color(AppColor.brightGrey),
                ),
              ),
              label: 'TV Shows',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.bookmark_added,
                  color: _tabIndex == 3
                      ? color(AppColor.primary)
                      : color(AppColor.brightGrey),
                ),
              ),
              label: 'Wishlist',
            ),
          ],
        ),
      ),
    );
  }

  void _onTapBottomNavigationBarItem(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
