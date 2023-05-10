import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/stat_screen/stats_bloc.dart';
import 'package:gitstats/ui/stat_screen/stats_event.dart';
import 'package:gitstats/ui/stat_screen/stats_state.dart';
import 'package:gitstats/ui/stat_screen/widgets/stats_list_widget.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  String repositoryName='';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String route=ModalRoute.of(context)!.settings.name!;
      if(route.startsWith('/')){
        route=route.substring(1,route.length);
      }

      if(route.contains('/')) {
        repositoryName= route.split('/')[1];
        context.read<StatsBloc>().add(StatsEventFetchStats(
            author: route.split('/')[0],
            repositoryName: repositoryName
        ));
      }else{
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<StatsBloc, StatsState>(
          listener: (context, state){
            if(state is StatsStateOnError){
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (context, state) {

          if(state is StatsStateInit){
            return const Center(child: CircularProgressIndicator());
          }

          if(state is StatsStateList){
            return StatsListWidget(title: repositoryName);
          }

          return  Container();
        },));
  }
}
