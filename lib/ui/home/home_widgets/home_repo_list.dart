
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/home_bloc.dart';
import 'package:gitstats/ui/home/home_event.dart';
import 'package:gitstats/ui/home/home_state.dart';
import 'package:gitstats/ui/home/models/repository_list_model.dart';
import 'package:gitstats/ui/home/models/repository_list_with_author.dart';
import 'package:gitstats/utils/common_widgets.dart';
import 'package:gitstats/utils/routes/routes_cubit.dart';

class HomeRepoList extends StatefulWidget {
  final RepositoryListWithAuthor repositoryListWithAuthor;

  const HomeRepoList({
    Key? key,
    required this.repositoryListWithAuthor
  }) : super(key: key);

  @override
  State<HomeRepoList> createState() => _HomeRepoListState();
}

class _HomeRepoListState extends State<HomeRepoList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state){
        if(state is HomeStateRepoList) {
          return  Scaffold(
          appBar: appBar(context, title: widget.repositoryListWithAuthor.author),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          listIconData(title: "Title", icon: Icons.title,flex: 2),
                          IconButton(onPressed:() => context.read<HomeBloc>().add(HomeEventSortByName()),
                              icon: Icon(state.sortNameByAscendingOrder?Icons.arrow_upward: Icons.arrow_downward))
                        ],
                      ),
                    ),Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listIconData(title: "Stars", icon: Icons.star),
                          IconButton(onPressed:() => context.read<HomeBloc>().add(HomeEventSortByStars()),
                              icon: Icon(state.sortStarByAscendingOrder?Icons.arrow_upward: Icons.arrow_downward))
                        ],
                      ),
                    ),Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listIconData(title: "Watchers", icon: Icons.remove_red_eye_outlined),
                          IconButton(onPressed:() => context.read<HomeBloc>().add(HomeEventSortByWatchers()),
                              icon: Icon(state.sortWatchersByAscendingOrder?Icons.arrow_upward: Icons.arrow_downward))
                        ],
                      ),
                    ),Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listIconData(title: "Forks", icon: Icons.fork_right),
                          IconButton(onPressed:() => context.read<HomeBloc>().add(HomeEventSortByForks()),
                              icon: Icon(state.sortForksByAscendingOrder?Icons.arrow_upward: Icons.arrow_downward))
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    )

                  ],
                ),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return listCard(context, repoDetailsModel: widget.repositoryListWithAuthor.repositoryListModel.repoDetailsList![index]);
                      },
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: widget.repositoryListWithAuthor.repositoryListModel.repoDetailsList!.length),
                ),
              ],
            ),
          ),
        );
        }

        return Container();
      }
    );
  }

  Widget listCard(BuildContext context,{required RepositoryDetailsModel repoDetailsModel}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: (){
              if(repoDetailsModel.fullName?.isNotEmpty??false) {
                context.read<RouteCubit>().addRouteAndPush(routeName: repoDetailsModel.fullName!, context: context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(repoDetailsModel.name!)),
                  Expanded(child: Text("${repoDetailsModel.stars!}",textAlign: TextAlign.center,)),
                  Expanded(child: Text( "${repoDetailsModel.watchers!}",textAlign: TextAlign.center,)),
                  Expanded(child: Text("${repoDetailsModel.forks!}",textAlign: TextAlign.center,)),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          iconSize: 15,
            onPressed: ()=> openUrl(repoDetailsModel.htmlUrl),
            icon: const Icon(Icons.open_in_new))
      ],
    );
  }

  Widget listIconData({required String title,int flex=1,required IconData icon}){
    double getWidth()=> ((MediaQuery.of(context).size.width));
    return Row(
          mainAxisAlignment: flex==1?  MainAxisAlignment.center: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5,),
            SizedBox(
              width: (getWidth()/90)*title.length,
              child:
              getWidth()>500?
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  title,
                  textAlign: TextAlign.justify,
                ),
              ):Icon(icon),
            ),
          ],
        );
  }
}