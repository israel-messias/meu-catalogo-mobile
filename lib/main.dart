import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'state/catalog.dart';
import 'screens/catalog_screen.dart';

void main() => runApp(const CatalogApp());

class CatalogApp extends StatefulWidget {
  const CatalogApp({super.key, this.catalog});
  final Catalog? catalog;
  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  late final Catalog catalog = widget.catalog ?? Catalog();
  @override
  void dispose() {
    if (widget.catalog == null) catalog.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Meu Catálogo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pt', 'BR')],
      theme: ThemeData(
          useMaterial3: true,
          splashFactory: InkRipple.splashFactory,
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xFF315B50))),
      home: CatalogScreen(catalog: catalog));
}
