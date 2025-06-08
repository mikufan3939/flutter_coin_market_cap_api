import 'dart:core';

final class CoinEntity{
  final String symbol;
  final String name;
  final double usd;
  final double brl;
  final String dateAdded; // Add this line

  CoinEntity({required this.symbol, required this.name, required this.usd, required this.brl, required this.dateAdded}); // Add this to the constructor

  factory CoinEntity.fromMap(Map<String, dynamic> map){
    return CoinEntity(symbol: map["symbol"], name:map["name"], usd:map["usd"], brl:map["brl"], dateAdded: map["dateAdded"]); // Include dateAdded
  }

  @override
  String toString() {
    return 'CoinEntity(symbol: $symbol, name: $name, usd: $usd, brl: $brl, dateAdded: $dateAdded)'; // Include dateAdded in toString
  }
}