import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/home_bloc.dart';
import 'package:gitstats/ui/home/home_event.dart';
import 'package:gitstats/utils/constants.dart';
import 'package:gitstats/utils/routes/routes_cubit.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      validateRoute();
    });
  }
  
  validateRoute(){
      if(widget.route.isNotEmpty&&widget.route!='/') {
        context.read<RouteCubit>().addRouteAndPush(routeName: widget.route,context: context);
      }else{
        context.read<HomeBloc>().add(HomeEventRestore());
        Navigator.pushNamed(context, '/');
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return  VisibilityDetector(
      key: const Key('git-stats'),
      onVisibilityChanged: (VisibilityInfo info){
        if(!info.visibleBounds.isEmpty){
          validateRoute();
        }
      },
      child: Scaffold(
          key: Constants.scaffoldKey.currentState==null?Constants.scaffoldKey:null,
          body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text("Validating URL"),
                Container(
                    width: MediaQuery.of(context).size.width/10,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const LinearProgressIndicator())
              ],
            ),
          )),
    );
  }
}
