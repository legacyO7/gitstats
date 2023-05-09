import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/models/repository_list_model.dart';
import 'package:gitstats/utils/dio_handler.dart';
import 'package:gitstats/ui/home/home_event.dart';
import 'package:gitstats/ui/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc() : super(HomeStateInit()){
    on<HomeEventGetAuthorName>((event, emit) => _getRepoList(author: event.authorName,emit));
    on<HomeEventRestore>((_, emit) => emit(HomeStateInit()));
  }

  DioHandler dioHandler=DioHandler();
  
  Future _getRepoList(emit,{required String author}) async{
   emit(HomeStateisLoading());
   await dioHandler.invokeApi<RepositoryListModel>(path:  'users/$author/repos',
      fromJsonToList: RepositoryListModel.fromJson
   ).then((value){
     value.fold((l) {
      emit(HomeStateInit());
     }, (r){
       emit(HomeStateRepoList(r));
     });
   });
  }
}