import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:CoachZiad/res/components/round_button.dart';
import 'package:CoachZiad/utils/routes/routes_name.dart';
import 'package:CoachZiad/utils/utils.dart';
import 'package:CoachZiad/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import 'dart:ui' as ui;

import '../model/signup_model.dart';

class genderscreen extends StatefulWidget {
  const genderscreen({super.key});

  @override
  State<genderscreen> createState() => _genderscreenState();
}

class _genderscreenState extends State<genderscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? selectedValue; // Default selected radio button value
  String? selectedGender;
  TextEditingController name = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(3100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _handleRadioValueChanged(int? value) {
    setState(() {
      selectedValue = value;
      if (value == 1) {
        selectedGender = 'رجل';
      } else if (value == 2) {
        selectedGender = 'انثى';
      } else {
        selectedGender = null;
      }
    });
  }

  Widget _customRadio(int value, String label) {
    return Container(
      height: 50.h,
      width: 85.w,
      child: ElevatedButton(
        onPressed: () {
          _handleRadioValueChanged(value);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedValue == value
              ? const Color.fromARGB(255, 6, 159, 182)
              : const Color.fromARGB(255, 30, 30, 43),
          //elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                // selectedValue == value
                //     ? const Color.fromARGB(255, 30, 30, 43)
                //     : Colors.white,
              ),
            ),
            value == 1
                ? Text(
                    '♂️',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      // selectedValue == value
                      //     ? const Color.fromARGB(255, 30, 30, 43)
                      //     : Colors.white,
                    ),
                  )
                : Text(
                    '♀️',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      // selectedValue == value
                      //     ? const Color.fromARGB(255, 30, 30, 43)
                      //     : Colors.white,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: Text(
                    'الأسم',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "الاسم",
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     // return 'يرجى إدخال الاسم';
                        //     SnackBar(
                        //       content: Text('يرجى إدخال الاسم'),
                        //     );
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // date of birth
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'تاريخ الميلاد',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(selectedDate),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _selectDate(context),
                                icon: Icon(Icons.calendar_today, size: 20),
                                tooltip: 'Select DOB',
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'نوع الجنس',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _customRadio(1, 'رجل'),
                      _customRadio(2, 'انثى'),
                    ],
                  ),
                ),
                SizedBox(height: 170),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    height: 50.h,
                    width: 240.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 6, 159, 182),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () {
                        // Validate text field
                        if (_formKey.currentState?.validate() ?? false) {
                          // Validate name
                          if (name.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('يرجى إدخال الاسم'),
                              ),
                            );
                            return;
                          }

                          // // Validate date picker
                          // if (selectedDate == DateTime.now() ||
                          //     selectedDate.isBefore(DateTime.now())) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('يرجى اختيار تاريخ الميلاد'),
                          //     ),
                          //   );
                          //   return;
                          // }

                          // Validate radio buttons
                          if (selectedValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('يرجى اختيار نوع الجنس'),
                              ),
                            );
                            return;
                          }

                          // Form is valid, proceed with the navigation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => physicallyActivrScreen(
                                name: name,
                                selectDate: DateFormat('dd/MM/yyyy')
                                    .format(selectedDate)
                                    .toString(),
                                selectedGender: selectedGender,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('التالي', style: TextStyle(fontSize: 20.sp)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class physicallyActivrScreen extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;

  const physicallyActivrScreen({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    Key? key,
  }) : super(key: key);
  @override
  State<physicallyActivrScreen> createState() => _physicallyActivrScreenState();
}

class _physicallyActivrScreenState extends State<physicallyActivrScreen> {
  int? selectedValue; // Default selected radio button value
  String? selectedphysicallyActive;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleRadioValueChanged(int? value) {
    setState(() {
      selectedValue = value;
      if (value == 1) {
        selectedphysicallyActive = 'لا يوجد';
      } else if (value == 2) {
        selectedphysicallyActive = '1-2 تمرين';
      } else if (value == 3) {
        selectedphysicallyActive = '3-4 تمرين';
      } else if (value == 4) {
        selectedphysicallyActive = '+5 تمرين';
      } else {
        selectedphysicallyActive = null;
      }
    });
  }

