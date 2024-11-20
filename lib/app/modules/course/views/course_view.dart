import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'course_detail_view.dart';

class CourseView extends StatelessWidget {
  final stt.SpeechToText _speech = stt.SpeechToText(); // Inisialisasi STT
  final TextEditingController _searchController = TextEditingController();
  bool _isListening = false;

  CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''), // Kosongkan judul
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            labelColor: Color(0xFFFFFFFF), // Warna teks tab yang dipilih
            unselectedLabelColor: Color(0xFF060074),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Semua'),
              Tab(text: 'Matematika'),
              Tab(text: 'Fisika'),
            ],
          ),
          // Search bar dengan Speech-to-Text
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 300,
                height: 40,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari Kursus...',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(135, 255, 255, 255)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.blue),
                    suffixIcon: GestureDetector(
                      onTap: _toggleListening,
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildCourseList(),
            _buildCourseList(filter: 'Matematika'),
            _buildCourseList(filter: 'Fisika'),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk memulai/berhenti mendengarkan
  void _toggleListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        _speech.listen(onResult: (result) {
          _searchController.text = result.recognizedWords;
        });
        _isListening = true;
      }
    } else {
      _speech.stop();
      _isListening = false;
    }
  }

  Widget _buildCourseList({String? filter}) {
    // Data kursus
    final courses = [
      {
        'title': 'Belajar Listening Bahasa Inggris',
        'subtitle':
            'Belajar konsep dasar matematika dengan cara yang menyenangkan!',
        'imageUrl':
            'https://img.freepik.com/free-vector/hand-drawn-online-college-template-design_23-2150573429.jpg?w=740&t=st=1727770811~exp=1727771411~hmac=90792acb88b388a3d144b87a1cc455a7d5b7689b4afd1c87f4b9ebcdcf4d9893',
        'audioUrl':
            'https://rr2---sn-2uuxa3vh-habe.googlevideo.com/videoplayback?expire=1732054498&ei=grk8Z8WMIdOz9fwPxc2BmQU&ip=116.254.97.240&id=o-ACER4mSan1otEZuUMqJQ86ZCKdkXYYjlyx0HJodPYD0Y&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&rms=au%2Cau&vprv=1&mime=audio%2Fmp4&rqh=1&gir=yes&clen=17481858&dur=1080.145&lmt=1692138504908270&keepalive=yes&fexp=24350590,24350675,24350705,24350737,51299154,51312688,51326932,51335593&c=ANDROID_VR&txp=5432434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cvprv%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhANHD-pMzAMr53z3JxkZNcFjc9VS7Edh4y--obDhWe4i1AiAJaEDFI_1oUPVnbQmo0GN8yF6H0N-qjtAmkhQ-_XX3cg%3D%3D&redirect_counter=1&rm=sn-npolk7z&rrc=104&req_id=9accbbc988f6a3ee&cms_redirect=yes&cmsv=e&ipbypass=yes&met=1732040938,&mh=mP&mip=180.248.28.241&mm=31&mn=sn-2uuxa3vh-habe&ms=au&mt=1732040721&mv=m&mvi=2&pl=20&lsparams=ipbypass,met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRAIgKbnCKo-R-hgNoEYS1anFx8akO16DzUybDI6tBQ7ZJygCIATwCx19w1ADCj9D69JbvrQWEonnQSEfQONf3DT4wWlw',
      },
      {
        'title': 'Belajar Listening Bahasa Jepang',
        'subtitle':
            'Keterapan fisika dalam kehidupan sehari-hari melalui video praktis.',
        'imageUrl':
            'https://img.freepik.com/free-vector/hand-drawn-online-college-template-design_23-2150573429.jpg?w=740&t=st=1727770811~exp=1727771411~hmac=90792acb88b388a3d144b87a1cc455a7d5b7689b4afd1c87f4b9ebcdcf4d9893',
        'audioUrl':
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        if (filter != null &&
            !courses[index]['title']
                .toString()
                .toLowerCase()
                .contains(filter.toLowerCase())) {
          return const SizedBox.shrink();
        }
        return _buildCourseCard(
          context,
          courses[index]['title']!,
          courses[index]['subtitle']!,
          courses[index]['imageUrl']!,
          courses[index]['audioUrl']!,
        );
      },
    );
  }

  Widget _buildCourseCard(BuildContext context, String title, String subtitle,
      String imageUrl, String audioUrl) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => CourseDetailView(
                            title: title,
                            description: subtitle,
                            audioUrl: audioUrl,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Mulai Kursus',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
