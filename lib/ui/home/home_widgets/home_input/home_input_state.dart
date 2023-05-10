class HomeInputState{
  bool? isAuthorFieldEmpty;
  bool? isRepositoryFieldEmpty;
  HomeInputState({this.isAuthorFieldEmpty=true, this.isRepositoryFieldEmpty=true});
  
  HomeInputState setState({
    bool? isAuthorFieldEmpty,
    bool? isRepositoryFieldEmpty
  }){    
  return HomeInputState(
      isAuthorFieldEmpty: isAuthorFieldEmpty??this.isAuthorFieldEmpty,
      isRepositoryFieldEmpty:isRepositoryFieldEmpty??this.isRepositoryFieldEmpty
    );
  }
}