  Widget _customRadio(int value, String label) {
    return Container(
      height: 70.h,
      width: 130.w,
      child: ElevatedButton(
        onPressed: () {
          _handleRadioValueChanged(value);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedValue == value
              ? const Color.fromARGB(255, 6, 159, 182)
              : const Color.fromARGB(255, 30, 30, 43),
          //elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                // selectedValue == value
                //     ? const Color.fromARGB(255, 30, 30, 43)
                //     : Colors.white,
              ),
            ),
            Text(
              value == 1 ? '' : 'في الاسبوع',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        //title: Text('SingUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Text(
                  'ما مدى نشاطك البدني',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 0.0.w),
                      child: Container(
                        height: 280.h,
                        width: 170.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/physicale.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        _customRadio(1, 'لا يوجد'),
                        SizedBox(height: 20.h),
                        _customRadio(2, '1-2 تمرين'),
                        SizedBox(height: 20.h),
                        _customRadio(3, '3-4 تمرين'),
                        SizedBox(height: 20.h),
                        _customRadio(4, '+5 تمرين'),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0.h),
                child: Container(
                  height: 50.h,
                  width: 240.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 6, 159, 182),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      // Validate text field
                      if (_formKey.currentState?.validate() ?? false) {
                        // Validate radio buttons
                        if (selectedValue == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('يرجى اختيار مدى نشاطك البدني'),
                            ),
                          );
                          return;
                        }

                        // Form is valid, proceed with the navigation

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => setgoalscreen(
                              name: widget.name,
                              selectDate: widget.selectDate,
                              selectedGender: widget.selectedGender,
                              selectedphysicallyActive:
                                  selectedphysicallyActive,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('التالي', style: TextStyle(fontSize: 20.sp)),
                  ),
                ),

