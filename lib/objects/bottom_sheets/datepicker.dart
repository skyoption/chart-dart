import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

void setDatePicker({
  required BuildContext context,
  DateTime? minDateTime,
  DateTime? maxDateTime,
  DateTime? currentTime,
  required Function(DateTime? value) onChange,
}) {
  DateTimePickerLocale? _locale = DateTimePickerLocale.en_us;
  DateTime? _dateTime;
  DatePicker.showDatePicker(
    context,
    minDateTime: minDateTime,
    maxDateTime: maxDateTime,
    initialDateTime: currentTime,
    dateFormat: 'yyyy-M-d HH:m',
    locale: _locale,
    pickerMode: DateTimePickerMode.datetime,
    onCancel: () {},
    onChange: (dateTime, List<int> index) {
      _dateTime = dateTime;
      onChange(dateTime);
    },
    onConfirm: (dateTime, List<int> index) {
      _dateTime = dateTime;
      onChange(dateTime);
    },
  );
}

void showTimePicker({
  required BuildContext context,
  DateTime? minDateTime,
  DateTime? maxDateTime,
  required Function(DateTime? value) onChange,
}) {
  DateTimePickerLocale? _locale = DateTimePickerLocale.en_us;
  DateTime? _dateTime;
  DatePicker.showDatePicker(
    context,
    minDateTime: minDateTime,
    maxDateTime: maxDateTime,
    initialDateTime: _dateTime,
    dateFormat: 'HH:m:s',
    locale: _locale,
    pickerMode: DateTimePickerMode.time,
    onCancel: () {},
    onChange: (dateTime, List<int> index) {
      _dateTime = dateTime;
      onChange(dateTime);
    },
    onConfirm: (dateTime, List<int> index) {
      _dateTime = dateTime;
      onChange(dateTime);
    },
  );
}
