// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:example/core/consts/exports.dart';

class DatePicker extends StatelessWidget {
  final Function(DateTime?) onChangeTime;

  DatePicker({
    super.key,
    required this.onChangeTime,
  });

  DateTime now = DateTime.now();
  late DateTime selectedTime = DateTime(now.year - 22, now.month, now.day);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 350.0,
          child: Material(
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    maximumYear: selectedTime.year,
                    minimumYear: now.year - 100,
                    initialDateTime: selectedTime,
                    use24hFormat: false,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (value) {
                      selectedTime = value;
                    },
                  ),
                ),
                MBouncingButton(
                  width: context.width,
                  borderRadius: 10.0,
                  height: 55.0,
                  color: context.colorScheme.primary,
                  title: context.tr.done,
                  onTap: () {
                    onChangeTime(selectedTime);
                    AutoRouterX(context).pop();
                  },
                ).addPadding(vertical: 30.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showMDatePicker(BuildContext buildContext, Function(DateTime?) onChange) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: buildContext,
    builder: (context) {
      return DatePicker(onChangeTime: onChange);
    },
  );
}

class TimePicker extends StatelessWidget {
  final Function(DateTime?) onChageTime;

  TimePicker({
    super.key,
    required this.onChageTime,
  });

  DateTime now = DateTime.now();
  late DateTime selectedTime = DateTime(now.year - 22, now.month, now.day);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 350.0,
          child: Material(
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    maximumYear: selectedTime.year,
                    minimumYear: now.year - 100,
                    initialDateTime: selectedTime,
                    use24hFormat: false,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (value) {
                      selectedTime = value;
                    },
                  ),
                ),
                MBouncingButton(
                  width: context.width,
                  borderRadius: 10.0,
                  height: 55.0,
                  color: context.colorScheme.primary,
                  title: context.tr.done,
                  onTap: () {
                    onChageTime(selectedTime);
                    AutoRouterX(context).pop();
                  },
                ).addPadding(vertical: 30.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showMTimePicker(BuildContext buildContext, Function(DateTime?) onChange) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: buildContext,
    builder: (context) {
      return TimePicker(onChageTime: onChange);
    },
  );
}

class DateTimePicker extends StatelessWidget {
  final Function(DateTime?) onChangeTime;

  DateTimePicker({
    super.key,
    required this.onChangeTime,
  });

  DateTime now = DateTime.now().add(const Duration(minutes: 1));
  late DateTime selectedTime = now;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 350.0,
          child: Material(
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    maximumYear: selectedTime.year,
                    minimumYear: now.year,
                    initialDateTime: selectedTime,
                    use24hFormat: false,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (value) {
                      selectedTime = value;
                    },
                  ),
                ),
                MBouncingButton(
                  width: context.width,
                  borderRadius: 10.0,
                  height: 55.0,
                  color: AppColors.primary,
                  title: context.tr.done,
                  onTap: () {
                    onChangeTime(selectedTime);
                    AutoRouterX(context).pop();
                  },
                ).addPadding(vertical: 30.0, horizontal: 21.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showMDateTimePicker(
    {required BuildContext context, required Function(DateTime?) onChange}) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return DateTimePicker(onChangeTime: onChange);
    },
  );
}