                /*RoundButton(
                  title: 'التالي',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => setgoalscreen(
                          name: widget.name,
                          selectDate: widget.selectDate,
                          selectedGender: widget.selectedGender,
                          selectedphysicallyActive: selectedphysicallyActive,
                        ),
                      ),
                    );
                  },
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class setgoalscreen extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;
  final String? selectedphysicallyActive;
  const setgoalscreen({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    required this.selectedphysicallyActive,
    Key? key,
  }) : super(key: key);

  @override
  State<setgoalscreen> createState() => _setgoalscreenState();
}

class _setgoalscreenState extends State<setgoalscreen> {
  int? selectedValue; // Default selected radio button value
  String? selectedGoal;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleRadioValueChanged(int? value) {
    setState(() {
      selectedValue = value;
      if (value == 1) {
        selectedGoal = 'بناء عضلات';
      } else if (value == 2) {
        selectedGoal = 'فقدان الوزن';
      } else if (value == 3) {
        selectedGoal = 'زيادة اللياقة البدنية';
      } else {
        selectedGoal = null;
      }
    });
  }

  Widget _customRadio(int value, String label) {
    return Container(
      height: 50.h,
      width: 250.w,
      child: ElevatedButton(
        onPressed: () {
          _handleRadioValueChanged(value);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedValue == value
              ? const Color.fromARGB(255, 6, 159, 182)
              : const Color.fromARGB(255, 30, 30, 43),
          //elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                // selectedValue == value
                //     ? const Color.fromARGB(255, 30, 30, 43)
                //     : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        //title: Text('SingUp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    'حدد هدفك',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                _customRadio(1, 'بناء عضلات'),
                SizedBox(height: 30.h),
                _customRadio(2, 'فقدان الوزن'),
                SizedBox(height: 30.h),
                _customRadio(3, 'زيادة اللياقة البدنية'),
                SizedBox(height: 170.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0.h),
                  child: RoundButton(
                    title: 'التالي',
                    onPress: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Validate radio buttons
                        if (selectedValue == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('يرجى اختيار هدفك'),
                            ),
                          );
                          return;
                        }

                        // Form is valid, proceed with the navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => selectbodytypescreen(
                              name: widget.name,
                              selectDate: widget.selectDate,
                              selectedGender: widget.selectedGender,
                              selectedphysicallyActive:
                                  widget.selectedphysicallyActive,
                              selectedGoal: selectedGoal,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class selectbodytypescreen extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;
  final String? selectedphysicallyActive;
  final String? selectedGoal;

  const selectbodytypescreen({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    required this.selectedphysicallyActive,
    required this.selectedGoal,
    Key? key,
  }) : super(key: key);

  @override
  State<selectbodytypescreen> createState() => _selectbodytypescreenState();
}

class _selectbodytypescreenState extends State<selectbodytypescreen> {
  int? selectedValue; // Default selected radio button value
  String? selectedBodyType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleRadioValueChanged(int? value) {
    setState(() {
      selectedValue = value;
      if (value == 1) {
        selectedBodyType = 'نحيف';
      } else if (value == 2) {
        selectedBodyType = 'عادي';
      } else if (value == 3) {
        selectedBodyType = 'سمين';
      } else {
        selectedBodyType = null;
      }
    });
  }

  Widget _customRadio(int value, String label, String imagePath) {
    return Container(
      height: 100.h,
      width: 260.w,
      child: ElevatedButton(
        onPressed: () {
          _handleRadioValueChanged(value);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedValue == value
              ? const Color.fromARGB(255, 6, 159, 182)
              : const Color.fromARGB(255, 30, 30, 43),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                // selectedValue == value
                //     ? const Color.fromARGB(255, 30, 30, 43)
                //     : Colors.white,
              ),
            ),
            SizedBox(width: 10.w),
            Image.asset(
              imagePath,
              height: 100.h, // Adjust the height as needed
              width: 50.w, // Adjust the width as needed
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        //title: Text('SingUp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    'اختر نوع جسمك',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                _customRadio(1, 'نحيف', 'assets/images/skinn.png'),
                SizedBox(height: 30.h),
                _customRadio(2, 'عادي', 'assets/images/reguler.png'),
                SizedBox(height: 30.h),
                _customRadio(3, 'سمين', 'assets/images/fat.png'),
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0.h),
                  child: RoundButton(
                    title: 'التالي',
                    onPress: () {
                      // Navigator.pushNamed(context, RoutesName.selectbodygoal);

                      if (_formKey.currentState?.validate() ?? false) {
                        // Validate radio buttons
                        if (selectedValue == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('يرجى اختيار نوع جسمك'),
                            ),
                          );
                          return;
                        }

                        // Form is valid, proceed with the navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => selectbodygoalscreen(
                              name: widget.name,
                              selectDate: widget.selectDate,
                              selectedGender: widget.selectedGender,
                              selectedphysicallyActive:
                                  widget.selectedphysicallyActive,
                              selectedGoal: widget.selectedGoal,
                              selectedBodyType: selectedBodyType,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class selectbodygoalscreen extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;
  final String? selectedphysicallyActive;
  final String? selectedGoal;
  final String? selectedBodyType;
  const selectbodygoalscreen({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    required this.selectedphysicallyActive,
    required this.selectedGoal,
    required this.selectedBodyType,
    Key? key,
  }) : super(key: key);

  @override
  State<selectbodygoalscreen> createState() => _selectbodygoalscreenState();
}

class _selectbodygoalscreenState extends State<selectbodygoalscreen> {
  int? selectedValue; // Default selected radio button value
  String? selectedBodyGoal;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleRadioValueChanged(int? value) {
    setState(() {
      selectedValue = value;
      if (value == 1) {
        selectedBodyGoal = 'تنشيف';
      } else if (value == 2) {
        selectedBodyGoal = 'ضخامة صافية';
      } else if (value == 3) {
        selectedBodyGoal = 'ضخامة غير صافية';
      } else if (value == 4) {
        selectedBodyGoal = 'تحضير بطولة';
      } else {
        selectedBodyGoal = null;
      }
    });
  }

  Widget _customRadio(int value, String label, String imagePath) {
    return Container(
      height: 100.h,
      width: 260.w,
      child: ElevatedButton(
        onPressed: () {
          _handleRadioValueChanged(value);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedValue == value
              ? const Color.fromARGB(255, 6, 159, 182)
              : const Color.fromARGB(255, 30, 30, 43),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                // selectedValue == value
                //     ? const Color.fromARGB(255, 30, 30, 43)
                //     : Colors.white,
              ),
            ),
            Image.asset(
              imagePath,
              height: 85.h, // Adjust the height as needed
              width: 70.w, // Adjust the width as needed
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        //title: Text('SingUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Text(
                  'اختر الجسم الذي تريد الوصول إليه',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              _customRadio(1, 'تنشيف', 'assets/images/cut.png'),
              SizedBox(height: 10.h),
              _customRadio(2, 'ضخامة صافية', 'assets/images/bulk.png'),
              SizedBox(height: 10.h),
              _customRadio(3, 'ضخامة غير صافية', 'assets/images/extrabulk.png'),
              SizedBox(height: 10.h),
              _customRadio(4, 'تحضير بطولة', 'assets/images/bodybuilder.png'),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0.h),
                child: RoundButton(
                  title: 'التالي',
                  onPress: () {
                    // Navigator.pushNamed(context, RoutesName.motivationcheckbox);

                    if (_formKey.currentState?.validate() ?? false) {
                      // Validate radio buttons
                      if (selectedValue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'يرجى اختيار الجسم الذي تريد الوصول إليه '),
                          ),
                        );
                        return;
                      }

                      // Form is valid, proceed with the navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => motivationCheckboxscreen(
                            name: widget.name,
                            selectDate: widget.selectDate,
                            selectedGender: widget.selectedGender,
                            selectedphysicallyActive:
                                widget.selectedphysicallyActive,
                            selectedGoal: widget.selectedGoal,
                            selectedBodyType: widget.selectedBodyType,
                            selectedBodyGoal: selectedBodyGoal,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class motivationCheckboxscreen extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;
  final String? selectedphysicallyActive;
  final String? selectedGoal;
  final String? selectedBodyType;
  final String? selectedBodyGoal;
  const motivationCheckboxscreen({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    required this.selectedphysicallyActive,
    required this.selectedGoal,
    required this.selectedBodyType,
    required this.selectedBodyGoal,
    Key? key,
  }) : super(key: key);

  @override
  State<motivationCheckboxscreen> createState() =>
      _motivationCheckboxscreenState();
}

class _motivationCheckboxscreenState extends State<motivationCheckboxscreen> {
  List<int> selectedValues = []; // Selected checkbox values
  List<String> selectedMotivation = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleCheckboxValueChanged(int value) {
    setState(() {
      if (selectedValues.contains(value)) {
        selectedValues.remove(value);
      } else {
        selectedValues.add(value);
      }
      if (value == 1) {
        selectedMotivation.add('تحسين الحالة الصحية');
      } else if (value == 2) {
        selectedMotivation.add('تحسين المظهر');
      } else if (value == 3) {
        selectedMotivation.add('زيادة القوة البدنية');
      } else {
        selectedMotivation = [];
      }
    });
  }

  Widget _customCheckbox(int value, String label) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
      child: Container(
        height: 50.h,
        width: 280.w,
        child: ElevatedButton(
          onPressed: () {
            _handleCheckboxValueChanged(value);
          },
          style: ElevatedButton.styleFrom(
            primary: selectedValues.contains(value)
                ? const Color.fromARGB(255, 6, 159, 182)
                : const Color.fromARGB(255, 30, 30, 43),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  // selectedValue == value
                  //     ? const Color.fromARGB(255, 30, 30, 43)
                  //     : Colors.white,
                ),
              ),
              Checkbox(
                value: selectedValues.contains(value),
                onChanged: (bool? newValue) {
                  _handleCheckboxValueChanged(value);
                },
                activeColor: Color.fromARGB(255, 5, 143, 164),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        //title: Text('SingUp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    'مالذي يحفزك على ممارسة الرياضة',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                _customCheckbox(1, 'تحسين الحالة الصحية'),
                const SizedBox(height: 20),
                _customCheckbox(2, 'تحسين المظهر'),
                const SizedBox(height: 20),
                _customCheckbox(3, 'زيادة القوة البدنية'),
                SizedBox(height: 180.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0.h),
                  child: RoundButton(
                    title: 'التالي',
                    onPress: () {
                      // Navigator.pushNamed(context, RoutesName.profiledetails);
                      if (_formKey.currentState?.validate() ?? false) {
                        // Validate radio buttons
                        if (selectedValues.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  'يرجى اختيار ما يحفزك على ممارسة الرياضة'),
                            ),
                          );
                          return;
                        }

                        // Form is valid, proceed with the navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => profiledetailsscreen(
                              name: widget.name,
                              selectDate: widget.selectDate,
                              selectedGender: widget.selectedGender,
                              selectedphysicallyActive:
                                  widget.selectedphysicallyActive,
                              selectedGoal: widget.selectedGoal,
                              selectedBodyType: widget.selectedBodyType,
                              selectedBodyGoal: widget.selectedBodyGoal,
                              selectedMotivation: selectedMotivation,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class profiledetailsscreen extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;
  final String? selectedphysicallyActive;
  final String? selectedGoal;
  final String? selectedBodyType;
  final String? selectedBodyGoal;
  final List<String> selectedMotivation;
  const profiledetailsscreen({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    required this.selectedphysicallyActive,
    required this.selectedGoal,
    required this.selectedBodyType,
    required this.selectedBodyGoal,
    required this.selectedMotivation,
    Key? key,
  }) : super(key: key);

  @override
  State<profiledetailsscreen> createState() => _profiledetailsscreenState();
}

class _profiledetailsscreenState extends State<profiledetailsscreen> {
  int selectedWeight = 0; // Default selected weight in kg
  // int targetWeight = 0;
  int length = 0; // Default selected length in cm
  int selectedweightGoal = 0;
  int selectedLengthGoal = 0;
  // int selectedtargetweightGoal = 0; // Default selected length in cm

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showWeightPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 30, 30, 43),
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 250.h,
            width: 280.w,
            child: Column(
              children: [
                SizedBox(
                  height: 150.h,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedWeight - 45),
                    itemExtent: 32,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedWeight = index + 45;
                        selectedweightGoal = selectedWeight;
                      });
                    },
                    children: List<Widget>.generate(76, (int index) {
                      return Text(
                        (index + 45).toString(),
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 40.h,
                  width: 180.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 6, 159, 182),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'تم',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _showTargetWeightPicker(BuildContext context) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Center(
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           height: 250.h,
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 150.h,
  //                 child: CupertinoPicker(
  //                   scrollController: FixedExtentScrollController(
  //                       initialItem: targetWeight - 45),
  //                   itemExtent: 32,
  //                   onSelectedItemChanged: (int index) {
  //                     setState(() {
  //                       targetWeight = index + 45;
  //                       selectedtargetweightGoal = targetWeight;
  //                     });
  //                   },
  //                   children: List<Widget>.generate(76, (int index) {
  //                     return Text(
  //                       (index + 45).toString(),
  //                       style: const TextStyle(fontSize: 20),
  //                     );
  //                   }),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 30.h,
  //               ),
  //               Container(
  //                 height: 40.h,
  //                 width: 200.w,
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: const Color.fromARGB(255, 30, 99, 196),
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10.0),
  //                     ),
  //                   ),
  //                   child: Text(
  //                     'تم',
  //                     style: TextStyle(
  //                         fontSize: 20.sp,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showLenthtPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 30, 30, 43),
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 250.h,
            width: 280.w,
            child: Column(
              children: [
                SizedBox(
                  height: 150.h,
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: length - 140),
                    itemExtent: 35,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        length = index + 140;
                        selectedLengthGoal = length;
                      });
                    },
                    children: List<Widget>.generate(71, (int index) {
                      return Text(
                        (index + 140).toString(),
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 40.h,
                  width: 180.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 6, 159, 182),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'تم',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        //title: Text('SingUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Text(
                  'تفاصيل الملف الشخصي',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 8.0.w, right: 25.0.w, bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("الوزن",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _showWeightPicker(context);
                },
                child: Container(
                  height: 50.h,
                  width: 280.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 30, 30, 43),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$selectedWeight kg',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        Icon(Icons.add, size: 25.sp, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 8.0.w, right: 25.0.w, bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("الطول",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _showLenthtPicker(context);
                },
                child: Container(
                  height: 50.h,
                  width: 280.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 30, 30, 43),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$length cm',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        Icon(Icons.add, size: 25.sp, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 170.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0.h),
                child: RoundButton(
                  title: 'التالي',
                  onPress: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Validate selectedWeight
                      if (selectedWeight == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('يرجى اختيار الوزن'),
                          ),
                        );
                        return;
                      }

                      // Validate length
                      if (length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('يرجى اختيار الطول'),
                          ),
                        );
                        return;
                      }

                      // Form is valid, proceed with the navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => targetzonescreen(
                            name: widget.name,
                            selectDate: widget.selectDate,
                            selectedGender: widget.selectedGender,
                            selectedphysicallyActive:
                                widget.selectedphysicallyActive,
                            selectedGoal: widget.selectedGoal,
                            selectedBodyType: widget.selectedBodyType,
                            selectedBodyGoal: widget.selectedBodyGoal,
                            selectedMotivation: widget.selectedMotivation,
                            selectedWeight: selectedweightGoal.toString(),
                            selectedLength: selectedLengthGoal.toString(),
                            // selectedtargetWeight: selectedtargetweightGoal.toString(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class targetzonescreen extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;
  final String? selectedphysicallyActive;
  final String? selectedGoal;
  final String? selectedBodyType;
  final String? selectedBodyGoal;
  final List<String> selectedMotivation;
  final String? selectedWeight;
  final String? selectedLength;
  // final String? selectedtargetWeight;
  const targetzonescreen({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    required this.selectedphysicallyActive,
    required this.selectedGoal,
    required this.selectedBodyType,
    required this.selectedBodyGoal,
    required this.selectedMotivation,
    required this.selectedWeight,
    required this.selectedLength,
    // required this.selectedtargetWeight,
    Key? key,
  }) : super(key: key);

  @override
  State<targetzonescreen> createState() => _targetzonescreenState();
}

class _targetzonescreenState extends State<targetzonescreen> {
  List<int> selectedValues = []; // Selected checkbox values
  List<String> selectedTargetZone = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleCheckboxValueChanged(int value) {
    setState(() {
      if (selectedValues.contains(value)) {
        selectedValues.remove(value);
      } else {
        selectedValues.add(value);
      }
      if (value == 1) {
        selectedTargetZone.add('الصدر');
      } else if (value == 2) {
        selectedTargetZone.add('الذراعين');
      } else if (value == 3) {
        selectedTargetZone.add('البطن');
      } else if (value == 4) {
        selectedTargetZone.add('الرجلين');
      } else {
        selectedTargetZone = [];
      }
    });
  }

  Widget _customCheckbox(int value, String label) {
    return Container(
      height: 50.h,
      width: 280.w,
      child: ElevatedButton(
        onPressed: () {
          _handleCheckboxValueChanged(value);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedValues.contains(value)
              ? const Color.fromARGB(255, 6, 159, 182)
              : const Color.fromARGB(255, 30, 30, 43),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
                // selectedValue == value
                //     ? const Color.fromARGB(255, 30, 30, 43)
                //     : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        //title: Text('SingUp'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/targetzone.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'اختر منطقة الهدف',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 120.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 90.w, child: _customCheckbox(1, 'الصدر')),
                      Container(
                          width: 90.w, child: _customCheckbox(2, 'الذراعين')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 90.w, child: _customCheckbox(3, 'البطن')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 90.w, child: _customCheckbox(4, 'الرجلين')),
                    ],
                  ),
                ),
                SizedBox(height: 140.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0.h),
                  child: RoundButton(
                    title: 'التالي',
                    onPress: () {
                      // Navigator.pushNamed(context, RoutesName.signUp);

                      if (_formKey.currentState?.validate() ?? false) {
                        // Validate radio buttons
                        if (selectedValues.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('يرجى اختيار منطقة الهدف'),
                            ),
                          );
                          return;
                        }

                        // Form is valid, proceed with the navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpView(
                              name: widget.name,
                              selectDate: widget.selectDate,
                              selectedGender: widget.selectedGender,
                              selectedphysicallyActive:
                                  widget.selectedphysicallyActive,
                              selectedGoal: widget.selectedGoal,
                              selectedBodyType: widget.selectedBodyType,
                              selectedBodyGoal: widget.selectedBodyGoal,
                              selectedMotivation: widget.selectedMotivation,
                              selectedWeight: widget.selectedWeight,
                              selectedLength: widget.selectedLength,
                              // selectedtargetWeight: widget.selectedtargetWeight,
                              selectedTargetZone: selectedTargetZone,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpView extends StatefulWidget {
  final TextEditingController name;
  final String? selectDate;
  final String? selectedGender;
  final String? selectedphysicallyActive;
  final String? selectedGoal;
  final String? selectedBodyType;
  final String? selectedBodyGoal;
  final List<String> selectedMotivation;
  final String? selectedWeight;
  final String? selectedLength;
  // final String? selectedtargetWeight;
  final List<String> selectedTargetZone;
  const SignUpView({
    required this.name,
    required this.selectDate,
    required this.selectedGender,
    required this.selectedphysicallyActive,
    required this.selectedGoal,
    required this.selectedBodyType,
    required this.selectedBodyGoal,
    required this.selectedMotivation,
    required this.selectedWeight,
    required this.selectedLength,
    // required this.selectedtargetWeight,
    required this.selectedTargetZone,
    Key? key,
  }) : super(key: key);

  static String verify = "";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  // var phone = '';

  void dispose() {
    // Dispose of the TextEditingController to prevent memory leaks.
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    // countryController.text = "+218";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50.0.h),
        child: Container(
          height: 500.h,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "قم بادخال بيانات التسجيل الخاصة بك",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 50.h,
                    width: 280.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                              child: TextFormField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "اسم المستخدم",
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(10)),
                                //         backgroundColor: Colors.red,
                                //         content:
                                //             Text('الرجاء ادخال اسم المستخدم'),
                                //         // You can customize the SnackBar appearance and duration here
                                //       ),
                                //     );
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    height: 50.h,
                    width: 280.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "كلمة المرور",
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(10)),
                                //         backgroundColor: Colors.red,
                                //         content:
                                //             Text('الرجاء ادخال كلمة المرور'),
                                //         // You can customize the SnackBar appearance and duration here
                                //       ),
                                //     );
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "نحن بحاجة إلى تسجيل رقم هاتفك قبل البدء !",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 50.h,
                    width: 280.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                controller: countryController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixText: "+218",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 130.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0.h),
                    child: SizedBox(
                      height: 44.h,
                      width: 250.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 6, 159, 182),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              countryController.text.isNotEmpty &&
                              usernameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            final signUpData = {
                              "aim": widget.selectedBodyGoal,
                              "birthday": widget.selectDate,
                              "focuson": widget.selectedTargetZone.join(':'),
                              "height": widget.selectedLength,
                              "ismale": bool.fromEnvironment(
                                  widget.selectedGender ?? ''),
                              "name": widget.name.text,
                              "weight": widget.selectedWeight,
                              "bodytype": widget.selectedBodyType,
                              "objective": widget.selectedMotivation.join(':'),
                              "phone": "0${countryController.text}",
                              "username": usernameController.text,
                              "password": _passwordController.text,
                              "goal": widget.selectedGoal,
                            };

                            authViewModel.signUpApi(context, signUpData);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.red,
                                content:
                                    Text('الرجاء ملء جميع الحقول المطلوبة'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "تسجيل",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class Verifyphone extends StatefulWidget {
//   const Verifyphone({Key? key}) : super(key: key);

//   @override
//   State<Verifyphone> createState() => _VerifyphoneState();
// }

// class _VerifyphoneState extends State<Verifyphone> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );

//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
//       borderRadius: BorderRadius.circular(8),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: const Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );

//     var code = "";
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 15, 15, 24),
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.white,
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: Container(
//         margin: const EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 25,
//               ),
//               const Text(
//                 "التحقق من الهاتف",
//                 style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               /*Text(
//                 "We need to register your phone without getting started!",
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),*/
//               const SizedBox(
//                 height: 30,
//               ),
//               Directionality(
//                 textDirection: ui.TextDirection.ltr,
//                 child: Pinput(
//                   length: 6,
//                   // defaultPinTheme: defaultPinTheme,
//                   // focusedPinTheme: focusedPinTheme,
//                   // submittedPinTheme: submittedPinTheme,
//                   onChanged: (value) {
//                     code = value;
//                   },
//                   showCursor: true,
//                   onCompleted: (pin) => print(pin),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: const Color.fromARGB(255, 30, 99, 196),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () async {
//                       try {
//                         PhoneAuthCredential credential =
//                             PhoneAuthProvider.credential(
//                                 verificationId: SignUpView.verify,
//                                 smsCode: code);

//                         // Sign the user in (or link) with the credential
//                         await auth.signInWithCredential(credential);
//                         Navigator.pushNamed(
//                             context, RoutesName.physicalactivity);
//                       } catch (e) {
//                         print('wrong otp');
//                       }
//                     },
//                     child: const Text("التحقق من رقم الهاتف")),
//               ),
//               /*Row(
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pushNamedAndRemoveUntil(
//                           context,
//                           'phone',
//                           (route) => false,
//                         );
//                       },
//                       child: Text(
//                         "Edit Phone Number ?",
//                         style: TextStyle(color: Colors.black),
//                       ))
//                 ],
//               )*/
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
