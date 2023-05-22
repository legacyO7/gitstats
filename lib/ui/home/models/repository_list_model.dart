class RepositoryListModel{

  List<RepositoryDetailsModel>? repoDetailsList;

  RepositoryListModel({this.repoDetailsList});

  factory RepositoryListModel.fromJson(List<dynamic> json){
   return RepositoryListModel(repoDetailsList: json.map((value) => RepositoryDetailsModel.fromJson(value)).toList());
  }

}
class RepositoryDetailsModel{
  String? name;
  String? fullName;
  String? id;
  int? stars;
  int? watchers;
  int? forks;
  String? htmlUrl;

  RepositoryDetailsModel({this.name, this.id, this.stars, this.watchers, this.forks, this.fullName, this.htmlUrl});

  factory RepositoryDetailsModel.fromJson(Map<String, dynamic> json){
   return RepositoryDetailsModel(
      id: json['id'].toString(),
      name: json['name']??'-',
      fullName: json['full_name']??'',
      stars: json['stargazers_count']??'-',
      watchers: json['watchers']??'-',
      forks: json['forks']??'-',
      htmlUrl: json['html_url']??'-'
    );
  }

}
