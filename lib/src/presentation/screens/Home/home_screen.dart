import 'package:calendar/src/data/models/event_data_source.dart';
import 'package:calendar/src/presentation/controller/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Calendar", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xFF010048),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                spacing: 24,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Color(0xFF010048)),
                  Text(
                    "Syncing your calendar events...",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SfCalendar(
                initialSelectedDate: DateTime.now(),
                backgroundColor: Colors.white,
                view: CalendarView.month,
                dataSource: EventDataSource(controller.events),
                headerHeight: 60,
                headerStyle: const CalendarHeaderStyle(
                  backgroundColor: Colors.white,
                  textAlign: TextAlign.left,
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                monthViewSettings: const MonthViewSettings(showAgenda: true),
                todayHighlightColor: const Color(0xFF010048),
                selectionDecoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF010048), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF010048),
        onPressed: controller.fetchEvents,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
