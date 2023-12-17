import 'package:equatable/equatable.dart';

import '../models/categories_new_model.dart';
import '../models/news_channel_headlines_model.dart';

// Enum Status untuk menentukan status state
enum Status { initial, success, failure }

// Kelas NewsState yang meng-extend Equatable
class NewsState extends Equatable {
  // Properti-properti yang dimiliki oleh NewsState
  final Status status;
  final NewsChannelsHeadlinesModel? newsList;
  final String message;
  final Status categoriesStatus;
  final String categoriesMessage;
  final CategoriesNewsModel? newsCategoriesList;

  // Konstruktor untuk menginisialisasi NewsState dengan nilai default
  NewsState({
    this.status = Status.initial,
    this.categoriesStatus = Status.initial,
    this.categoriesMessage = '',
    this.message = '',
    NewsChannelsHeadlinesModel? newsList,
    CategoriesNewsModel? categoriesNewsModel,
  })  : newsList = newsList ?? NewsChannelsHeadlinesModel(),
        newsCategoriesList = categoriesNewsModel ?? CategoriesNewsModel();

  // Metode copyWith untuk membuat salinan state dengan nilai yang diperbarui
  NewsState copyWith({
    Status? status,
    NewsChannelsHeadlinesModel? newsList,
    String? message,
    CategoriesNewsModel? categoriesNewsModel,
    String? categoriesMessage,
    Status? categoriesStatus,
  }) {
    return NewsState(
      status: status ?? this.status,
      newsList: newsList ?? this.newsList,
      message: message ?? this.message,
      categoriesMessage: categoriesMessage ?? this.categoriesMessage,
      categoriesNewsModel: categoriesNewsModel ?? this.newsCategoriesList,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    );
  }

  // Metode toString untuk menghasilkan representasi string dari objek NewsState
  @override
  String toString() {
    return '''NewsState { status: $status, message: $message, categoriesStatus: $categoriesStatus, categoriesMessage: $categoriesMessage }''';
  }

  // Metode get props dari Equatable untuk mendefinisikan properti yang digunakan dalam pembandingan objek
  @override
  List<Object?> get props =>
      [status, newsList, message, categoriesStatus, categoriesMessage, newsCategoriesList];
}
