import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:frontend/components/extension/int_extension.dart';

/// 从图片库中选择头像
class PuppyAvatarButton extends StatefulWidget {
  final ValueSetter<AssetEntity> didSelected;
  final String? defaultAvatar;

  const PuppyAvatarButton(
      {Key? key, required this.didSelected, this.defaultAvatar})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PuppyAvatarState();
}

class _PuppyAvatarState extends State<PuppyAvatarButton>
    with ThemeMixin, LoadImageMixin {
  AssetEntity? avatar;
  final avatarWidth = 80.0;

  choseAvatar() async {
    final config = AssetPickerConfig(
        selectedAssets: avatar != null ? [avatar!] : null,
        maxAssets: 1,
        requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(context, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    setState(() => avatar = results.first);
    widget.didSelected(results.first);
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: choseAvatar,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(const CircleBorder()),
          side: MaterialStateProperty.all(
              BorderSide(color: kBorderColor, width: 3.toPadding)),
        ),
        child: _avatar);
  }

  Widget get _avatar => avatar == null
      ? _defaultAvatar
      : _buildImageItem(
          Image(image: AssetEntityImageProvider(avatar!), fit: BoxFit.cover));

  Widget get _defaultAvatar => widget.defaultAvatar != null
      ? _buildImageItem(buildNetImage(widget.defaultAvatar!))
      : const Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(Icons.camera_alt_rounded,
              size: 40, color: kSecondaryTextColor),
        );

  Widget _buildImageItem(Widget image) => AspectRatio(
      aspectRatio: 1.0,
      child: Padding(
          padding: EdgeInsets.all(3.toPadding), child: ClipOval(child: image)));
}
