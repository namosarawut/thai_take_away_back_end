import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController employeeIdController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            Navigator.pushNamed(context, "customerPage");
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
                                "Login",
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
  }

}