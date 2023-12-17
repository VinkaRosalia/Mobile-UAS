import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  String newsImage;
  String newsTitle;
  String newsDate;
  String newsAuthor;
  String newsDesc;
  String newsContent;
  String newsSource;

  // Konstruktor untuk menginisialisasi data berita
  NewsDetailScreen(
      this.newsImage, this.newsTitle, this.newsDate, this.newsAuthor, this.newsDesc, this.newsContent, this.newsSource);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  void initState() {
    // Metode ini dipanggil saat widget pertama kali dibuat
    // TODO: implement initState
    super.initState();
    print(widget.newsDesc);
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar dan tinggi layar
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    
    // Parsing tanggal dari string ke objek DateTime
    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      // AppBar dengan tata letak dan gaya yang sesuai
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // Kembali ke halaman sebelumnya saat tombol kembali ditekan
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[600],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              // Container untuk menampilkan gambar berita
              height: Kheight * 0.45,
              width: Kwidth,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: "${widget.newsImage}",
                  fit: BoxFit.cover,
                  // Menampilkan indikator loading selama gambar dimuat
                  placeholder: (context, url) => CircularProgressIndicator(),
                  // Menampilkan ikon error jika gambar gagal dimuat
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Kheight * 0.4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            height: Kheight * 0.6,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                // Judul berita dengan gaya teks yang sesuai
                Text('${widget.newsTitle}',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: Kheight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          // Nama sumber berita
                          '${widget.newsSource}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      // Format tanggal berita
                      '${format.format(dateTime)}',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                // Deskripsi berita
                Text('${widget.newsDesc}',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                // Konten berita (dikomentari sementara)
                // Text('${widget.newsContent}',
                //     maxLines: 20,
                //     style: GoogleFonts.poppins(
                //         fontSize: 15,
                //         color: Colors.black87,
                //         fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
