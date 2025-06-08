import 'dart:developer';

import 'package:coin_market_api1/data/repository/coin_repository.dart';
import 'package:coin_market_api1/domain/entities/coin/coin_entity.dart';
import 'package:get/get.dart';

class CoinsViewModel extends GetxController {
  static const List<String> defaultSymbols = [
    "BTC","ETH","SOL","BNB","BCH","MKR","AAVE","DOT","SUI","ADA","XRP","TIA","NEO","NEAR","PENDLE","RENDER","LINK","TON","XAI","SEI",
    "IMX","ETHFI","UMA","SUPER","FET","USUAL","GALA","PAAL","AERO"
  ];

  CoinsViewModel({required CoinRepository coinRepository}):_coinRepository=coinRepository;

  @override
  void onInit() {
    log("Teste");
    super.onInit();
    // Do not call getCoins here
  }

  var coins = <CoinEntity>[].obs;
  var isLoading = false.obs;

  final CoinRepository _coinRepository;

  List<String> processSymbols(String searchText) {
    final input = searchText.trim();
    return input.isEmpty
        ? defaultSymbols
        : input
            .split(',')
            .map((e) => e.trim().toUpperCase())
            .where((e) => e.isNotEmpty)
            .toList();
  }

  void getCoins(List<String> symbols) async {
    try {
      isLoading.value = true;
      final result = await _coinRepository.getCoins(symbols);
      coins.value = result;
      log(result.toString());
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}