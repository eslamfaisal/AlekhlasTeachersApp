import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/routs/routs_names.dart';
import 'package:alekhlas_teachers/screens/navigation/widgets/drawer_item_widget.dart';
import 'package:alekhlas_teachers/screens/navigation/widgets/pop_up_item.dart';
import 'package:alekhlas_teachers/services/navigation_service.dart';
import 'package:alekhlas_teachers/services/shared_pref_services.dart';
import 'package:alekhlas_teachers/utils/colors.dart';
import 'package:alekhlas_teachers/utils/constants.dart';
import 'package:alekhlas_teachers/utils/shared_preferences_constants.dart';
import '../../../locator.dart';
import '../navigation_index.dart';

class NavigationContainer extends StatefulWidget {
  final Widget child;
  final int initialIndex;

  NavigationContainer(this.child, this.initialIndex);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = new TabController(
        vsync: this, length: 11, initialIndex: widget.initialIndex)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.green),
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/images/Rahwan-logo.png'),
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                tr('app_name'),
                style: TextStyle(
                  fontSize: 24,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          SizedBox(width: 16),
          PopupMenuButton(
            tooltip: tr('settings'),
            icon: SizedBox(
              height: 50,
              width: 50,
              child: Icon(
                Icons.settings,
              ),
            ),
            itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                child: PopUpItemWidget(tr('settings'), Icons.account_circle),
                value: tr('settings'),
              ),
              PopupMenuItem<String>(
                child: PopUpItemWidget(
                    '${tr('current_language') == 'ar' ? "English" : 'عربي'}',
                    Icons.language),
                value: tr('change_language_string_key'),
              ),
              PopupMenuItem<String>(
                child: PopUpItemWidget(tr('logout'), Icons.logout),
                value: tr('logout'),
              ),
            ],
            onSelected: (selected) async {
              if (selected == tr('logout')) {
                await locator<SharedPrefServices>()
                    .saveBoolean(LOGGED_IN, false);
                locator<NavigationService>()
                    .navigateToAndClearStack(RouteName.SPLASH);
              } else if (selected == tr('change_language_string_key')) {
                if (context.locale == Locale('ar', 'EG'))
                  context.setLocale(Locale('en', 'US'));
                else
                  context.setLocale(Locale('ar', 'EG'));
              }
            },
          ),
          SizedBox(width: 16),
        ],
        // automaticallyImplyLeading: false,
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                    margin: EdgeInsets.all(0),
                    height: MediaQuery.of(context).size.height,
                    width: 300,
                    color: Colors.white,
                    child: getMenuItemsWidget(),
                  ),
                ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: widget.child,
          )
        ],
      ),
      drawer: Padding(
        padding: EdgeInsets.only(top: 56),
        child: Drawer(
          child: getMenuItemsWidget(),
        ),
      ),
    );
  }

  Widget getMenuItemsWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        listDrawerItems(),
      ],
    );
  }

  Widget listDrawerItems() {
    return ListView(
      physics: BouncingScrollPhysics(),
      // shrinkWrap: true,
      children: <Widget>[
        DrawerItemWidget(
          DASHBOARD,
          tr("dashboard"),
          tabController!.index == HOME_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>()
                .navigateToAndClearStack(RouteName.HOME);
          },
          Icon(
            Icons.home,
            color: primaryColor,
            size: 26,
          ),
        ),
        DrawerItemWidget(
          ADS_VIEW,
          tr("families"),
          tabController!.index == FAMILIES_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>().navigateToAndClearStack(RouteName.FAMILIES);
          },
          Icon(
            Icons.supervised_user_circle,
            color: primaryColor,
            size: 26,
          ),
        ),
        DrawerItemWidget(
          WORKERS_VIEW,
          tr("teachers"),
          tabController!.index == TEACHERS_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>()
                .navigateToAndClearStack(RouteName.TEACHERS);
          },
          Icon(
            Icons.supervised_user_circle_outlined,
            color: primaryColor,
            size: 26,
          ),
        ),
        DrawerItemWidget(
          SYSTEM_USERS_VIEW,
          tr("system_users"),
          tabController!.index == SYSTEM_USERS_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>()
                .navigateToAndClearStack(RouteName.SYSTEM_USERS);
          },
          Icon(
            Icons.admin_panel_settings,
            color: primaryColor,
            size: 26,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }
}
