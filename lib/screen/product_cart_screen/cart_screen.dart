import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';

import '../../utility/animation/animated_switcher_wrapper.dart';
import 'components/cart_list_section.dart';
import 'components/empty_cart.dart';


final ProductController controller = Get.put(ProductController());

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "My cart",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.getCartItems();
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.isEmptyCart
              ? const EmptyCart()
              : CartListSection(cartProducts: controller.cartProducts),

          //? total price section
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                Obx(
                  () {
                    return AnimatedSwitcherWrapper(
                      child: Text(
                        "\$${controller.totalPrice.value}",
                        key: ValueKey<int>(controller.totalPrice.value),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFEC6813),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          //? buy now button
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                onPressed: controller.isEmptyCart ? null : () {},
                child: const Text("Buy Now"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
