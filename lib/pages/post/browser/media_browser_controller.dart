import 'package:frontend/models/media.dart';
import 'package:get/get.dart';

class MediaBrowserController extends GetxController {
  final List<Media> medias;
  int index;

  MediaBrowserController(this.medias, this.index);

  saveToAlbum(Media media) {}
}