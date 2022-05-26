import 'package:flutter/material.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DebugState();
}

class _DebugState extends State<DebugPage> with NetMixin {
  void test() async {
    const config = AssetPickerConfig(maxAssets: 2, requestType: RequestType.image);
    final files = await AssetPicker.pickAssets(context, pickerConfig: config);
    final results = await uploadImages(files!);
    print(results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [IconButton(onPressed: test, icon: const Icon(Icons.local_laundry_service, size: 40))],
            )));
  }
}
