import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/home_bloc.dart';
import 'package:gitstats/ui/home/home_event.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String formattedDateTime({String? dateTime}){
  if(dateTime==null|| dateTime.isEmpty){
    return '-';
  }
  return DateFormat('hh:mm a dd MMM yyyy').format(DateTime.parse(dateTime));
}

Future<void> openUrl(url) async {
  if (!await launchUrl(url is Uri? url: Uri.parse(url) )) {
    throw Exception('Could not launch $url');
  }
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

AppBar appBar(BuildContext context,{required String title, bool refresh=true})=>AppBar(
    title: Text(title),
    centerTitle: true,
    leading: IconButton(icon:  Icon(refresh?Icons.home_filled:Icons.arrow_back_ios),onPressed: (){
      if(ModalRoute.of(context)?.settings.name=='/'&&refresh){
        context.read<HomeBloc>().add(HomeEventRestore());
      }else{
        Navigator.pushReplacementNamed(context, '/');
      }
     },
    ));
