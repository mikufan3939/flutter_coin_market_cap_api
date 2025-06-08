import 'dart:developer';
import 'package:coin_market_api1/data/datasource/coinmarket_source.dart';
import 'package:coin_market_api1/domain/entities/coin/coin_entity.dart';

final class CoinRepository {
  final CoinMarketSource _coinMarketSource;
  const CoinRepository(this._coinMarketSource);

  Future<List<CoinEntity>> getCoins(List<String> symbols) async {
    String baseUri = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=";
    String symbolParam = symbols.join(",");
    String uriUsd = "$baseUri$symbolParam&convert=USD";
    String uriBrl = "$baseUri$symbolParam&convert=BRL";

    try {
      // Fetch USD prices
      final dataUsd = await _coinMarketSource.getCoins(uriUsd);
      // Fetch BRL prices
      final dataBrl = await _coinMarketSource.getCoins(uriBrl);

      List<CoinEntity> result = [];
      for (var symbol in symbols) {
        final coinUsdList = dataUsd[symbol];
        final coinBrlList = dataBrl[symbol];
        if (coinUsdList is List && coinUsdList.isNotEmpty && coinBrlList is List && coinBrlList.isNotEmpty) {
          final coinUsd = coinUsdList[0];
          final coinBrl = coinBrlList[0];

          // Parse the date string
          DateTime? dateAdded = DateTime.tryParse(coinUsd["date_added"] ?? "");

          // Format the date if it's valid
          String formattedDate = dateAdded != null
              ? "${dateAdded.day.toString().padLeft(2, '0')}/${dateAdded.month.toString().padLeft(2, '0')}/${dateAdded.year}"
              : "N/A";

          result.add(
            CoinEntity(
              symbol: coinUsd["symbol"],
              name: coinUsd["name"],
              usd: (coinUsd["quote"]?["USD"]?["price"] as num?)?.toDouble() ?? 0.0,
              brl: (coinBrl["quote"]?["BRL"]?["price"] as num?)?.toDouble() ?? 0.0,
              dateAdded: formattedDate, // Use the formatted date
            ),
          );
        }
      }
      return result;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}