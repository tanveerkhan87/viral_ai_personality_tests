
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'quiz_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
       child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // '20.h' creates a responsive vertical gap.
              SizedBox(height: 20.h),

              Text(
                  "AI Personality Test",

                  style: GoogleFonts.aBeeZee(
                    // '16.sp' is a responsive font size from screen_util.
                    // It scales based on screen size, ensuring text is readable everywhere.
                    fontSize: 16.sp,
                    color: Colors.deepPurple,
                  )
              ),

              SizedBox(height: 30.h),

              Center(
                child: Container(
                  width: 230.w, // Responsive width.
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    // '.r' is a responsive radius, keeping the curve looking good on all screens.
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    // '.all(15.r)' applies a responsive padding of 15 on all sides.
                    padding: EdgeInsets.all(15.r),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 30.sp,  // The icon size is also responsive.
                          color: Colors.white,
                        ),
                        SizedBox(height: 3.h), // Small responsive gap.
                        Text(
                          "Take the AI Test",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          "Find out your true personality and career path with this AI-powered test.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50.h),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h), // Responsive padding.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  shadowColor: Colors.black.withOpacity(0.2), // Custom shadow color.
                  elevation: 8,
                  side: BorderSide(color: Colors.purpleAccent, width: 1.5),
                ),

                child: BounceInDown(
                  duration: Duration(milliseconds: 500),

                  child: Text(
                    "Start Test",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),


              TextButton(
                onPressed: () {
                  // pending
                },
                child: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 6.sp, // Very small text for de-emphasized info.
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}