class StatListModel{
  
  List<RepositoryStatModel>? repositoryStatList;
  StatListModel({this.repositoryStatList});

  factory StatListModel.fromJson(List<dynamic> json){
    return StatListModel(repositoryStatList: json.map((e) => RepositoryStatModel.fromJson(e)).toList());
  }

}

class RepositoryStatModel{

  String? name;
  String? tag;
  String? id;
  bool? preRelease;
  List<RepositoryAssetModel>? repositoryAsset;
  RepositoryAuthorModel? repositoryAuthorModel;
  String? publishedAt;

  RepositoryStatModel({
    this.name, 
    this.tag,
    this.preRelease,
    this.repositoryAsset,
    this.repositoryAuthorModel,
    this.id,
    this.publishedAt
  });

  factory RepositoryStatModel.fromJson(Map<String,dynamic> json){
    return RepositoryStatModel(
      id: json['id'].toString(),
      name: json['name']??'-',
      tag: json['tag_name']??'-',
      preRelease: json['prerelease']??'-',
      publishedAt: json['published_at']??'',
      repositoryAsset: (json['assets'] as List<dynamic>).map((e) => RepositoryAssetModel.fromJson(e)).toList(),
      repositoryAuthorModel: RepositoryAuthorModel.fromJson(json['author'])
    );
  }

}

class RepositoryAuthorModel{
  String? name;
  String? avatarUrl;

  RepositoryAuthorModel({this.name, this.avatarUrl});

  factory RepositoryAuthorModel.fromJson(Map<String, dynamic> json)=>
      RepositoryAuthorModel(
          name: json['login'],
          avatarUrl: json['avatar_url']
      );
}

class RepositoryAssetModel{
  String? id;
  String? name;
  int? size;
  int? downloads;
  String? url;
  String? updatedAt;

  RepositoryAssetModel({this.id, this.name, this.size, this.downloads, this.url,this.updatedAt});

  factory RepositoryAssetModel.fromJson(Map<String, dynamic> json){
    return RepositoryAssetModel(
      id: json['id'].toString(),
      name: json['name']??'-',
      size: json['size']??0,
      url: json['browser_download_url']??'-',
      downloads: json['download_count']??0,
      updatedAt: json['updated_at']??''
    );
  }


}