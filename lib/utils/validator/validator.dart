import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/utils/constants.dart';
import 'package:gitstats/utils/routes/routes_cubit.dart';

class Validator extends StatefulWidget {
  Validator({Key? key,required this.route}) : super(key: key);
  String route;

  @override
  _ValidatorState createState() => _ValidatorState();
}

class _ValidatorState extends State<Validator> {
  
  @override
  void initState() {
    super.initState();
    validateRoute();
  }
  
  
  validateRoute(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.route.isNotEmpty) {
        context.read<RouteCubit>().addRouteAndPush(routeName: widget.route,context: context);
      }else{
        Navigator.pushNamed(context, '/');
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: Constants.scaffoldKey,
        body: const Center(child: Text("Validating URL..."),));
  }
}
