import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/dimmed_session_item.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/session_item.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';

class SeesionsList extends StatelessWidget {
  const SeesionsList({
    super.key,
    required this.activeBookings,
  });

  final List<PatientSessionModel> activeBookings;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // قائمة الجلسات (Scrollable بشكل Lazy)
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SessionListItem(session: activeBookings[index]);
            },
            childCount: activeBookings.length,
          ),
        ),

        //  التلت عناصر (تتسكرول مع القائمة لكن بتتعرض مرة واحدة)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DimmedSessionListItem(
                  day: activeBookings[0].startDate.day,
                  month: activeBookings[0].startDate.month,
                  year: activeBookings[0].startDate.year,
                  startTime: activeBookings[0].startTime,
                  endTime: activeBookings[0].endTime,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
