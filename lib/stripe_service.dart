import 'dart:convert';

import 'package:http/http.dart' as http;

class StripeService {
  static String secretKey = 'sk_test_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  String publishableKey = 'pk_test_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';

  static Future<dynamic> createCheckoutSession(
    List<dynamic> productItems,
    totalAmount,
  ) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

    String lineItems = "";
    int index = 0;

    productItems.forEach(
      (val) {
        var productPrice = (val["productPrice"] * 100).round().toString();
        lineItems +=
            "&line_items|[$index][price_data][product_data][name]=${val['productName']}";
        lineItems +=
            "&line_items [$index][price_data][unit_amount]=$productPrice";
        lineItems +=
            "&line_items [$index][price_data][product_data][currency]=EUR";
        lineItems += "&line_items[$index][qty]=${val['qty'].toString()}";

        index++;
      },
    );

    final response = await http.post(
      url,
      body:
          'success_url=https://checkout.stripe.dev/success&mode=payments$lineItems',
      headers: {'Authorization': "Bearer $secretKey"},
    );

    return json.decode(response.body);
  }
}
