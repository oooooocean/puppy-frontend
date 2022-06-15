import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/media.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostPhotosTileConfiguration {
  int crossAxisCount = 0;
  BoxFit fit = BoxFit.cover;
  double widthRadio = 1;

  PostPhotosTileConfiguration(int photoCount) {
    switch (photoCount) {
      case 1:
        crossAxisCount = 1;
        fit = BoxFit.contain;
        widthRadio = 0.65;
        break;
      case 2:
      case 4:
        crossAxisCount = 2;
        widthRadio = 0.65;
        fit = BoxFit.cover;
        break;
      default:
        crossAxisCount = 3;
        widthRadio = 1;
        fit = BoxFit.cover;
    }
  }
}

class PostPhotosTile extends StatelessWidget with LoadImageMixin {
  final List<Media> photos;
  final void Function(int) onTap;
  final PostPhotosTileConfiguration configuration;

  PostPhotosTile({Key? key, required this.photos, required this.onTap})
      : configuration = PostPhotosTileConfiguration(photos.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photos.length == 1) {
      return _buildSingleImage();
    } else {
      return _buildImageList();
    }
  }

  Widget _buildImage(
          {required Media photo,
          required int index,
          required BoxFit fit,
          required int width,
          Alignment alignment = Alignment.center}) =>
      InkWell(
        onTap: () => onTap(index),
        child: Hero(
          tag: photo.key,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(3.toPadding)),
            child: buildNetImage(photo.thumbnailUrl(width: width), fit: configuration.fit, alignment: alignment),
          ),
        ),
      );

  Widget _buildSingleImage() {
    double width = (Get.width - 2 * kDefaultPadding) * configuration.widthRadio;
    final image = _buildImage(
        photo: photos.first, index: 0, fit: configuration.fit, width: width.toInt(), alignment: Alignment.centerLeft);

    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(width, width * 1.2)),
      child: image,
    );
  }

  Widget _buildImageList() {
    final width = (Get.width - 30) * configuration.widthRadio;
    final imageWidth = width ~/ 4;

    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size.fromWidth(width)),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: photos.length,
        itemBuilder: (_, index) => SizedBox.expand(
            child: _buildImage(photo: photos[index], index: index, fit: configuration.fit, width: imageWidth)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: configuration.crossAxisCount, crossAxisSpacing: 4, mainAxisSpacing: 4),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
