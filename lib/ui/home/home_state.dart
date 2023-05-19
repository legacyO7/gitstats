import 'package:gitstats/ui/home/models/repository_list_with_author.dart';

abstract class HomeState{}

class HomeStateInit extends HomeState{}

class HomeStateisLoading extends HomeState{}

class HomeStateRepoList extends HomeState{
  RepositoryListWithAuthor repositoryListWithAuthor;
  bool sortNameByAscendingOrder=true;
  bool sortStarByAscendingOrder=true;
  bool sortWatchersByAscendingOrder=true;
  bool sortForksByAscendingOrder=true;

  HomeStateRepoList(
      {required this.repositoryListWithAuthor,
      this.sortNameByAscendingOrder=true,
      this.sortStarByAscendingOrder=true,
      this.sortWatchersByAscendingOrder=true,
      this.sortForksByAscendingOrder=true
      });
}