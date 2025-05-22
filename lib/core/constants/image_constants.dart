// ignore_for_file: constant_identifier_names

class AppImages {
  /// IMAGES
  static const String applogo = "assets/images/applogo.png";
  static const String image_placeholder = "assets/images/image_placeholder.png";
  static const String no_data_blue = "assets/images/no_data_blue.png";
  static const String no_data_orange = "assets/images/no_data_orange.png";
  static const String no_data_red = "assets/images/no_data_red.png";
  static const String no_internet_earthwifi = "assets/images/no_internet_earthwifi.png";
  static const String no_internet_galaxy = "assets/images/no_internet_galaxy.png";
  static const String no_internet_menwifi = "assets/images/no_internet_menwifi.png";
  static const String user_placeholder = "assets/images/user_placeholder.png";
  static const String ic_company_logo = "assets/images/ic_company_logo.png";
  static const String icon_edit = "assets/images/icon_edit.png";
  static const String avatar = "assets/images/avatar.png";
  static const String imgSplash = "assets/images/img_splach.png";

  /// GIFS
  static const String loading_shimmer = "assets/images/loading_shimmer.gif";
  static const String success = "assets/images/success.gif";

  /// Demo Image

  static const String ic_demo_img = "assets/images/ic_demo_img.png";
}

class AppIcons {
  /// ADD ICONS AS PER YOUR NEED
  ///
  static const String demoIcon = "assets/icons/demoIcon.png";
  static const String ic_login_top = "assets/icons/ic_login_top.png";
  static const String ic_appLogo_top = "assets/icons/app_icon.png";
  // static const String ic_app_logo_top = "assets/icons/ic_app_icon-2.png";
  static const String ic_app_logo_top = "assets/icons/ic_app_icon.png";
  static const String ic_no_data = "assets/icons/ic_no_data.png";
  static const String logoSvg = "assets/svg_icons/logo_svg.svg";
  static const String ic_eye = "assets/icons/ic_eye.svg";
  static const String ic_more = "assets/icons/ic_more_menu.png";
  static const String ic_search = "assets/icons/ic_search.svg";
  static const String ic_location = "assets/icons/ic_location.svg";
  static const String ic_more_icon = "assets/icons/ic_more_icon.png";
  static const String ic_home = "assets/icons/ic_home.svg";
  static const String ic_completed_oval = "assets/icons/ic_completed_oval.svg";
  static const String ic_pending_oval = "assets/icons/ic_pending_oval.svg";
  static const String ic_clock = "assets/icons/ic_clock.svg";
  static const String ic_visits = "assets/icons/ic_visits.png";
  static const String ic_start_rec = "assets/icons/ic_start_rec.svg";
  static const String ic_signature = "assets/icons/ic_signature.svg";
  static const String ic_microphone = "assets/icons/ic_microphone_icon.svg";
  static const String ic_thankYou = "assets/icons/img_thankyou!.svg";
  static const String ic_sucess = "assets/icons/ic_sucess.svg";
}

enum SvgIcons {
  clock,
  alert,
  cycle,
  ear,
  glasses,
  walk,
  pen,
  location,
  fluent,
  phone,
  bathroom,
  dressing,
  hydration,
  showering,
  notification,
  home,
  logo_svg

  ;

  String get path => "assets/svg_icons/$name.svg";

}