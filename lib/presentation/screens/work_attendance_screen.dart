import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';
class AttendancePage extends StatelessWidget {
  final TextEditingController employeeIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        if (state.showDialog) {
          _showAttendanceDialog(context, state);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          body: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 24,),
                  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: Container(
                      width: 100,
                      height: 95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF534598)
                      ),
                      child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 40,),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Check In/Check Out Toggle Button
                    Container(
                      width: 263,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(0xFFE2E1EA),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Stack(
                        children: [
                          // Animated slider background
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left: state.isCheckIn ? 0 : 131.5,
                            child: Container(
                              width: 131.5,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Color(0xFF534598),
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                          // Button labels
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<AttendanceBloc>().add(ToggleCheckInMode(true));
                                  },
                                  child: Center(
                                    child: Text(
                                      'Check In',
                                      style: TextStyle(
                                        color: state.isCheckIn ? Colors.white : Color(0xFF534598),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<AttendanceBloc>().add(ToggleCheckInMode(false));
                                  },
                                  child: Center(
                                    child: Text(
                                      'Check out',
                                      style: TextStyle(
                                        color: !state.isCheckIn ? Colors.white : Color(0xFF534598),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),

                    // Main Container
                    Container(
                      width: 593,
                      height: 344,
                      decoration: BoxDecoration(
                        color: Color(0xFF534598),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Employee ID Label
                          Text(
                            'Employee ID',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Employee ID TextField
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: TextField(
                              controller: employeeIdController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ),
                          ),

                          Spacer(),

                          // Check In/Out Button
                          Center(
                            child: InkWell(
                              onTap: () {
                                context.read<AttendanceBloc>().add(
                                    SubmitAttendance(employeeIdController.text)
                                );
                              },
                              child: Container(
                                width: 200,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD80A3),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Center(
                                  child: Text(
                                    state.isCheckIn ? 'Check In' : 'Check Out',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAttendanceDialog(BuildContext context, AttendanceState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<AttendanceBloc>(context),
          child: BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 325,
                  height: 342,
                  decoration: BoxDecoration(
                    color: Color(0xFF534598),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Employee Name Label
                      Text(
                        'employee name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),

                      // Employee Name Field
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Text('employee name'),
                      ),
                      SizedBox(height: 20),

                      // Time Label
                      Text(
                        state.isCheckIn ? 'Check in Time' : 'Check Out Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),

                      // Current Time Field
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(state.currentTime),
                      ),
                      SizedBox(height: 30),

                      // OK Button
                      GestureDetector(
                        onTap: () {
                          context.read<AttendanceBloc>().add(CloseDialog());
                          Navigator.of(dialogContext).pop();
                        },
                        child: Container(
                          width: 302,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xFFFD80A3),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}