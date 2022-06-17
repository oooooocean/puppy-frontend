import 'package:flutter/material.dart';
import 'package:frontend/components/comps/circle_avatar_button.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_action.dart';
import 'package:frontend/pages/post/list/post_list_controller.dart';
import 'package:frontend/pages/post/views/post_description_tile.dart';
import 'package:frontend/pages/post/views/post_list_action_bar.dart';
import 'package:frontend/pages/post/views/post_list_header.dart';
import 'package:frontend/pages/post/views/post_photos_tile.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostListTile extends GetView<PostListController> with LoadImageMixin {
  final Post post;
  final space = const SizedBox(height: 5);
  final ValueSetter<Post> onTap;

  PostListTile({Key? key, required this.post, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(post),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [space, _headerItem, space, _descriptionItem, space, _photosItem, _panel],
          ),
        ),
      ),
    );
  }

  Widget get _headerItem => PostListHeader(post: post);

  Widget get _descriptionItem => PostDescriptionTile(
      description: post.description, topics: post.topics, onTap: (topic) => controller.onTapTopic(post, topic));

  Widget get _photosItem => PostPhotosTile(photos: post.medias, onTap: (index) => controller.onTapPhoto(post, index));

  Widget get _panel => PostListActionBar(post: post);
}
