import 'package:flutter/material.dart';
import 'package:smartkrishi_consumer_app/models/product_model.dart';
import 'package:smartkrishi_consumer_app/models/sample_data_provider.dart';
import 'package:smartkrishi_consumer_app/screens/home_screen/widgets/custom_search_bar.dart';
import 'package:smartkrishi_consumer_app/screens/home_screen/widgets/product_card.dart';
import 'filter_screen.dart';

class SearchScreenPage extends StatefulWidget {
  final String? initialQuery;

  const SearchScreenPage({super.key, this.initialQuery});

  @override
  State<SearchScreenPage> createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreenPage> {
  late TextEditingController _searchController;
  late SampleDataProvider _dataProvider;
  late SearchFilters _currentFilters;
  late List<Product> _searchResults;
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    _dataProvider = SampleDataProvider();
    _currentFilters = SearchFilters();
    _searchResults = _dataProvider.getAllProducts();

    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _performSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchResults = _dataProvider.searchProducts(
        query,
        filters: _currentFilters,
      );
    });
  }

  void _applyFilters(SearchFilters filters) {
    setState(() {
      _currentFilters = filters;
      if (_searchController.text.isNotEmpty) {
        _performSearch(_searchController.text);
      } else {
        _searchResults = _dataProvider.searchProducts('', filters: filters);
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _currentFilters = SearchFilters();
      _searchResults = _dataProvider.getAllProducts();
      if (_searchController.text.isNotEmpty) {
        _performSearch(_searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters =
        _currentFilters.maxPrice != 5000 ||
        _currentFilters.minRating != 0 ||
        _currentFilters.isOrganic ||
        _currentFilters.selectedCategories.isNotEmpty;

    debugPrint('Search results: $_searchResults');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Search Products',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 🔹 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              controller: _searchController,
              onChanged: (query) {
                _performSearch(query);
              },
              onFilterTap: () async {
                final filters = await Navigator.push<SearchFilters>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FilterScreen(initialFilters: _currentFilters),
                  ),
                );
                if (filters != null) {
                  _applyFilters(filters);
                }
              },
            ),
          ),

          // 🔹 Active Filters
          if (hasActiveFilters)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Active Filters',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: _clearFilters,
                        child: const Text(
                          'Clear All',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (_currentFilters.maxPrice != 5000)
                        _FilterChip(
                          label:
                              '₹${_currentFilters.minPrice}-${_currentFilters.maxPrice}',
                        ),
                      if (_currentFilters.minRating > 0)
                        _FilterChip(
                          label:
                              '${_currentFilters.minRating.toStringAsFixed(1)}★+',
                        ),
                      if (_currentFilters.isOrganic)
                        const _FilterChip(label: 'Organic'),
                      if (_currentFilters.selectedCategories.isNotEmpty)
                        _FilterChip(
                          label:
                              '${_currentFilters.selectedCategories.length} categories',
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

          // 🔹 Header Row (Results + Toggle)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_searchResults.length} results found',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _isGridView = true),
                      child: Icon(
                        Icons.grid_view,
                        size: 20,
                        color: _isGridView
                            ? const Color(0xFF1B8A6E)
                            : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => setState(() => _isGridView = false),
                      child: Icon(
                        Icons.list,
                        size: 20,
                        color: !_isGridView
                            ? const Color(0xFF1B8A6E)
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 RESULTS AREA (ONLY SCROLLABLE PART)
          Expanded(
            child: _searchResults.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 48, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters or search terms',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _clearFilters();
                            _searchController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B8A6E),
                          ),
                          child: const Text('Reset Filters'),
                        ),
                      ],
                    ),
                  )
                : _isGridView
                    ? GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.62,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: _searchResults[index],
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
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final product = _searchResults[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.image),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(product.name),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1B8A6E).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label),
    );
  }
}