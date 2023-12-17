import 'package:bloc/bloc.dart';
import 'package:flutter_news_app/bloc/news_event.dart';
import 'package:flutter_news_app/bloc/news_states.dart';
import 'package:flutter_news_app/repository/news_repository.dart';

import '../models/categories_new_model.dart';
import '../models/news_channel_headlines_model.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository postRepository = NewsRepository();

  // Konstruktor NewsBloc, inisialisasi state awal dan mendefinisikan aksi untuk setiap event
  NewsBloc() : super(NewsState()) {
    on<FetchNewsChannelHeadlines>(fetchChannelNews); // Menangani event FetchNewsChannelHeadlines
    on<NewsCategories>(fetchNewsCategoires); // Menangani event NewsCategories
  }

  // Metode untuk mengambil berita dari suatu channel
  Future<void> fetchChannelNews(
      FetchNewsChannelHeadlines event, Emitter<NewsState> emit) async {
    emit(state.copyWith(status: Status.initial)); // Mengupdate status state menjadi initial

    // Mengambil data berita dari repository
    await postRepository
        .fetchNewsChannelHeadlinesApi(event.channelId)
        .then((value) {
      // Jika berhasil, mengupdate state dengan data yang diterima
      emit(state.copyWith(
          status: Status.success, newsList: value, message: 'success'));
    }).onError((error, stackTrace) {
      // Jika terjadi error, mengupdate state dengan status failure dan pesan error
      emit(state.copyWith(
          categoriesStatus: Status.failure,
          categoriesMessage: error.toString()));
    });
  }

  // Metode untuk mengambil kategori berita
  Future<void> fetchNewsCategoires(
      NewsCategories event, Emitter<NewsState> emit) async {
    emit(state.copyWith(status: Status.initial)); // Mengupdate status state menjadi initial

    // Mengambil data kategori berita dari repository
    await postRepository.fetchNewsCategoires(event.category).then((value) {
      // Jika berhasil, mengupdate state dengan data yang diterima
      emit(state.copyWith(
          categoriesStatus: Status.success,
          categoriesNewsModel: value,
          categoriesMessage: 'success'));
    }).onError((error, stackTrace) {
      // Jika terjadi error, mengupdate state dengan status failure dan pesan error
      emit(state.copyWith(
          categoriesStatus: Status.failure,
          categoriesMessage: error.toString()));
      emit(state.copyWith(status: Status.failure, message: error.toString()));
    });
  }
}
