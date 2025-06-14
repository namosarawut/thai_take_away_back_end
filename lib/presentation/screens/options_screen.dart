import 'package:flutter/material.dart';

class TwoButtonsScreen extends StatelessWidget {
  const TwoButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ปุ่มแรก
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7163BA), // สีพื้นหลัง
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // border radius
                ),
                fixedSize: const Size(475, 150), // set size
              ),
              onPressed: () {
                // กำหนดการทำงานเมื่อกดปุ่มได้ที่นี่
                Navigator.pushNamed(context, "workAttendance");
              },
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ไอคอน
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.34),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/icons/staffIcon.png',
                      width: 90,
                      height: 90,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // ข้อความบนปุ่ม
                  const Text(
                    'Work Attendance',
                    style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ปุ่มที่สอง
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7163BA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: const Size(475, 150), // set size
              ),
              onPressed: () {
                Navigator.pushNamed(context, "loginScreen");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.34),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/icons/staffIcon.png',
                      width: 90,
                      height: 90,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Login to manage',
                    style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
