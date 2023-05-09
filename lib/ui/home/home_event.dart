abstract class HomeEvent{}

class HomeEventRestore extends HomeEvent{}

class HomeEventGetAuthorName extends HomeEvent{
  String authorName;
  HomeEventGetAuthorName(this.authorName);
}