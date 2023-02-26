import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/extension/double_extension.dart';

/// 从图片库中选择头像
class PuppyAvatarButton extends StatefulWidget {
  final ValueSetter<AssetEntity> didSelected;
  final String? defaultAvatar;
  final int size;

  const PuppyAvatarButton(
      {Key? key, required this.didSelected, this.defaultAvatar, this.size = 80})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PuppyAvatarState();
}

class _PuppyAvatarState extends State<PuppyAvatarButton>
    with ThemeMixin, LoadImageMixin {
  AssetEntity? avatar;

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
    // 1. 使用SizedBox约束Image的原因:
    // OutlinedButton 使用 Align(1, 1) 来处理child, 即它会根据图片原始宽高比来为图片提供space.
    // 所以必须使用Size来约束child.
    // 2. 如果需要将Border设置到图片外:
    // - 使用 StrokeAlign.outside 并取消 OutlinedButton 的 clip, 否则 border 会被裁剪
    // - 使用 ClipOval 作为 child.
    return OutlinedButton(
        onPressed: choseAvatar,
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(const CircleBorder()),
          side: MaterialStateProperty.all(
              BorderSide(color: kBorderColor, width: 3.toPadding)),
        ),
        child: SizedBox(
            width: widget.size.toPadding,
            height: widget.size.toPadding,
            child: _avatar));
    /**
    return OutlinedButton(
        onPressed: choseAvatar,
        // clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(const CircleBorder()),
          side: MaterialStateProperty.all(
              BorderSide(color: kBorderColor, width: 3.toPadding, strokeAlign: StrokeAlign.outside)),
        ),
        child: ClipOval(child: SizedBox(
            width: widget.size.toPadding,
            height: widget.size.toPadding,
            child: _avatar)));
        */
  }

  Widget get _avatar => avatar == null
      ? _defaultAvatar
      : AssetEntityImage(avatar!, fit: BoxFit.cover);

  Widget get _defaultAvatar => widget.defaultAvatar != null
      ? buildNetImage(widget.defaultAvatar!)
      : const Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(Icons.camera_alt_rounded,
              size: 40, color: kSecondaryTextColor),
        );
}
