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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String route=ModalRoute.of(context)!.settings.name!;
      if(route.startsWith('/')){
        route=route.substring(1,route.length);
      }

      if(route.contains('/')) {
        context.read<StatsBloc>().add(StatsEventFetchStats(
            author: route.split('/')[0],
            repositoryName: route.split('/')[1]
        ));
      }else{
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: IconButton(icon: const Icon(Icons.home_filled),onPressed: (){
          Navigator.pushReplacementNamed(context, '/');
        },)),
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
            return StatsListWidget(statList: state.statList);
          }

          return  Container();
        },));
  }
}
