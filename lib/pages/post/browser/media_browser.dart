import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/media.dart';
import 'package:get/get.dart';
import 'media_browser_controller.dart';

// ignore: depend_on_referenced_packages
import 'package:extended_image/extended_image.dart';
import 'package:frontend/components/extension/int_extension.dart';

class MediaBrowserPage extends GetView<MediaBrowserController> {
  const MediaBrowserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dialogBackgroundColor: kBlackColor),
      child: ExtendedImageSlidePage(
        child: ExtendedImageGesturePageView.builder(
            itemBuilder: _itemBuilder,
            itemCount: controller.medias.length,
            onPageChanged: (index) {
              controller.index = index;
              controller.update([index.toString()]);
            },
            controller: ExtendedPageController(initialPage: controller.index, pageSpacing: 5.toPadding)),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final media = controller.medias[index];

    final image = ExtendedImage(
        image: CachedNetworkImageProvider(media.url),
        fit: BoxFit.contain,
        mode: ExtendedImageMode.gesture,
        initGestureConfigHandler: (_) => GestureConfig(inPageView: true),
        enableSlideOutPage: true);
    final gestureWrap = GestureDetector(
        onTap: () => Get.back(),
        onLongPress: () => Get.bottomSheet(buildBottomSheet(media), backgroundColor: const Color(0xfff6f5ec)),
        child: image);
    return GetBuilder<MediaBrowserController>(
        id: index.toString(),
        builder: (_) => controller.index == index ? Hero(tag: media.key, child: gestureWrap) : gestureWrap);
  }

  Widget buildBottomSheet(Media media) => Padding(
        padding: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            top: kDefaultPadding,
            bottom: Get.mediaQuery.viewPadding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              TextButton(
                  onPressed: controller.saveToAlbum(media),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(8.toPadding),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.toPadding))),
                      child: Icon(Icons.save_alt_outlined, size: 30.toPadding),
                    ),
                    SizedBox(height: 3.toPadding),
                    const Text(
                      '保存',
                      style: TextStyle(fontSize: kSmallFont),
                    )
                  ]))
            ]),
            SizedBox(height: kSpacePadding),
            PuppyButton(
              onPressed: () => Get.back(),
              style: PuppyButtonStyle.style3,
              buttonStyle: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(Get.width, 44.toPadding)),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              child: const Text('取消'),
            )
          ],
        ),
      );
}
