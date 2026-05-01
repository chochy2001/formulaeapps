enum FormulaeFlavor {
  pro,
  community,
}

class FormulaeConfig {
  const FormulaeConfig({
    required this.flavor,
    required this.appTitle,
    required this.adsEnabled,
    required this.paidFeaturesEnabled,
  });

  final FormulaeFlavor flavor;
  final String appTitle;
  final bool adsEnabled;
  final bool paidFeaturesEnabled;

  bool get isPro => flavor == FormulaeFlavor.pro;
  bool get isCommunity => flavor == FormulaeFlavor.community;

  static const pro = FormulaeConfig(
    flavor: FormulaeFlavor.pro,
    appTitle: 'Formulae Pro',
    adsEnabled: false,
    paidFeaturesEnabled: true,
  );

  static const community = FormulaeConfig(
    flavor: FormulaeFlavor.community,
    appTitle: 'Formulae Community',
    adsEnabled: true,
    paidFeaturesEnabled: false,
  );

  static const current = String.fromEnvironment(
            'FLAVOR',
            defaultValue: 'pro',
          ) ==
          'community'
      ? community
      : pro;
}
