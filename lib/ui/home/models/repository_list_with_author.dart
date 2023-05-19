import 'package:gitstats/ui/home/models/repository_list_model.dart';

class RepositoryListWithAuthor{
  RepositoryListModel repositoryListModel;
  String author;

  RepositoryListWithAuthor({required this.repositoryListModel, required this.author});
}