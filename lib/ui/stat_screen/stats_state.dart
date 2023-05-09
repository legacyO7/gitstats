import 'package:gitstats/ui/stat_screen/models/stat_list_model.dart';

abstract class StatsState{}

class StatsStateInit extends StatsState{}

class StatsStateOnError extends StatsState{}

class StatsStateList extends StatsState{
  StatListModel statList;

  StatsStateList(this.statList);
}

