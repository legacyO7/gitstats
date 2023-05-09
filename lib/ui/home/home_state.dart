import 'package:gitstats/ui/home/models/repository_list_model.dart';

abstract class HomeState{}

class HomeStateInit extends HomeState{}

class HomeStateisLoading extends HomeState{}

class HomeStateRepoList extends HomeState{
  RepositoryListModel repoListModel;
  HomeStateRepoList(this.repoListModel);
}