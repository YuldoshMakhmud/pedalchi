import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodchi/common/shimmers/foodlist_shimmer.dart';
import 'package:foodchi/constants/constants.dart';
import 'package:foodchi/hooks/fetch_foods.dart';
import 'package:foodchi/models/foods_model.dart';
import 'package:foodchi/views/home/widgets/food_tile.dart';

class XploreWidget extends HookWidget {
  const XploreWidget({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoods(code);
    final foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
      backgroundColor: kLightWhite,
      body: isLoading
          ? const FoodsListShimmer()
          : SizedBox(
              height: height * 0.7,
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(foods.length, (index) {
                  final FoodsModel food = foods[index];
                  return FoodTile(food: food);
                }),
              ),
            ),
    );
  }
}
