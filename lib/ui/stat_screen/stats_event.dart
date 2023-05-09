abstract class StatsEvent{}

class StatsEventFetchStats extends StatsEvent{
  String author;
  String repositoryName;
  int pageCount=0;
  int maxCount=10;

  StatsEventFetchStats({
    required this.author,
    required this.repositoryName,
    this.pageCount=0,
    this.maxCount=5
  });
}