import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

//ignore: must_be_immutable
class ChannelWidget extends StatefulWidget {
  ChannelWidget({
    Key? key,
    required this.logo,
    required this.channelName,
    required this.pricePerLetter,
    this.symbolsCount = 0,
    this.orderPrice = 0.0,
  }) : super(key: key);

  final String logo;
  final String channelName;
  final double pricePerLetter;
  final int symbolsCount;
  double orderPrice;

  @override
  State<ChannelWidget> createState() => _ChannelWidgetState();
}

class _ChannelWidgetState extends State<ChannelWidget> {
  final DateRangePickerController _controller = DateRangePickerController();

  int _dateCount = 0;
  double totalOrderPrice = 0.0;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _dateCount = args.value.length;
      widget.orderPrice =
          _dateCount * widget.pricePerLetter * widget.symbolsCount;
      totalOrderPrice += widget.orderPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<Widget>(
            context: context,
            builder: (BuildContext context) {
              return SfDateRangePicker(
                controller: _controller,
                backgroundColor: Colors.white,
                monthViewSettings: const DateRangePickerMonthViewSettings(
                    firstDayOfWeek: 1, numberOfWeeksInView: 4),
                viewSpacing: 20,
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.multiple,
                confirmText: 'Сохранить',
                cancelText: 'Отмена',
                showActionButtons: true,
                onSubmit: (value) {
                  Navigator.pop(context);
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              );
            });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 65,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Image.network(widget.logo),
                ),
                Text(
                  widget.channelName.toUpperCase(),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: const Row(
                children: [
                  Spacer(),
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 30,
                  )
                ],
              ),
            ),
            Text(
              '${widget.orderPrice} сом',
              style: const TextStyle(fontSize: 18, color: Color(0xFF808084)),
            ),
            const Divider(
              thickness: 3,
            )
          ],
        ),
      ),
    );
  }
}
