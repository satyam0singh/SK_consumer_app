import 'package:flutter/material.dart';
import 'package:smartkrishi_consumer_app/models/product_model.dart';


class TrendingCropCard extends StatelessWidget {
  final TrendingCrop crop;
  final VoidCallback? onTap;

  const TrendingCropCard({
    super.key,
    required this.crop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDemandHigh = crop.demandChange > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ FIX OVERFLOW
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: Container(
                height: 90,
                width: double.infinity,
                color: crop.backgroundColor.withOpacity(0.12),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    crop.iconAsset, // ✅ individual image per crop
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey[400],
                      );
                    },
                  ),
                ),
              ),
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAME
                  Text(
                    crop.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// ✅ ONLY SHOW IF DEMAND IS INCREASING
                  if (isDemandHigh)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '↑',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${crop.demandChange}% Demand',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 8),

                  /// PRICE
                  Text(
                    '₹${crop.averagePrice.toStringAsFixed(0)}/${crop.unit}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B8A6E),
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// FARMS
                  Text(
                    '${crop.farmCount} farms available',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}