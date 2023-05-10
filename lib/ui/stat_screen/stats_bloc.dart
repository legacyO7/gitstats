import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/stat_screen/models/stat_list_model.dart';
import 'package:gitstats/ui/stat_screen/stats_event.dart';
import 'package:gitstats/ui/stat_screen/stats_state.dart';
import 'package:gitstats/utils/dio_handler.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState>{
  StatsBloc():super(StatsStateInit()){
    on<StatsEventFetchStats>((event, emit) async{
      clearAll();
      author=event.author;
      repositoryName=event.repositoryName;
      await loadStats(emit,stats: event);
    });
    on<StatsEventLoadMore>((_, emit) async => await _loadMore(emit));
  }
  
  DioHandler dioHandler=DioHandler();
  bool loadingMore=false;
  bool isLoading=false;
  int pageCount=1, maxCount=5;
  String author='';
  String repositoryName='';
  StatListModel _statList=StatListModel();



  Future loadStats(emit,{required StatsEventFetchStats stats}) async{
    if(_statList.repositoryStatList==null) {
      emit(StatsStateInit());
    }else{
      emit(StatsStateList(_statList,loadingMore: true));
    }
    await dioHandler.invokeApi<StatListModel>(
        path:'repos/${stats.author}/${stats.repositoryName}/releases?page=$pageCount&per_page=$maxCount',
        factory: StatListModel.fromJson
    ).then((value) {
      value.fold((l) {
        emit(StatsStateOnError());
      }, (r) {
        _statList.repositoryStatList==null? _statList.repositoryStatList=r.repositoryStatList!:
        _statList.repositoryStatList!.addAll(r.repositoryStatList!);
        emit(StatsStateList(_statList,loadMore: r.repositoryStatList?.length==maxCount));
      });
    });
    isLoading=false;
  }
  
  Future _loadMore(emit) async{
    if(isLoading) return;
    isLoading=true;
    pageCount+=1;
    await loadStats(emit, stats: StatsEventFetchStats(
        author: author,
        repositoryName: repositoryName,
    ));
    
  }

  clearAll(){
    pageCount=1;
    maxCount=5;
    author='';
    repositoryName='';
    isLoading=false;
    _statList=StatListModel();
    loadingMore=false;
  }



}