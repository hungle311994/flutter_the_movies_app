import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/configs/config.dart';

class ImageItem extends StatelessWidget {
  ImageItem({
    Key? key,
    this.path,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
  }) : super(key: key);

  String? path;
  double? width = 140;
  double? height = 250;
  double? borderRadius = 8;
  BoxFit? fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color(AppColor.noImageBackground),
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
      child: path != null
          ? CachedNetworkImage(
              imageUrl: _imagePath(path!).replaceAll('https', 'http'),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              child: Image.asset(
                'assets/images/picture_not_available.png',
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  String _imagePath(String path) {
    return '${apiImage(path)}';
  }
}
