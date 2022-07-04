import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/pages/post/add/location/post_location.dart';
import 'package:frontend/pages/post/add/location/post_location_controller.dart';
import 'package:frontend/pages/post/add/post_add.dart';
import 'package:frontend/pages/post/add/post_add_controller.dart';
import 'package:frontend/pages/post/add/topic/topic_list.dart';
import 'package:frontend/pages/post/add/topic/topic_list_controller.dart';
import 'package:frontend/pages/post/browser/media_browser.dart';
import 'package:frontend/pages/post/comment/post_comment.dart';
import 'package:frontend/pages/post/comment/post_comment_controller.dart';
import 'package:frontend/pages/post/detail/post_detail.dart';
import 'package:frontend/pages/post/detail/post_detail_controller.dart';
import 'package:frontend/pages/post/report/post_report_controller.dart';
import 'package:frontend/pages/post/report/post_report_page.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'browser/media_browser_controller.dart';

final postRoutes = [
  GetPage(
      name: AppRoutes.postAdd,
      page: () => const PostAddPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PostAddController()))),
  GetPage(
      name: AppRoutes.postDetail,
      page: () => PostDetailPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PostDetailController(Get.arguments)))),
  GetPage<PostTopic>(
      fullscreenDialog: true,
      name: AppRoutes.postTopicList,
      page: () => const PostTopicListPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PostTopicListController()))),
  GetPage<PostTopic>(
      fullscreenDialog: true,
      name: AppRoutes.postLocation,
      page: () => const PostLocationPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PostLocationController()))),
  GetPage<bool>(
      fullscreenDialog: true,
      opaque: false,
      name: AppRoutes.postComment,
      page: () => const PostCommentPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PostCommentController(Get.arguments)))),
  GetPage(
      fullscreenDialog: true,
      opaque: false,
      name: AppRoutes.mediaBrowser,
      page: () => const MediaBrowserPage(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => MediaBrowserController(Get.arguments.first, Get.arguments.second)))),
  GetPage(
      name: AppRoutes.postReport,
      page: () =>  PostReportPage(),
      binding:
      BindingsBuilder(() => Get.lazyPut(() => PostReportController()))),
];
