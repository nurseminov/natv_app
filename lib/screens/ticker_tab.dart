import 'package:flutter/material.dart';
import 'package:natv_app/models/channel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natv_app/repositories/api_repo.dart';
import 'package:natv_app/widgets/channel_widget.dart';
import 'package:natv_app/widgets/custom_elevated.dart';

import 'package:natv_app/widgets/footer_widget.dart';

import 'package:natv_app/widgets/steps_widget.dart';
import 'package:natv_app/widgets/userinfo.dart';

class TickerAdTab extends StatefulWidget {
  const TickerAdTab({super.key});

  @override
  State<TickerAdTab> createState() => _TickerAdTabState();
}

class _TickerAdTabState extends State<TickerAdTab> {
  late Future<List<Channel>> channelsFuture;
  int _numChannels = 10;
  bool _showMoreChannelsButton = true;
  final TextEditingController _controller = TextEditingController();
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    channelsFuture = ApiRepository.getChannelsList();
  }

  @override
  Widget build(BuildContext context) {
    int symbolsCount = _controller.text.length;
    var sizedBox20 = const SizedBox(height: 20);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 85,
                width: 120,
                child: Image.asset('assets/images/logo.png')),
            sizedBox20,
            Container(
              width: double.infinity,
              height: 90,
              color: const Color.fromARGB(255, 135, 24, 52),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'ВВЕДИТЕ ТЕКСТ ОБЪЯВЛЕНИЯ',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 15,
                    ),
                  ),
                  Text('Символов: $symbolsCount',
                      style: const TextStyle(
                          color: Color(0xFFFFFFFF), fontSize: 16))
                ],
              ),
            ),
            TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  value = _controller.text;
                });
              },
              maxLines: 7,
              cursorColor: Colors.grey,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                  hintText: 'Отдых на Иссык-Куле 0 789 545654'),
            ),
            const SizedBox(
              height: 40,
            ),
            const StepsWidget(
              number: '1',
              description: 'Введите текст объявления',
            ),
            sizedBox20,
            const StepsWidget(
                number: '2',
                description:
                    'Выберите телеканалы и даты, и \nнажмите"Разместить объявление"'),
            sizedBox20,
            const StepsWidget(number: '3', description: 'Оплатите объявление!'),

            // List of channels
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
                            if (index == _numChannels - 1 &&
                                _showMoreChannelsButton) {
                              return CustomElevButton(
                                  text: 'БОЛЬШЕ КАНАЛОВ',
                                  onPressed: () {
                                    setState(() {
                                      _numChannels = snapshot.data!.length;
                                      _showMoreChannelsButton = false;
                                    });
                                  });
                            } else {
                              var channel = snapshot.data![index];
                              return ChannelWidget(
                                channelName: channel.channelName,
                                logo: channel.logo,
                                pricePerLetter: channel.pricePerLetter,
                                symbolsCount: symbolsCount,
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
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Text(
                        'Общая сумма: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '$totalPrice com',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            UserInfo(),
            sizedBox20,
            CustomElevButton(
              text: 'РАЗМЕСТИТЬ ОБЪЯВЛЕНИЕ',
              onPressed: () {},
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            footerWidget(),
          ],
        ),
      ),
    );
  }
}
