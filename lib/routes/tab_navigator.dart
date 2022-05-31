import 'package:ecotone_app/routes/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/color_detail_page.dart';
import 'package:ecotone_app/routes/colors_list_page.dart';
import 'package:ecotone_app/routes/tab_item.dart';


class TabNavigatorRoutes {
  static const String map = '/';
  static const String checklist= '/checklist';
  static const String help= '/help';


}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.map]!(context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.map: (context) => ColorsListPage(
        color: activeTabColor[tabItem]!,
        title: tabName[tabItem]!,
        onPush: (materialIndex) =>
            _push(context, materialIndex: materialIndex),
      ),
      TabNavigatorRoutes.checklist: (context) => ColorsListPage(
        color: activeTabColor[tabItem]!,
        title: tabName[tabItem]!,
        onPush: (materialIndex) =>
            _push(context, materialIndex: materialIndex),
      ),
      TabNavigatorRoutes.help: (context) => ColorsListPage(
        color: activeTabColor[tabItem]!,
        title: tabName[tabItem]!,
        onPush: (materialIndex) =>
            _push(context, materialIndex: materialIndex),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.map,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}