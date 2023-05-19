import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/home_bloc.dart';
import 'package:gitstats/ui/home/home_state.dart';
import 'package:gitstats/ui/home/home_widgets/home_repo_list.dart';

import 'home_widgets/home_input/home_input_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}


class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state){

        if(state is HomeStateInit){
          return const HomeInput();
        }

        if(state is HomeStateRepoList){
          return HomeRepoList(repositoryListWithAuthor: state.repositoryListWithAuthor);
        }

        if(state is HomeStateisLoading){
          return const Center(child: CircularProgressIndicator());
        }

        return Container();
      }),
    );
  }

}