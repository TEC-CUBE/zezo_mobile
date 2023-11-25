import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/meals_model.dart';
import '../view_model/meals_view_model.dart';

class MealsScreen extends StatefulWidget {
  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final MealsAPI mealsAPI = MealsAPI();
  List<Meal> meals = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMeals();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMeals() async {
    final List<Meal> newMeals = await mealsAPI.fetchMeals();
    setState(() {
      meals.addAll(newMeals);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchMeals(); // Load more data when the user reaches the end of the list
    }
  }

  void _showMealDetails(Meal meal) {
    final imageUrl = meal.image; // Define imageUrl here

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 500.h,
          color: const Color.fromARGB(255, 15, 15, 24),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300.w,
                  height: 200.h,
                  color: Colors.transparent,
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/meal.png',
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: 16.h),
                Column(
                  children: [
                    Text(meal.name,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("الكمية:  ${meal.weight}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color.fromARGB(
                                        255, 255, 250, 250))),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("الدهون:  ${meal.fat}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color.fromARGB(
                                        255, 255, 250, 250))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 6, 159, 182)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("السعرات الحرارية:  ${meal.calories}",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color:
                                    const Color.fromARGB(255, 255, 250, 250))),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("الكربوهيدرات:  ${meal.carb}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color.fromARGB(
                                        255, 255, 250, 250))),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("البروتين:  ${meal.protein}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color.fromARGB(
                                        255, 255, 250, 250))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
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
        title: Text("الوجبات"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: 
      ListView.builder(
        controller: _scrollController,
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final imageUrl = meals[index].image;

          return GestureDetector(
            onTap: () {
              _showMealDetails(meals[index]);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 60.h,
              child: ListTile(
                title: Text(
                  meals[index].name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  "Calories: ${meals[index].calories}",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                leading: Container(
                  width: 100.w,
                  height: 100.h,
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/meal.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
