abstract class HomeInputEvent{}

class HomeInputEventOnChange extends HomeInputEvent{
  bool? isAuthorFieldEmpty;
  bool? isRepositoryFieldEmpty;

  HomeInputEventOnChange({this.isAuthorFieldEmpty, this.isRepositoryFieldEmpty});
}