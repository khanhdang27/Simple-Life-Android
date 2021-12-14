import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/app_route.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.pinkLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavigationItem(
            icon: AppIcon.home,
            title: AppLocalizations.t(context, 'home'),
            route: AppRoute.home,
          ),
          NavigationItem(
            icon: AppIcon.heart,
            title: AppLocalizations.t(context, 'myList'),
            route: AppRoute.favorite,
          ),
          NavigationItem(
            icon: AppIcon.dollar,
            title: AppLocalizations.t(context, 'purchaseHistory'),
            route: AppRoute.order,
          ),
          NavigationItem(
            icon: AppIcon.user,
            title: AppLocalizations.t(context, 'accountSettings'),
            route: AppRoute.user,
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const NavigationItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)!.settings.name;
    return InkWell(
      onTap: () {
        if (route != currentRoute) {
          if (appNavigatorObserver.routeStack.contains(route)) {
            Navigator.popUntil(context, ModalRoute.withName(route));
          } else {
            Navigator.pushNamed(context, route);
          }
        } else {
          if (currentRoute == AppRoute.home) {
            AppBloc.viewBloc.add(ViewHome());
          }
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(icon, size: 25),
          Text(
            title,
            style: TextStyle(
              fontWeight: AppFont.wRegular,
              fontFamily: AppFont.madeTommySoft,
            ),
          ),
          Container(
            width: 5.0,
            height: 5.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: route == currentRoute
                  ? AppColor.whiteMain
                  : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
