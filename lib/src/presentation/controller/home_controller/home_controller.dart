import 'package:device_calendar/device_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final deviceCalendarPlugin = DeviceCalendarPlugin();

  RxList<Event> events = <Event>[].obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;

      var permission = await deviceCalendarPlugin.hasPermissions();

      if (!(permission.data ?? false)) {
        final request = await deviceCalendarPlugin.requestPermissions();
        if (!(request.data ?? false)) {
          Fluttertoast.showToast(msg: "Calendar permission is required");
          isLoading.value = false;
          return;
        }
      }

      final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
      final calendars = calendarsResult.data ?? [];

      List<Event> allEvents = [];

      for (var calendar in calendars) {
        final result = await deviceCalendarPlugin.retrieveEvents(
          calendar.id,
          RetrieveEventsParams(
            startDate: DateTime(2000),
            endDate: DateTime(2100),
          ),
        );

        final List<Event> eventsList = result.data ?? <Event>[];
        allEvents.addAll(eventsList);
      }

      events.assignAll(allEvents);
    } catch (e) {
      Fluttertoast.showToast(msg: "Could not fetch calendar events");
    } finally {
      isLoading.value = false;
    }
  }
}
