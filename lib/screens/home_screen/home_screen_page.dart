import 'package:flutter/material.dart';
import 'package:smartkrishi_consumer_app/models/product_model.dart';
import 'package:smartkrishi_consumer_app/models/sample_data_provider.dart';
import 'package:smartkrishi_consumer_app/data/repositories/product_repository.dart';
import 'package:smartkrishi_consumer_app/data/models/api_product.dart';
import 'widgets/custom_search_bar.dart';
import 'widgets/flash_sale_card.dart';
import 'widgets/product_card.dart';
import 'widgets/trending_crop_card.dart';
import 'widgets/farm_card.dart';
import '../scanner/scanner.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  late TextEditingController _searchController;
  final SampleDataProvider _dataProvider = SampleDataProvider();
  final ProductRepository _productRepo = ProductRepository();
  int _currentPageIndex = 0;

  late List<FlashSale> flashSales;
  late List<TrendingCrop> trendingCrops;
  late List<Farm> nearbyFarms;

  // API-loaded products
  List<ApiProduct> _apiProducts = [];
  bool _isLoadingProducts = true;
  String? _productsError;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // These stay hardcoded until farmer DB has this data
    flashSales = _dataProvider.getFlashSales();
    trendingCrops = _dataProvider.getTrendingCrops();
    nearbyFarms = _dataProvider.getNearbyFarms();

    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final page = await _productRepo.getProducts(limit: 20);
      if (mounted) {
        setState(() {
          _apiProducts = page.products;
          _isLoadingProducts = false;
        });
      }
    } catch (e) {
      // Fallback to hardcoded data if API is not deployed yet
      if (mounted) {
        setState(() {
          _isLoadingProducts = false;
          _productsError = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SmartKrishi',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Fresh from Farm to Table',
              style: TextStyle(color: Colors.grey[500], fontSize: 11),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 LOCATION
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFF1B8A6E),
                    size: 20,
                  ),
                  const SizedBox(width: 8),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery to',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Delhi NCR, india',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔥 SCAN NOW BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ScannerPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 16,
                            color: Color(0xFF1B8A6E),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Scan Now",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B8A6E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 SEARCH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(
                controller: _searchController,
                onSearchTap: () => Navigator.pushNamed(context, '/search'),
                onFilterTap: () =>
                    Navigator.pushNamed(context, '/search/filter'),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 FLASH SALES
            if (flashSales.isNotEmpty) ...[
              _sectionHeader('⚡ Flash Sales'),
              const SizedBox(height: 12),

              SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: flashSales.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 300,
                        child: FlashSaleCard(
                          flashSale: flashSales[index],
                          onTap: () {},
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],

            // 🔥 SEASONAL PICKS (from API or fallback)
            if (_isLoadingProducts) ...[
              _sectionHeader('🌿 Smart Seasonal Picks'),
              const SizedBox(height: 12),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(
                    color: Color(0xFF1B8A6E),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ] else ...[
              _sectionHeader('🌿 Smart Seasonal Picks'),
              const SizedBox(height: 12),

              if (_apiProducts.isNotEmpty)
                // Use API products
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount:
                        _apiProducts.length > 4 ? 4 : _apiProducts.length,
                    itemBuilder: (context, index) {
                      final ap = _apiProducts[index];
                      // Convert to Product for existing ProductCard widget
                      final product = Product(
                        id: ap.id,
                        name: ap.name,
                        farmName: ap.farmerName,
                        price: ap.price,
                        unit: ap.unit,
                        rating: ap.rating,
                        reviewCount: 0,
                        freshness: 90,
                        imageAsset: ap.imageUrl,
                        distance: 0,
                        organic: ap.organic,
                      );
                      return ProductCard(
                        product: product,
                        onTap: () {},
                        onAddToCart: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart'),
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              else
                // Fallback to hardcoded data
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _dataProvider.getAllProducts().take(4).length,
                    itemBuilder: (context, index) => ProductCard(
                      product:
                          _dataProvider.getAllProducts().take(4).toList()[index],
                      onTap: () {},
                      onAddToCart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to cart'),
                            duration: Duration(milliseconds: 800),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              const SizedBox(height: 20),
            ],

            // 🔹 TRENDING
            if (trendingCrops.isNotEmpty) ...[
              _sectionHeader('📈 Trending This Week'),
              const SizedBox(height: 12),

              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: trendingCrops.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 150,
                      child: TrendingCropCard(
                        crop: trendingCrops[index],
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],

            // 🔹 FARMS
            if (nearbyFarms.isNotEmpty) ...[
              _sectionHeader('🏡 Nearby Farms'),
              const SizedBox(height: 12),

              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: nearbyFarms.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 200,
                      child: FarmCard(farm: nearbyFarms[index], onTap: () {}),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() => _currentPageIndex = index);
          if (index == 1) {
            Navigator.pushNamed(context, '/subscriptions');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/cart');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/orders');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard),
            label: 'Subscriptions',
          ),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.receipt), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
