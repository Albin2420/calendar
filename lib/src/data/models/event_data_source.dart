import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source.map((event) {
      return Appointment(
        startTime: event.start ?? DateTime.now(),
        endTime:
            event.end ??
            (event.start ?? DateTime.now()).add(const Duration(hours: 1)),
        subject: event.title ?? "No Title",
        color: Colors.blue,
        isAllDay: event.allDay ?? false,
      );
    }).toList();
  }
}
