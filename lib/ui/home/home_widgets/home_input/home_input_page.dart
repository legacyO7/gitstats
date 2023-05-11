import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/home_bloc.dart';
import 'package:gitstats/ui/home/home_event.dart';
import 'package:gitstats/ui/home/home_widgets/home_input/home_input_bloc.dart';
import 'package:gitstats/ui/home/home_widgets/home_input/home_input_event.dart';
import 'package:gitstats/ui/home/home_widgets/home_input/home_input_state.dart';
import 'package:gitstats/utils/routes/routes_cubit.dart';

class HomeInput extends StatefulWidget {
  const HomeInput({Key? key}) : super(key: key);

  @override
  _HomeInputState createState() => _HomeInputState();
}

class _HomeInputState extends State<HomeInput> {

  late TextEditingController authorName;
  late TextEditingController repositoryName;

  @override
  void initState() {
    authorName=TextEditingController();
    repositoryName=TextEditingController();
    context.read<HomeInputBloc>().add(HomeInputEventOnChange(
      isAuthorFieldEmpty: true,
      isRepositoryFieldEmpty: true
    ));
    super.initState();
  }

  @override
  void dispose() {
    authorName.dispose();
    repositoryName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeInputBloc, HomeInputState>(
      builder: (BuildContext context, state)=> Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntrinsicWidth(
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: authorName,
                decoration: const InputDecoration(hintText: 'Author Name'),
                onChanged: (_)=>context.read<HomeInputBloc>().add(HomeInputEventOnChange(
                  isAuthorFieldEmpty: authorName.text.isEmpty
                )),
              ),
            ),

            if(!state.isAuthorFieldEmpty!)
            Column(
              children: [
                IntrinsicWidth(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: repositoryName,
                    decoration: const InputDecoration(hintText: 'Repository Name'),
                    onChanged: (_)=>context.read<HomeInputBloc>().add(HomeInputEventOnChange(
                        isRepositoryFieldEmpty: repositoryName.text.isEmpty
                    )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child:
                    !state.isAuthorFieldEmpty!?
                  TextButton(onPressed: (){
                    if(authorName.text.isNotEmpty) {
                      context.read<HomeBloc>().add(HomeEventGetAuthorName(authorName.text.trim()));
                    }
                  }, child: const Text("List Repositories")):null,
                ),


                if(!state.isRepositoryFieldEmpty!)
                ElevatedButton(onPressed: (){
                  if(authorName.text.isNotEmpty&&repositoryName.text.isNotEmpty) {
                    context.read<RouteCubit>().addRouteAndPush(routeName:"${authorName.text.trim()}/${repositoryName.text.trim()}", context: context);
                  }
                }, child: const Text("Check Stats")),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
