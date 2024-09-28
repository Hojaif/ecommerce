import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../utility/app_color.dart';
import '../../../../widget/custom_app_bar.dart';
import '../../../../widget/product_grid_view.dart';
import '../../src/controller/product_controller.dart';
import 'components/category_selector.dart';
import 'components/poster_section.dart';


enum AppbarActionType { leading, trailing }

final ProductController controller = Get.put(ProductController());

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllItems();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello Sina",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "Lets gets somethings?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const PosterSection(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top categories",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(foregroundColor: AppColor.darkOrange),
                      child: Text(
                        "SEE ALL",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.deepOrange.withOpacity(0.7)),
                      ),
                    )
                  ],
                ),
                CategorySelector(
                  categories: controller.categories,
                  onItemPressed: (index) {
                    controller.filterItemsByCategory(index);
                  },
                ),
                GetBuilder(builder: (ProductController controller) {
                  return ProductGridView(
                    items: controller.filteredProducts,
                    likeButtonPressed: (index) => controller.isFavorite(index),
                    isPriceOff: (product) => controller.isPriceOff(product),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }




}
