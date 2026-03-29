/// Assets configuration for SmartKrishi app
/// All asset paths are centralized here for easy management and consistency

class AppAssets {
  // ===== ONBOARDING ASSETS =====
  static const String onboarding1 = 'assets/images/onboarding1.svg';
  static const String onboarding2 = 'assets/images/onboarding2.svg';
  static const String onboarding3 = 'assets/images/onboarding3.svg';

  // ===== AUTH ASSETS =====
  static const String googleLogo = 'assets/images/google_logo.svg';
  static const String profilePlaceholder =
      'assets/images/profile_placeholder.svg';

  // ===== PRODUCT IMAGES =====
  static const String alphansoMangoes = 'assets/images/alphonso_mangoes.svg';
  static const String cherryTomatoes = 'assets/images/cherry_tomatoes.svg';
  static const String mountainPotato = 'assets/images/mountain_potato.svg';
  static const String organicRomaTomatoes =
      'assets/images/organic_roma_tomatoes.svg';
  static const String vineCherryTomatoes =
      'assets/images/vine_cherry_tomatoes.svg';
  static const String hybridSaladTomatoes =
      'assets/images/hybrid_salad_tomatoes.svg';

  // ===== CATEGORY ICONS =====
  static const String categoryVegetables =
      'assets/images/category_vegetables.svg';
  static const String categoryFruits = 'assets/images/category_fruits.svg';
  static const String categoryGrains = 'assets/images/category_grains.svg';
  static const String categoryDairy = 'assets/images/category_dairy.svg';
  static const String categoryOrganic = 'assets/images/category_organic.svg';
  static const String categoryExotic = 'assets/images/category_exotic.svg';
  static const String categorySpices = 'assets/images/category_spices.svg';
  static const String categorySeeds = 'assets/images/category_seeds.svg';

  // ===== UI ICONS =====
  static const String iconFilter = 'assets/images/icon_filter.svg';
  static const String iconLocation = 'assets/images/icon_location.svg';
  static const String iconFarm = 'assets/images/icon_farm.svg';

  // ===== ASSET LISTS =====
  static const List<String> onboardingImages = [
    onboarding1,
    onboarding2,
    onboarding3,
  ];

  static const List<String> categoryImages = [
    categoryVegetables,
    categoryFruits,
    categoryGrains,
    categoryDairy,
    categoryOrganic,
    categoryExotic,
    categorySpices,
    categorySeeds,
  ];

  static const List<String> populartProducts = [
    alphansoMangoes,
    cherryTomatoes,
    mountainPotato,
    organicRomaTomatoes,
    vineCherryTomatoes,
    hybridSaladTomatoes,
  ];

  // Asset directories
  static const String imagesDir = 'assets/images/';
  static const String fontsDir = 'assets/fonts/';
}
