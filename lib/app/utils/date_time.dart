import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final DateFormat postDateTimeFormate = DateFormat('MMM d, yyyy hh:mm a');
final DateFormat productDateTimeFormate = DateFormat('MMM d, yyyy');
final DateFormat postTimeFormate = DateFormat('hh:mm a');

String formatDateOfBirth(String? dob) {
  try {
    DateTime dt = DateTime.parse(dob ?? '');

    String formattedDate = DateFormat('MMMM dd, yyyy').format(dt);
    debugPrint('++++++DOBB++++: $formattedDate');
    return formattedDate;
  } catch (e) {
    return '';
  }
}

String getWorkPlaceDuration(String? duration) {
  try {
    DateTime dt = DateTime.parse(duration ?? '');
    String? workDuration = DateFormat('yyyy MMMM').format(dt);
    debugPrint('Duration: $workDuration');

    return workDuration;
  } catch (e) {
    return '';
  }
}

//=========================Date Format is like Nov 4, 2024 4:13 PM ===========================//
String formatToReadableDate(String? dateTimeString) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeString ?? '');
    String formattedDate = DateFormat('MMM d, yyyy h:mm a').format(dateTime);
    return formattedDate;
  } catch (e) {
    return '';
  }
}

//=======================Detail Day Time Date Format-==========================//
String detailFormatDateTime(String? dateTimeString) {
  try {
    DateTime dt = DateTime.parse(dateTimeString ?? '');
    
    String formattedDate = DateFormat('EEE, MMM d, y h:mm a').format(dt);
    debugPrint('Formatted Date: $formattedDate');

    return formattedDate;
  } catch (e) {
    debugPrint('Error parsing date: $e');
    return '';
  }
}
 String formatInvoiceNumber(String? invoiceNumber) {
  if (invoiceNumber == null) return 'No Id';
  List<String> parts = invoiceNumber.split('-');
  if (parts.length >= 3) {
    return '${parts[0]}-${parts[1]}-${parts[4]}';
  }
  return invoiceNumber;
}

String formatDateAndTime(DateTime? dateTime) {
  if (dateTime == null) return 'N/A';
  return DateFormat('MMMM d, yyyy h:mm a').format(dateTime);
}

  String wordlyTimeText(String time) {
    DateTime postDateTime =
        DateTime.parse(time).toLocal();
    DateTime currentDatetime = DateTime.now();
    // Calculate the difference in milliseconds
    int millisecondsDifference = currentDatetime.millisecondsSinceEpoch -
        postDateTime.millisecondsSinceEpoch;
    // Convert to minutes (ignoring milliseconds)
    int minutesDifference =
        (millisecondsDifference / Duration.millisecondsPerMinute).truncate();

    if (minutesDifference < 1) {
      return 'a few seconds ago';
    } else if (minutesDifference < 30) {
      return '$minutesDifference minutes ago';
    } else if (DateUtils.isSameDay(postDateTime, currentDatetime)) {
      return 'Today at ${postTimeFormate.format(postDateTime)}';
    } else {
      return postDateTimeFormate.format(postDateTime);
    }
  }