import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/home/home_widgets/home_input/home_input_event.dart';
import 'package:gitstats/ui/home/home_widgets/home_input/home_input_state.dart';

class HomeInputBloc extends Bloc<HomeInputEvent, HomeInputState>{
  HomeInputBloc():super(HomeInputState()){
   on<HomeInputEventOnChange>((event, emit) => _onChange(emit,
       isRepositoryFieldEmpty: event.isRepositoryFieldEmpty,
       isAuthorFieldEmpty: event.isAuthorFieldEmpty
   ));
  }

  _onChange(emit,{bool? isAuthorFieldEmpty, bool? isRepositoryFieldEmpty}){
    emit(state.setState(isAuthorFieldEmpty: isAuthorFieldEmpty,isRepositoryFieldEmpty: isRepositoryFieldEmpty));
  }
}