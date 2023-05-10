abstract class StatsEvent{}

class StatsEventFetchStats extends StatsEvent{
  String author;
  String repositoryName;

  StatsEventFetchStats({
    required this.author,
    required this.repositoryName
  });
}

class StatsEventLoadMore extends StatsEvent{}