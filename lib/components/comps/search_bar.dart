import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';

class SAppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  SAppBarSearch({
    Key? key,
    this.borderRadius = 20,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    required this.height,
    this.value,
    this.leading,
    this.suffix,
    this.actions,
    this.hintText,
    this.onTap,
    this.onClear,
    this.onCancel,
    this.onChanged,
    this.onSearch,
  }) : super(key: key);

  late double? borderRadius;
  late bool? autoFocus;
  late FocusNode? focusNode;
  late TextEditingController? controller;

  // 输入框高度 默认40
  final double height;

  // 默认值
  final String? value;

  // 最前面的组件
  late final Widget? leading;

  // 搜索框后缀组件
  late final Widget? suffix;
  final List<Widget>? actions;

  // 提示文字
  final String? hintText;

  // 输入框点击
  late final VoidCallback? onTap;

  // 单独清除输入框内容
  late final VoidCallback? onClear;

  // 清除输入框内容并取消输入
  late final VoidCallback? onCancel;

  // 输入框内容改变
  late final ValueChanged? onChanged;

  // 点击键盘搜索
  late final ValueChanged? onSearch;

  @override
  _SAppBarSearchState createState() => _SAppBarSearchState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SAppBarSearchState extends State<SAppBarSearch> with ThemeMixin {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isInput = false;

  bool get isFocus => _focusNode.hasFocus;

  bool get isTextEmpty => _controller.text.isEmpty;

  bool get isActionEmpty => widget.actions?.isEmpty ?? true;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.value != null) _controller.text = widget.value!;
    // 监听输入框状态
    _focusNode.addListener(() => setState(() {}));
    // 监听输入框变化
    // 解决当外部改变输入框内容时 控件处于正确的状态中 (显示清除图标按钮和取消按钮等)
    _controller.addListener(() {
      setState(() {});
      widget.onChanged?.call(_controller.text);
    });
    super.initState();
  }

  // 清除输入框内容
  void _onClearInput() {
    _controller.clear();
    if (!isFocus) _focusNode.requestFocus();
    setState(() {});
    widget.onClear?.call();
  }

  // 取消输入框编辑
  void _onCancelInput() {
    _controller.clear();
    _focusNode.unfocus();
    setState(() {});
    widget.onCancel?.call();
  }

  Widget _suffix() {
    if (!isTextEmpty) {
      return GestureDetector(
        onTap: _onClearInput,
        child: SizedBox(
          width: widget.height,
          height: widget.height,
          child: Icon(Icons.cancel, size: 22, color: kGreyColor),
        ),
      );
    }
    return widget.suffix ?? const SizedBox();
  }

  List<Widget> _actions() {
    List<Widget> list = [];
    if (isFocus || !isTextEmpty) {
      list.add(GestureDetector(
        onTap: _onCancelInput,
        child: Container(
          constraints: BoxConstraints(minWidth: 48),
          alignment: Alignment.center,
          child: Text(
            '取消',
            style: TextStyle(color: kSecondaryTextColor, fontSize: 15),
          ),
        ),
      ));
    } else if (!isActionEmpty) {
      list.addAll(widget.actions!);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    // final bool canPop = parentRoute?.canPop ?? false;
    final bool canPop = true;
    double left = !canPop ? 15 : 0;
    double right = isActionEmpty && !isFocus && isTextEmpty ? 15 : 0;
    return AppBar(
      titleSpacing: 0,
      leading: isFocus ? const SizedBox() : widget.leading,
      leadingWidth: isFocus ? 15 : kToolbarHeight,
      title: Container(
        margin: EdgeInsets.only(right: right, left: left),
        height: widget.height,
        decoration: BoxDecoration(
          color: kBorderColor,
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        child: Row(
          children: [
            SizedBox(
              width: widget.height,
              height: widget.height,
              child: Icon(Icons.search, size: 22, color: kShapeColor),
            ),
            Expanded(
              child: TextField(
                autofocus: widget.autoFocus!,
                focusNode: _focusNode,
                controller: _controller,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: widget.hintText ?? '请输入关键字',
                  hintStyle:
                      TextStyle(fontSize: 15, color: kSecondaryTextColor),
                ),
                style: TextStyle(
                    fontSize: 15, color: kPrimaryTextColor, height: 1.3),
                textInputAction: TextInputAction.search,
                onTap: widget.onTap,
                onSubmitted: widget.onSearch,
              ),
            ),
            _suffix(),
          ],
        ),
      ),
      actions: _actions(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
