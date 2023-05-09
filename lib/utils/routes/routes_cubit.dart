import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/utils/routes/routes_state.dart';

class RouteCubit extends Cubit<RouteStates>{
  RouteCubit():super(RouteStates.init());

  addRoute({required String routeName}){
    if(!validateRoute(routeName)){
      emit(state.addRoute(routeName: routeName));
    }
  }

  bool validateRoute(String name){
    return state.routes.containsKey(name);
  }

  addRouteAndPush({required String routeName, required BuildContext context}){
    addRoute(routeName: routeName);
    Navigator.pushNamed(context, routeName);
  }



}