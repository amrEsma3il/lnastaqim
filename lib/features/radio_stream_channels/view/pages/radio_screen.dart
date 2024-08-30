// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lnastaqim/features/radio_stream_channels/bussniess_logic/radio_cubit.dart';

// class RadioScreen extends StatelessWidget {
//   const RadioScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => RadioCubit(),
//       child: BlocConsumer<RadioCubit, RadioState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Scaffold(
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Image(
//                     image: NetworkImage(
//                         'https://play-lh.googleusercontent.com/QuVFM8a1DJFaLb3M0iHjgylkrS0ddvpBzDSHOGxs7YzqAFIHeXJwZ53aX7SaMImmA30')),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           // RadioCubit.get(context).next();
//                         },
//                         icon: const Icon(
//                           Icons.skip_next,
//                           size: 50,
//                         )),
//                     state is RadioLoading
//                         ? const CircularProgressIndicator()
//                         : IconButton(
//                             onPressed: () {
//                               // RadioCubit.get(context).playRadio();
//                             },
//                             icon: const Icon(
//                               Icons.play_circle,
//                               size: 50,
//                             )),
//                     IconButton(
//                         onPressed: () {
//                           // RadioCubit.get(context).back();
//                         },
//                         icon: const Icon(
//                           Icons.skip_previous,
//                           size: 50,
//                         ))
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




























import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/local_database/radio/radio_local_database.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {

  final List<Map<String, dynamic>> recitersStream = [
    {
      "id": 1,
      "name": "إذاعة إبراهيم الأخضر",
      "url": "https://backup.qurango.net/radio/ibrahim_alakdar",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 10,
      "name": "إذاعة القارئ ياسين",
      "url": "https://backup.qurango.net/radio/alqaria_yassen",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 100,
      "name": "إذاعة أحمد الطرابلسي",
      "url": "https://backup.qurango.net/radio/ahmed_altrabulsi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 101,
      "name": "إذاعة عبدالله الكندري",
      "url": "https://backup.qurango.net/radio/abdullah_alkandari",
      "recent_date": "2020-04-25 16:04:05"
    },
   
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _playingUrl;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playOrPause(String url) async {
    if (_playingUrl == url) {
      await _audioPlayer.stop();
      setState(() {
        _playingUrl = null;
      });
    } else {
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        _playingUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("بث مباشر للقراء"),
      // ),
      body: Container(
        color: AppColor.blueColor,
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 15,
            crossAxisSpacing: 20,

          ),
          itemCount: recitersStream.length,
          itemBuilder: (context, index) {
            final reciter =recitersStream[index];
            final isPlaying = _playingUrl == reciter['url'];
            return GestureDetector(
              onTap: () => _playOrPause(reciter['url']),
              child: Container(
                width: 30,
                height: 70,
                decoration: BoxDecoration(


                  color: AppColor.blueColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(400.r),
                  image: DecorationImage(
                    image:  AssetImage('assets/images/reciter_${reciter["id"]}.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/reciter_${reciter["id"]}.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      reciter['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                                        const SizedBox(height: 2),

                    Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

