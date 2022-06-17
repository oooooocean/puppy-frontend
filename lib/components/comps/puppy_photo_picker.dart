import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PuppyPhotoPicker extends StatefulWidget {
  final int limit;
  final double height;

  const PuppyPhotoPicker({Key? key, required this.limit, this.height = 90}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PuppyPhotoState();
}

class _PuppyPhotoState extends State<PuppyPhotoPicker> {
  List<AssetEntity> _photos = [];
  List<Widget> _children = [];

  _chosePhoto() async {
    final config = AssetPickerConfig(
        selectedAssets: _photos, maxAssets: widget.limit, specialPickerType: SpecialPickerType.wechatMoment);
    final results = await AssetPicker.pickAssets(context, pickerConfig: config);
    if (results == null) return;
    _photos = results;
    _refresh();
  }

  _removePhoto(AssetEntity entity) {
    _photos.remove(entity);
    _refresh();
  }

  _refresh() {
    _children = _photos.map((e) => _buildItem(_buildImageItem(e))).toList();
    if (_children.length < widget.limit) {
      _children.add(_addButton);
    }
    setState(() => _children);
  }

  @override
  void initState() {
    _children.add(_addButton);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.toPadding,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => _children[index],
            separatorBuilder: (_, __) => SizedBox(width: 5.toPadding),
            itemCount: _children.length));
  }

  Widget get _addButton => _buildItem(TextButton(
      onPressed: _chosePhoto,
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kShapeColor)),
      child: Icon(Icons.add, color: kGreyColor, size: 35.toPadding)));

  Widget _buildItem(Widget child) => AspectRatio(
      aspectRatio: 1, child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(5.toPadding)), child: child));

  Widget _buildImageItem(AssetEntity entity) => Stack(fit: StackFit.expand, children: [
        Image(image: AssetEntityImageProvider(entity), fit: BoxFit.cover),
        Positioned(
            top: 3.toPadding,
            right: 3.toPadding,
            child: GestureDetector(
                onTap: () => _removePhoto(entity),
                child: const Icon(Icons.highlight_remove_outlined, color: Colors.white)))
      ]);
}
