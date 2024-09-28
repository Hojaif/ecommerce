import 'package:e_commerce_flutter/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'app_bar_action_button.dart';
import 'custom_search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const CustomAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBarActionButton(
              icon: Icons.menu,
              onPressed: () {
                var flutterCart = FlutterCart();
                int  getCartCount = flutterCart.cartLength;
                double  getCarttotal = flutterCart.total;
                print(getCartCount);
                print(getCarttotal);
               // flutterCart.clearCart();
                Scaffold.of(context).openDrawer();
              },
            ),
            Expanded(
              child: CustomSearchBar(
                controller: TextEditingController(),
                onChanged: (val) {
                  context.dataProvider.filterProducts(val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
