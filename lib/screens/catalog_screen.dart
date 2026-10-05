import 'package:flutter/material.dart';
import '../state/catalog.dart';
import '../widgets/catalog_widgets.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, required this.catalog});
  final Catalog catalog;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Meu Catálogo')),
      floatingActionButton: FloatingActionButton.extended(
          key: const Key('addBook'),
          tooltip: 'Cadastrar livro',
          onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => BookFormScreen(catalog: catalog))),
          icon: const Icon(Icons.add),
          label: const Text('Novo livro')),
      body: PageBody(
          child: ListenableBuilder(
              listenable: catalog,
              builder: (context, _) =>
                  LayoutBuilder(builder: (context, constraints) {
                    if (catalog.books.isEmpty) {
                      return Center(
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                            const Icon(Icons.menu_book_outlined, size: 72),
                            const SizedBox(height: 16),
                            Text('Sua estante começa aqui',
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 8),
                            const Text(
                                'Cadastre seu primeiro livro em Novo livro.',
                                textAlign: TextAlign.center),
                            const SizedBox(height: 80),
                          ])));
                    }
                    final columns = constraints.maxWidth >= 640 ? 2 : 1;
                    final width =
                        (constraints.maxWidth - (columns - 1) * 12) / columns;
                    return SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 88),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${catalog.books.length} livro(s) na sua estante',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 16),
                              Wrap(spacing: 12, runSpacing: 12, children: [
                                for (final book in catalog.books)
                                  SizedBox(
                                      width: width,
                                      child: BookCard(
                                          book: book,
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute<void>(
                                                  builder: (_) => DetailScreen(
                                                      catalog: catalog,
                                                      id: book.id))))),
                              ]),
                            ]));
                  }))));
}
