import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import '../../../../utility/app_color.dart';
import '../../../../widget/carousel_slider.dart';
import '../../../../widget/page_wrapper.dart';
import 'components/product_rating_section.dart';


final ProductController controller = Get.put(ProductController());

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});





  Widget productSizesListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.sizeType(product).length,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () => controller.switchBetweenProductSizes(product, index),
          child: AnimatedContainer(
            margin: const EdgeInsets.only(right: 5, left: 5),
            alignment: Alignment.center,
            width: controller.isNominal(product) ? 40 : 70,
            decoration: BoxDecoration(
              color: controller.sizeType(product)[index].isSelected == false ? Colors.white : AppColor.lightOrange,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 0.4,
              ),
            ),
            duration: const Duration(milliseconds: 300),
            child: FittedBox(
              child: Text(
                controller.sizeType(product)[index].numerical,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? product image section
                Container(
                  height: height * 0.42,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E6E8),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                    ),
                  ),
                  child: CarouselSlider(items: product.images),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //? product nam e
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      //? product rating section
                      const ProductRatingSection(),
                      const SizedBox(height: 10),
                      //? product rate , offer , stock section
                      Row(
                        children: [
                          Text(
                            product.off != null ? "\$${product.off}" : "\$${product.price}",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(width: 3),
                          Visibility(
                            visible: product.off != null ? true : false,
                            child: Text(
                              "\$${product.price}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.isAvailable ? "Available stock : 10" : "Not available",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      //? product description
                      Text(
                        "About",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(product.about),
                      const SizedBox(height: 40),
                      //? add to cart button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: product.isAvailable ? () => controller.addToCart(product) : null,
                          child: const Text("Add to cart"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
