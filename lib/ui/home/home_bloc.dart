import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/models/repository_list_model.dart';
import 'package:gitstats/ui/home/models/repository_list_with_author.dart';
import 'package:gitstats/utils/dio_handler.dart';
import 'package:gitstats/ui/home/home_event.dart';
import 'package:gitstats/ui/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc() : super(HomeStateInit()){
    on<HomeEventGetAuthorName>((event, emit) => _getRepoList(author: event.authorName,emit));
    on<HomeEventRestore>((_, emit) => emit(HomeStateInit()));
    on<HomeEventSortByName>((event, emit) => _sortByName(emit));
    on<HomeEventSortByStars>((event, emit) => _sortByStars(emit));
    on<HomeEventSortByWatchers>((event, emit) => _sortByWatchers(emit));
    on<HomeEventSortByForks>((event, emit) => _sortByForks(emit));
  }

  DioHandler dioHandler=DioHandler();
  bool sortNameByAscendingOrder=true;
  bool sortStarByAscendingOrder=true;
  bool sortWatchersByAscendingOrder=true;
  bool sortForksByAscendingOrder=true;

  late RepositoryListWithAuthor  repositoryListWithAuthor;
  
  Future _getRepoList(emit,{required String author}) async{
   emit(HomeStateisLoading());
   await dioHandler.invokeApi<RepositoryListModel>(path:  'users/$author/repos',
      factory: RepositoryListModel.fromJson
   ).then((value){
     value.fold((l) {
      emit(HomeStateInit());
     }, (r){
       repositoryListWithAuthor=RepositoryListWithAuthor(repositoryListModel: r, author: author);
       _sortByName(emit);
     });
   });
  }

  _sortByName(emit){

    sortNameByAscendingOrder=!sortNameByAscendingOrder;

    if(sortNameByAscendingOrder) {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => a.fullName!.compareTo(b.fullName!),);
    } else {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => b.fullName!.compareTo(a.fullName!),);
    }

    emit(HomeStateRepoList(repositoryListWithAuthor: repositoryListWithAuthor,sortNameByAscendingOrder: sortNameByAscendingOrder));

  }

  _sortByStars(emit){

    sortStarByAscendingOrder=!sortStarByAscendingOrder;

    if(sortStarByAscendingOrder) {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => a.stars!.compareTo(b.stars!),);
    } else {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => b.stars!.compareTo(a.stars!),);
    }

    emit(HomeStateRepoList(repositoryListWithAuthor: repositoryListWithAuthor,sortStarByAscendingOrder: sortStarByAscendingOrder));

  }

  _sortByWatchers(emit){

    sortWatchersByAscendingOrder=!sortWatchersByAscendingOrder;

    if(sortWatchersByAscendingOrder) {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => a.watchers!.compareTo(b.watchers!),);
    } else {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => b.watchers!.compareTo(a.watchers!),);
    }

    emit(HomeStateRepoList(repositoryListWithAuthor: repositoryListWithAuthor,sortWatchersByAscendingOrder: sortWatchersByAscendingOrder));

  }

  _sortByForks(emit){

    sortForksByAscendingOrder=!sortForksByAscendingOrder;

    if(sortForksByAscendingOrder) {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => a.forks!.compareTo(b.forks!),);
    } else {
      repositoryListWithAuthor.repositoryListModel.repoDetailsList!.sort((a, b) => b.forks!.compareTo(a.forks!),);
    }

    emit(HomeStateRepoList(repositoryListWithAuthor: repositoryListWithAuthor,sortForksByAscendingOrder: sortForksByAscendingOrder));

  }

}