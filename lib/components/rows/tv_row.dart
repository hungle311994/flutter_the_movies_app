import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/dialog.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/models/tv/tv.dart';
import 'package:the_movie_app/providers/tv_provider.dart';
import 'package:the_movie_app/providers/wish_list_provider.dart';
import 'package:the_movie_app/views/tv/tv_detail.page.dart';

class TVRow extends StatefulHookWidget {
  const TVRow({
    Key? key,
    required this.title,
    required this.tvs,
    this.isFromDetail = false,
  }) : super(key: key);

  final String title;
  final List<TV> tvs;
  final bool isFromDetail;

  @override
  _TVRowState createState() => _TVRowState();
}

class _TVRowState extends State<TVRow> {
  @override
  Widget build(BuildContext context) {
    final _tvs = widget.tvs;
    final _tvWishList = useProvider(tvWishListProvider);

    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(text: widget.title, size: 18),
          hSpace(10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _tvs.length,
              itemBuilder: (context, index) {
                final _tvAdded = _tvWishList.firstWhere(
                  (item) => item.id == _tvs[index].id,
                  orElse: () => TV(id: null),
                );
                return _card(
                  id: _tvs[index].id ?? 0,
                  path: _tvs[index].posterPath,
                  mediaType: _tvs[index].mediaType ?? MediaTypeEnum.tv,
                  tvAdded: _tvAdded,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({
    required MediaTypeEnum mediaType,
    required int id,
    String? path,
    TV? tvAdded,
  }) {
    return Container(
      width: 140,
      margin: marginRight2,
      child: GestureDetector(
        onTap: () async {
          await EasyLoading.show(maskType: EasyLoadingMaskType.black);
          final _result =
              await context.read(tvDetailProvider.notifier).getTVDetail(id);

          if (widget.isFromDetail == true) {
            Navigator.pop(context);
          }

          if (_result) {
            final _isBack = await Navigator.push<bool>(
              context,
              PageTransition(
                child: TVDetailPage(id: id),
                type: PageTransitionType.rightToLeft,
              ),
            );

            if (_isBack == true) {
              setState(() {});
            }
          } else {
            await showErrorDlg(
              title: errorMessageSomethingHappened,
              context: context,
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ImageItem(path: path),
                  if (tvAdded?.id != null) ...[
                    Container(
                      decoration: BoxDecoration(
                        gradient: gradientColorBlurTop,
                      ),
                      child: SizedBox(width: 140, height: 35),
                    ),
                    Icon(
                      Icons.bookmark,
                      color: color(AppColor.primary),
                      size: 30,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
