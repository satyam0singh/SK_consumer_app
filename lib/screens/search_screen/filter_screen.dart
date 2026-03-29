import 'package:flutter/material.dart';
import 'package:smartkrishi_consumer_app/models/product_model.dart';

class FilterScreen extends StatefulWidget {
  final SearchFilters initialFilters;

  const FilterScreen({super.key, required this.initialFilters});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late double _minPrice;
  late double _maxPrice;
  late double _minRating;
  late bool _isOrganic;
  late Set<String> _selectedCategories;

  final List<String> _allCategories = [
    'Vegetables',
    'Fruits',
    'Grains',
    'Dairy',
    'Organic',
    'Exotic',
    'Spices',
    'Seeds',
  ];

  @override
  void initState() {
    super.initState();
    _minPrice = widget.initialFilters.minPrice.toDouble();
    _maxPrice = widget.initialFilters.maxPrice.toDouble();
    _minRating = widget.initialFilters.minRating;
    _isOrganic = widget.initialFilters.isOrganic;
    _selectedCategories = Set.from(widget.initialFilters.selectedCategories);
  }

  void _resetFilters() {
    setState(() {
      _minPrice = 100;
      _maxPrice = 5000;
      _minRating = 0;
      _isOrganic = false;
      _selectedCategories.clear();
    });
  }

  void _applyFilters() {
    final filters = SearchFilters(
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      minRating: _minRating,
      isOrganic: _isOrganic,
      selectedCategories: _selectedCategories.toList(),
    );
    Navigator.pop(context, filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Filters',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(onPressed: _resetFilters, child: const Text('Reset')),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Price Range Filter
            _FilterSection(
              title: 'Price Range',
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${_minPrice.toInt()}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '₹${_maxPrice.toInt()}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RangeSlider(
                      values: RangeValues(_minPrice, _maxPrice),
                      min: 100,
                      max: 5000,
                      divisions: 49,
                      labels: RangeLabels(
                        '₹${_minPrice.toInt()}',
                        '₹${_maxPrice.toInt()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _minPrice = values.start;
                          _maxPrice = values.end;
                        });
                      },
                      activeColor: const Color(0xFF1B8A6E),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Rating Filter
            _FilterSection(
              title: 'Minimum Rating',
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Slider(
                      value: _minRating,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      label: '${_minRating.toStringAsFixed(1)}★',
                      onChanged: (value) {
                        setState(() => _minRating = value);
                      },
                      activeColor: Colors.amber[600],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Any', style: TextStyle(fontSize: 12)),
                        Text(
                          '${_minRating.toStringAsFixed(1)}★+',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Organic Filter
            _FilterSection(
              title: 'Product Type',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CheckboxListTile(
                  title: const Text(
                    'Certified Organic Only',
                    style: TextStyle(fontSize: 13),
                  ),
                  value: _isOrganic,
                  onChanged: (value) {
                    setState(() => _isOrganic = value ?? false);
                  },
                  activeColor: const Color(0xFF1B8A6E),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Category Filter
            _FilterSection(
              title: 'Categories',
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _allCategories.map((category) {
                    final isSelected = _selectedCategories.contains(category);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedCategories.remove(category);
                          } else {
                            _selectedCategories.add(category);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF1B8A6E)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? null
                              : Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1B8A6E),
                  side: const BorderSide(color: Color(0xFF1B8A6E)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B8A6E),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
