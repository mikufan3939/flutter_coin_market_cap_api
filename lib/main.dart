import 'package:coin_market_api1/data/datasource/coinmarket_source.dart';
import 'package:coin_market_api1/data/repository/coin_repository.dart';
import 'package:coin_market_api1/ui/coins_view.dart';
import 'package:coin_market_api1/ui/coins_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  final coinMarketSource = CoinMarketSource();
  final coinRepository = CoinRepository(coinMarketSource);

  // Register the ViewModel with GetX
  Get.put(CoinsViewModel(coinRepository: coinRepository));

  runApp(MaterialApp(
    home: CoinsView(), // Don't pass the ViewModel manually
  ));
}
