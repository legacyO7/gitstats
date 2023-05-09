import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/home_bloc.dart';
import 'package:gitstats/ui/home/home_event.dart';
import 'package:gitstats/utils/routes/routes_cubit.dart';

class HomeInput extends StatefulWidget {
  const HomeInput({Key? key}) : super(key: key);

  @override
  _HomeInputState createState() => _HomeInputState();
}

class _HomeInputState extends State<HomeInput> {

  late TextEditingController authorName;
  late TextEditingController repoName;

  @override
  void initState() {
    authorName=TextEditingController();
    repoName=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    authorName.dispose();
    repoName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: authorName,
              decoration: const InputDecoration(hintText: 'Author Name'),
            ),
          ),

          IntrinsicWidth(
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: repoName,
              decoration: const InputDecoration(hintText: 'Repository Name'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextButton(onPressed: (){
              context.read<HomeBloc>().add(HomeEventGetAuthorName(authorName.text));
            }, child: const Text("List Repositories")),
          ),


          ElevatedButton(onPressed: (){
            context.read<RouteCubit>().addRouteAndPush(routeName:"${authorName.text}/${repoName.text}", context: context);
          }, child: const Text("Check Stats")),

        ],
      ),
    );
  }
}
