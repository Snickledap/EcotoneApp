import 'package:flutter/material.dart';
//import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
//import '../assets/images/collection_tab.dart';
//import '../assets/images/home_tab.dart';
//import '../assets/images/profile_tab.dart';
//import '../assets/images/search_tab.dart';

void main() {

  ShopifyConfig.setConfig(
      '1c584d6955933b3778eb41a11e01e93a', // Storefront API access token.
      'https://ecotonerenewables.com/', // Store url.
      '2022-06'); // The Shopify Storefront API version.

  runApp(MyApp());
}
