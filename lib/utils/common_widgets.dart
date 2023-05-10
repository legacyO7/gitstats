import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formattedDateTime({String? dateTime}){
  if(dateTime==null|| dateTime.isEmpty){
    return '-';
  }
  return DateFormat('hh:mm a dd MMM yyyy').format(DateTime.parse(dateTime));
}


Widget listItem({required String text, int flex=1,bool isHeading=false}){
  return Expanded(
      flex: flex,
      child: Text(text,style: TextStyle(
          fontWeight: isHeading?FontWeight.w700:FontWeight.w500,
          fontSize: isHeading?20:14
      ),));
}

Widget emptyData()=>
    const Center(child: Text("No Data"));
