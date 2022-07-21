part of 'pages.dart';

abstract class AppRoutes {
  static const debug = '/debug';

  static const login = '/login';
  static const loginSetPassword = '/login/setPassword';
  static const loginResetPassword = '/login/resetPassword';
  static const launchServiceFlow = '/login/launchService';

  static const scaffold = '/scaffold';
  static const registerFlow = '/register/flow';

  static const userInfoAdd = '/user/info/add';
  static const userInfoEdit = '/user/info/edit';
  static const userSetting = '/user/setting';
  static const feedback = '/user/setting/feedback';
  static const userCenter = '/user/center';
  static const loginUserCenter = '/loginUser/center';

  static const petAdd = '/pet/add';
  static const petCategory = '/pet/category';
  static const postAdd = '/post/add';
  static const postDetail = '/post/detail';
  static const postTopicList = '/post/topic/list';
  static const postLocation = '/post/location';
  static const postComment = '/post/comment';

  static const choseIdol = '/idol/chose';

  static const mediaBrowser = '/media/browser';
}
