import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:gitstats/ui/stat_screen/stats_bloc.dart';
import 'package:gitstats/utils/routes/routes_cubit.dart';
import 'package:gitstats/utils/routes/routes_state.dart';
import 'package:gitstats/utils/validator/validator.dart';

import 'ui/home/home_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const GitStats());
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page not found')),
      body: Center(
        child: Text('Sorry, the requested page was not found.'),
      ),
    );
  }
}


class GitStats extends StatelessWidget {
  const GitStats({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => StatsBloc()),
        BlocProvider(create: (_)=>RouteCubit())
      ],
      child: BlocBuilder<RouteCubit,RouteStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
          title: 'Git Stats',
          theme: ThemeData.dark(),
          routes: state.routes,
          onGenerateInitialRoutes: (route){
            return [
              MaterialPageRoute(builder: (_)=>Validator(route: route) )
            ];
          },
          onUnknownRoute: (RouteSettings settings) =>
                MaterialPageRoute(builder: (context) => NotFoundPage()),
          );
        },

      ),
    );
  }
}
