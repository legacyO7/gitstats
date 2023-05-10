
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/models/repository_list_model.dart';
import 'package:gitstats/utils/common_widgets.dart';
import 'package:gitstats/utils/routes/routes_cubit.dart';

class HomeRepoList extends StatelessWidget {
  final RepositoryListModel repoListModel;
  final String authorName;

  const HomeRepoList({
    Key? key,
    required this.repoListModel,
    required this.authorName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: authorName),
      body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return listCard(context, repoDetailsModel: repoListModel.repoDetailsList![index]);
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: repoListModel.repoDetailsList!.length),
    );
  }


  Widget listCard(BuildContext context,{required RepositoryDetailsModel repoDetailsModel}) {
    return InkWell(
      onTap: (){
        if(repoDetailsModel.fullName?.isNotEmpty??false) {
          context.read<RouteCubit>().addRouteAndPush(routeName: repoDetailsModel.fullName!, context: context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 3,child: Text(repoDetailsModel.name!)),
            listIconData(count: "${repoDetailsModel.stars!}", icon: Icons.star),
            listIconData(count: "${repoDetailsModel.watchers!}", icon: Icons.remove_red_eye_outlined),
            listIconData(count:"${repoDetailsModel.forks!}", icon: Icons.fork_right),
          ],
        ),
      ),
    );
  }

  Widget listIconData({required String count, required IconData icon}){
    return Flexible(
      child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 5,),
              Text(count)
            ],
          ),
    );
  }


}