import 'package:flutter/material.dart';
import 'package:gitstats/utils/constants.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({String? content}){
  return ScaffoldMessenger.of(Constants.scaffoldKey.currentState!.context).showSnackBar(
    SnackBar(
      content: SizedBox(
          height:Constants.scaffoldKey.currentContext!.size!.height/20,
          child: Center(child: Text(content??'Something went wrong!',
            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600) ,))),
      elevation: 3,
      backgroundColor: Colors.deepOrange,
    )
  );
}