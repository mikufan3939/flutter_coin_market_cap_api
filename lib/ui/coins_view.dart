import 'package:coin_market_api1/ui/coins_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinsView extends StatelessWidget {
  const CoinsView({super.key});

  @override
  Widget build(BuildContext context) {
    final coinsViewModel = Get.find<CoinsViewModel>();
    final TextEditingController searchController = TextEditingController(text: "");
    final RxString searchSymbols = "".obs;

    Future<void> fetchCoins() async {
      final symbols = coinsViewModel.processSymbols(searchSymbols.value);
      coinsViewModel.getCoins(symbols);
    }

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: kToolbarHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Repeating background image
              Image.asset(
                "lib/ui/assets/bg.jpg",
                repeat: ImageRepeat.repeatX,
                fit: BoxFit.cover,
              ),
              // Title text on top
              Center(
                child: Stack(
                  children: [
                    // Stroke
                    Text(
                      "BU\$CA CRIPTO MA\$TER 3000",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Fill
                    Text(
                      "BU\$CA CRIPTO MASTER 3000",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Optional: make AppBar bg transparent
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: "Siglas (ex: BTC,ETH)",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => searchSymbols.value = value,
                    onSubmitted: (_) => fetchCoins(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: fetchCoins,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6D97A), // Softer Meowth gold
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Buscar"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (coinsViewModel.isLoading.value) {
                return const Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF6D97A)), // Meowth gold
                ));
              }
              return RefreshIndicator(
                onRefresh: fetchCoins,
                color: const Color(0xFFF6D97A), // Meowth gold - Color of the refresh indicator
                backgroundColor: Colors.black, // Background color of the refresh indicator
                child: coinsViewModel.coins.isEmpty
                    ? ListView(
                        children: [
                          const SizedBox(height: 80),
                          Center(
                            child: Image.asset(
                              "lib/ui/assets/meowth.jpg",
                              width: 120,
                              height: 120,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              "Nenhuma moeda carregada.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          // Meowth as faded background
                          Positioned.fill(
                            child: IgnorePointer(
                              child: Opacity(
                                opacity: 0.08, // Lower opacity for background
                                child: Image.asset(
                                  "lib/ui/assets/meowth.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // Coins list on top
                          ListView.separated(
                            itemCount: coinsViewModel.coins.length,
                            itemBuilder: (context, index) {
                              final coin = coinsViewModel.coins[index];
                              return ListTile(
                                title: Text(coin.name),
                                subtitle: Text(coin.symbol),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("${coin.name} (${coin.symbol})"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("USD: \$${coin.usd.toStringAsFixed(2)}"),
                                          Text("BRL: R\$${coin.brl.toStringAsFixed(2)}"),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFFF6D97A), // Softer Meowth gold
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                          ),
                                          child: const Text("Fechar"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(height: 1),
                          ),
                        ],
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}