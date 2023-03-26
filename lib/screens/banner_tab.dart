import 'package:flutter/material.dart';
import 'package:natv_app/models/channel.dart';
import 'package:natv_app/repositories/api_repo.dart';
import 'package:natv_app/widgets/channel_widget.dart';
import 'package:natv_app/widgets/custom_elevated.dart';
import 'package:natv_app/widgets/footer_widget.dart';
import 'package:natv_app/widgets/steps_widget.dart';
import 'package:natv_app/widgets/userinfo.dart';

class BannerAdTab extends StatefulWidget {
  const BannerAdTab({super.key});

  @override
  State<BannerAdTab> createState() => _BannerAdTabState();
}

class _BannerAdTabState extends State<BannerAdTab> {
  late Future<List<Channel>> channelsFuture;
  int _numChannels = 9;

  @override
  void initState() {
    super.initState();
    channelsFuture = ApiRepository.getChannelsList();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox20 = const SizedBox(
      height: 20,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              height: 85,
              width: 120,
              child: Image.asset('assets/images/logo.png')),
          sizedBox20,
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            color: const Color(0xFFC20937),
            child: Text(
              'Загрузите графический файл'.toUpperCase(),
              style: const TextStyle(
                letterSpacing: 1.5,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 6, backgroundColor: Colors.white),
              child: const Text(
                'Выбрать файл',
                style: TextStyle(color: Color(0xFF737373)),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 6, backgroundColor: Colors.white),
              child: Text(
                'Загрузить'.toUpperCase(),
                style: const TextStyle(color: Color(0xFFC20937), fontSize: 18),
              ),
            ),
          ),
          sizedBox20,
          const Text(
              'Рекомендуемый размер файла 720х576 пикс. или соотношение сторон 4:3\nОграничение по размеру файла 3 Мб. К закачке допустимы графические форматы PNG, JPG, GIF.'),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 80,
            ),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration:
                BoxDecoration(color: Colors.white, border: Border.all()),
            child: const Center(
              child: Text(
                'Предпросмотр',
                style: TextStyle(color: Color(0xFFd2d7da), fontSize: 28),
              ),
            ),
          ),
          const StepsWidget(
            number: '1',
            description: 'Загрузите  изображение',
          ),
          sizedBox20,
          const StepsWidget(
              number: '2',
              description:
                  'Выберите телеканалы и даты,\nи нажмите «Разместить баннер»'),
          sizedBox20,
          const StepsWidget(number: '3', description: 'Оплатите объявление!'),

          // Channels list
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                color: const Color(0xFFFFFFFF),
                child: const Text(
                  'ВЫБОР КАНАЛОВ',
                  style: TextStyle(fontSize: 30, color: Color(0xFFC20937)),
                ),
              ),
              FutureBuilder(
                  future: channelsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _numChannels,
                        itemBuilder: (context, index) {
                          if (index == _numChannels - 1) {
                            return CustomElevButton(
                                text: 'БОЛЬШЕ КАНАЛОВ',
                                onPressed: () {
                                  setState(() {
                                    _numChannels = snapshot.data!.length;
                                  });
                                });
                          } else {
                            var channel = snapshot.data![index];
                            return ChannelWidget(
                              channelName: channel.channelName,
                              logo: channel.logo,
                              pricePerLetter: channel.pricePerLetter,
                            );
                          }
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  }),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: const Row(
                  children: [
                    Text('Общая сумма: '),
                    Text(
                      'X com',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),

          UserInfo(),
          sizedBox20,
          CustomElevButton(text: 'РАЗМЕСТИТЬ БАННЕР', onPressed: () {}),
          const SizedBox(
            height: 40,
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          footerWidget()
        ]),
      ),
    );
  }
}
