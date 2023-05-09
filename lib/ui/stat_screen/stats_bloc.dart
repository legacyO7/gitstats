import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/stat_screen/models/stat_list_model.dart';
import 'package:gitstats/ui/stat_screen/stats_event.dart';
import 'package:gitstats/ui/stat_screen/stats_state.dart';
import 'package:gitstats/utils/dio_handler.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState>{
  StatsBloc():super(StatsStateInit()){
    on<StatsEventFetchStats>((event, emit) => loadStats(emit,stats: event));
  }
  
  DioHandler dioHandler=DioHandler();


  Future loadStats(emit,{required StatsEventFetchStats stats}) async{
    emit(StatsStateInit());    
    await dioHandler.invokeApi<StatListModel>(
        path:'repos/${stats.author}/${stats.repositoryName}/releases?page=${stats.pageCount}&per_page=${stats.maxCount}',
        fromJsonToList: StatListModel.fromJson
    ).then((value) {
      value.fold((l) {
        emit(StatsStateOnError());
      }, (r) {
        emit(StatsStateList(r));
      });
    });
    
  }



}