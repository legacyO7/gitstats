abstract class HomeEvent{}

class HomeEventRestore extends HomeEvent{}

class HomeEventSortByName extends HomeEvent{}
class HomeEventSortByStars extends HomeEvent{}
class HomeEventSortByWatchers extends HomeEvent{}
class HomeEventSortByForks extends HomeEvent{}

class HomeEventGetAuthorName extends HomeEvent{
  String authorName;
  HomeEventGetAuthorName(this.authorName);
}