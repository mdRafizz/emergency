import 'package:emergency/views/home/home_main.dart';
import 'package:emergency/views/login/login_main.dart';
import 'package:emergency/views/profile/profile_main.dart';
import 'package:emergency/views/signup/signup_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRoutes {
  static const String _home = '/';
  static const String _logIn = '/12500emer1og1n';
  static const String _signUp = '/12500emer5ign9p';
  // static const String _categorizedPost = '/categorizedPost';
  // static const String _categorizedNote = '/categorizedNote';
  // static const String _allCircular = '/allCircular';
  static const String _profile = '/12500emeP4line';
  // static const String _shareNotes = '/shareNotes';
  // static const String _search = '/search';
  // static const String _downloadScreen = '/downloadScreen';
  // static const String _noInternet = '/noInternet';

  static String get home => _home;

  static String get login => _logIn;

  static String get signup => _signUp;

  // static String get categorizedPost => _categorizedPost;
  //
  // static String get allCircular => _allCircular;
  //
  static String get profile => _profile;
  //
  // static String get categorizedNote => _categorizedNote;
  //
  // static String get shareNotes => _shareNotes;
  //
  // static String get search => _search;
  //
  // static String get downloadScreen => _downloadScreen;
  //
  // static String get noInternet => _noInternet;

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: home,
        page: () => const HomeMain(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 550),
      ),
      GetPage(
        name: login,
        page: () => const LoginMain(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 550),
      ),
      GetPage(
        name: signup,
        page: () => const SignUpMain(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 550),
      ),
      // GetPage(
      //   name: categorizedPost,
      //   page: () => const CategorizedPostsScreen(),
      //   transition: Transition.fade,
      //   transitionDuration: const Duration(milliseconds: 550),
      // ),
      // GetPage(
      //   name: categorizedNote,
      //   page: () => CategorizedNotesScreen(
      //     title: Get.arguments as String,
      //   ),
      //   transition: Transition.fade,
      //   transitionDuration: const Duration(milliseconds: 550),
      // ),
      // GetPage(
      //   name: allCircular,
      //   page: () => const CircularMain(),
      //   transition: Transition.fade,
      //   transitionDuration: const Duration(milliseconds: 550),
      // ),
      GetPage(
        name: profile,
        page: () => const ProfileMain(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 550),
      ),
      // GetPage(
      //   name: shareNotes,
      //   page: () => const UploadNotes(),
      //   transition: Transition.fade,
      //   transitionDuration: const Duration(milliseconds: 550),
      // ),
      // GetPage(
      //   name: search,
      //   page: () => const SearchMain(),
      //   transition: Transition.fade,
      //   transitionDuration: const Duration(milliseconds: 550),
      // ),
      // GetPage(
      //   name: downloadScreen,
      //   page: () => DownloadScreen(
      //     fileDoc: Get.arguments as List<String>,
      //   ),
      //   transition: Transition.fade,
      //   transitionDuration: const Duration(milliseconds: 550),
      // ),
      // GetPage(
      //   name: noInternet,
      //   page: () => const NoInternetMain(),
      //   transition: Transition.noTransition,
      //   // transitionDuration: const Duration(milliseconds: 550),
      // ),
    ];
  }
}
