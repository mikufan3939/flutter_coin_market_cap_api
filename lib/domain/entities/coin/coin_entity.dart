import 'dart:core';

final class CoinEntity{
  final String symbol;
  final String name;
  final double usd;
  final double brl;

  CoinEntity({required this.symbol, required this.name, required this.usd, required this.brl});

  factory CoinEntity.fromMap(Map<String, dynamic> map){
    return CoinEntity(symbol: map["symbol"], name:map["name"], usd:map["usd"], brl:map["brl"]);
  }

  @override
  String toString() {
    return 'CoinEntity(symbol: $symbol, name: $name, usd: $usd, brl: $brl)';
  }
}