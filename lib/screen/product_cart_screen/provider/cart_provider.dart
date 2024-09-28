import 'package:e_commerce_flutter/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';

class ProductDetailProvider extends ChangeNotifier {
  var flutterCart = FlutterCart();

  void addToCart(Product product) {
    flutterCart.addToCart(
      cartModel: CartModel(
          productId: '${product.sId}',
          productName: '${product.name}',
          variants: [ ProductVariant(price: product.price ?? 0)],
          productDetails: '${product.description}'),
    );
  //  flutterCart.clearCart();
  }

  clearCart(){

  }
}
