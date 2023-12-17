import 'package:equatable/equatable.dart';

// Kelas abstrak NewsEvent yang meng-extend Equatable
abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Kelas FetchNewsChannelHeadlines yang merupakan turunan dari NewsEvent
class FetchNewsChannelHeadlines extends NewsEvent {
  final String channelId;

  // Konstruktor untuk menginisialisasi FetchNewsChannelHeadlines dengan channelId
  FetchNewsChannelHeadlines(this.channelId);
}

// Kelas NewsCategories yang merupakan turunan dari NewsEvent
class NewsCategories extends NewsEvent {
  final String category;

  // Konstruktor untuk menginisialisasi NewsCategories dengan category
  NewsCategories(this.category);
}
