import 'dart:math';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../src/controller/product_controller.dart';


class CartListSection extends StatelessWidget {
  final List<Product> cartProducts;
  final ProductController controller = Get.find<ProductController>();

  CartListSection({
    super.key,
    required this.cartProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: cartProducts.mapWithIndex((index, _) {
            Product product = cartProducts[index];
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[200]?.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            product.images[0],
                            width: 100,
                            height: 90,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.getCurrentSize(product),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.isPriceOff(product) ? "\$${product.off}" : "\$${product.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                  // Add and remove cart item
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 10.0,
                          onPressed: () => controller.decreaseItemQuantity(product),
                          icon: const Icon(
                            Icons.remove,
                            color: Color(0xFFEC6813),
                          ),
                        ),
                        Text(
                          '${product.quantity}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          splashRadius: 10.0,
                          onPressed: () => controller.increaseItemQuantity(product),
                          icon: const Icon(Icons.add, color: Color(0xFFEC6813)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<E> mapWithIndex<E>(E Function(int index, T value) f) {
    return Iterable.generate(length).map((i) => f(i, elementAt(i)));
  }
}

