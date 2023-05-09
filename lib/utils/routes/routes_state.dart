import 'package:flutter/cupertino.dart';
import 'package:gitstats/ui/home/home_page.dart';
import 'package:gitstats/ui/stat_screen/stats_page.dart';

class RouteStates{
  Map<String, WidgetBuilder> routes={};

  RouteStates({required this.routes});

  factory RouteStates.init(){
    return RouteStates(routes:{'/':(_)=>const HomePage()});
  }

  RouteStates addRoute({required String routeName}){
    routes.addEntries(<String, WidgetBuilder>{routeName: (_) => const StatsPage()}.entries);
    return RouteStates(routes: routes);
  }

}