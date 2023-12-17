import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/news_bloc.dart';
import 'package:flutter_news_app/bloc/news_event.dart';
import 'package:flutter_news_app/bloc/news_states.dart';
import 'package:flutter_news_app/view/cateogires_screen.dart';
import 'package:flutter_news_app/view/home/widgets/headlines_widget.dart';
import 'package:flutter_news_app/view/home/widgets/home_app_bar_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Indikator loading dengan tata letak dan gaya yang sudah ditentukan
const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50.0,
);

class _HomeScreenState extends State<HomeScreen> {
  // Objek untuk memformat tanggal
  final format = DateFormat('MMMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi untuk mengambil berita utama dan kategori berita saat layar diinisialisasi
    context.read<NewsBloc>()..add(FetchNewsChannelHeadlines('bbc-news'));
    context.read<NewsBloc>()..add(NewsCategories('general'));
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar dan tinggi layar
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      // AppBar yang diinginkan dengan tata letak yang sudah ditentukan
      appBar: PreferredSize(
        preferredSize: Size(0, 59),
        child: HomeAppBarWidget(),
      ),
      body: ListView(
        children: [
          // Bagian Berita Utama (Headlines)
          SizedBox(
            height: height * .55,
            width: width,
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (BuildContext context, state) {
                print(state);
                switch (state.status) {
                  case Status.initial:
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  case Status.failure:
                    return Text(state.message.toString());
                  case Status.success:
                    return ListView.builder(
                      itemCount: state.newsList!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(state
                            .newsList!.articles![index].publishedAt
                            .toString());
                        return HeadlinesWidget(
                          dateAndTime: format.format(dateTime),
                          index: index,
                        );
                      },
                    );
                }
              },
            ),
          ),

          // Bagian Kategori Berita
          Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (BuildContext context, state) {
                switch (state.categoriesStatus) {
                  case Status.initial:
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  case Status.failure:
                    return Text(state.categoriesMessage.toString());
                  case Status.success:
                    return ListView.builder(
                      itemCount: state.newsCategoriesList!.articles!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(state
                            .newsCategoriesList!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              // Gambar Berita
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: state.newsCategoriesList!
                                      .articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                  placeholder: (context, url) => Container(
                                    child: Center(
                                      child: SpinKitCircle(
                                        size: 50,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),

                              // Detail Berita
                              Expanded(
                                child: Container(
                                  height: height * .18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      // Judul Berita
                                      Text(
                                        state.newsCategoriesList!
                                            .articles![index].title
                                            .toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Spacer(),
                                      // Sumber dan Tanggal
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              state
                                                  .newsCategoriesList!
                                                  .articles![index]
                                                  .source!
                                                  .name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// Indikator loading dengan tata letak dan gaya yang sudah ditentukan
const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
