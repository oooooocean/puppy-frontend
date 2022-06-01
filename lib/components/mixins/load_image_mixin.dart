import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin LoadImageMixin {
  Image buildAssetImage(String name, {double? width, BoxFit fit = BoxFit.fitWidth}) =>
      Image.asset('assets/images/$name.png', width: width, fit: fit);

  buildNetImage(String url,
      {BoxFit fit = BoxFit.fitWidth, double? width, double? height, Alignment alignment = Alignment.center}) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => const Center(child: CupertinoActivityIndicator()),
      errorWidget: (_, __, ___) => const Center(child: Icon(Icons.error, size: 20.0)),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
