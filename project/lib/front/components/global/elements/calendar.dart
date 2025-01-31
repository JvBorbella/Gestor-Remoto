import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/Front/components/style.dart';

final today = DateUtils.dateOnly(DateTime.now());

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // final _scrollController = ScrollController();
  // List<DateTime?> _dialogCalendarPickerValue = [
  //   DateTime.now(),
  //   DateTime.now(),
  // ];
  // List<DateTime?> _singleDatePickerValueWithDefaultValue = [
  //   DateTime.now().add(const Duration(days: 1)),
  // ];
  // List<DateTime?> _multiDatePickerValueWithDefaultValue = [
  //   DateTime(today.year, today.month, today.day),
  //   // DateTime(today.year, today.month, 5),
  //   // DateTime(today.year, today.month, 14),
  //   // DateTime(today.year, today.month, 17),
  //   // DateTime(today.year, today.month, 25),
  // ];
  // List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
  //   DateTime.now(),
  //   DateTime.now(),
  // ];

  // List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
  //   DateTime.now(),
  //   DateTime.now().add(const Duration(days: 5)),
  // ];

  // @override
  // void initState() {
  //   _scrollController.addListener(() {
  //     if (_scrollController.offset > 1000) {
  //       // ignore: avoid_print
  //       print('scrolling distance: ${_scrollController.offset}');
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                // _buildCalendarDialogButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // String _getValueText(
  //   CalendarDatePicker2Type datePickerType,
  //   List<DateTime?> values,
  // ) {
  //   values =
  //       values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
  //   var valueText = (values.isNotEmpty ? values[0] : null)
  //       .toString()
  //       .replaceAll('00:00:00.000', '');

  //   if (datePickerType == CalendarDatePicker2Type.multi) {
  //     valueText = values.isNotEmpty
  //         ? values
  //             .map((v) => v.toString().replaceAll('00:00:00.000', ''))
  //             .join(', ')
  //         : 'null';
  //   } else if (datePickerType == CalendarDatePicker2Type.range) {
  //     if (values.isNotEmpty) {
  //       final startDate = values[0].toString().replaceAll('00:00:00.000', '');
  //       final endDate = values.length > 1
  //           ? values[1].toString().replaceAll('00:00:00.000', '')
  //           : 'null';
  //       valueText = '$startDate to $endDate';
  //     } else {
  //       return 'null';
  //     }
  //   }

  //   return valueText;
  // }

  // static Future<List<DateTime?>?> showCalendarDialog(
  //     BuildContext context) async {
  //   final config = CalendarDatePicker2WithActionButtonsConfig(
  //     calendarType: CalendarDatePicker2Type.range,
  //     selectedDayHighlightColor: Style.primaryColor,
  //     firstDayOfWeek: 1,
  //     closeDialogOnCancelTapped: true,
  //     weekdayLabelTextStyle: const TextStyle(
  //       color: Colors.black87,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     controlsTextStyle: const TextStyle(
  //       color: Colors.black,
  //       fontSize: 15,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     centerAlignModePicker: true,
  //   );

  //   final values = await showCalendarDatePicker2Dialog(
  //     context: context,
  //     config: config,
  //     dialogSize: const Size(325, 370),
  //     borderRadius: BorderRadius.circular(15),
  //     value: [DateTime.now()], // Valor inicial
  //     dialogBackgroundColor: Colors.white,
  //   );

  //   return values;
  // }
}

Future<List<DateTime?>?> showCalendarDialog(BuildContext context) async {
  final config = CalendarDatePicker2WithActionButtonsConfig(
    calendarType: CalendarDatePicker2Type.range,
    selectedDayHighlightColor: Style.primaryColor,
    firstDayOfWeek: 1,
    closeDialogOnCancelTapped: true,
    // cancelButton: GestureDetector(
    //   onTap: () {
    //     _closeModal(context);
    //   },
    //   child: Container(
    //     padding: EdgeInsets.all(Style.height_5(context)),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(
    //         Style.height_10(context)
    //       ),
    //       color: Style.errorColor
    //     ),
    //     child: Text(
    //       'Cancelar',
    //       style: TextStyle(
    //         color: Style.tertiaryColor
    //       ),
    //     ),
    //   ),
    // ),
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    controlsTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    centerAlignModePicker: true,
  );

  final values = await showCalendarDatePicker2Dialog(
    context: context,
    config: config,
    dialogSize: const Size(325, 370),
    borderRadius: BorderRadius.circular(15),
    value: [DateUtils.dateOnly(DateTime.now())], // Valor inicial
    dialogBackgroundColor: Colors.white,
  );
  print(values);
  return values;
}

void _closeModal(BuildContext context) {
  //Função para fechar o modal
  Navigator.of(context).pop();
}
