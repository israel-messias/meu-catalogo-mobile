import 'package:flutter/material.dart';
import '../state/catalog.dart';
import '../widgets/catalog_widgets.dart';
import 'form_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.catalog, required this.id});
  final Catalog catalog;
  final String id;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Detalhes do livro')),
      body: PageBody(
          child: ListenableBuilder(
              listenable: catalog,
              builder: (context, _) {
                final book = catalog.find(id);
                if (book == null) {
                  return const Center(child: Text('Livro removido.'));
                }
                return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Icon(Icons.auto_stories_outlined, size: 64),
                      const SizedBox(height: 20),
                      Text(book.title,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 12),
                      Text('Autor: ${book.author}'),
                      Text('Ano de publicação: ${book.year}'),
                      const SizedBox(height: 12),
                      StatusBadge(status: book.status),
                      const Divider(height: 32),
                      Text('Minhas notas',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(book.notes.isEmpty
                          ? 'Nenhuma nota adicionada.'
                          : book.notes),
                      const SizedBox(height: 24),
                      Wrap(spacing: 12, runSpacing: 12, children: [
                        FilledButton.icon(
                            key: const Key('editBook'),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                    builder: (_) => BookFormScreen(
                                        catalog: catalog, book: book))),
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Editar livro')),
                        OutlinedButton.icon(
                            onPressed: () async {
                              final approved = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text('Excluir livro?'),
                                          content: const Text(
                                              'O livro será removido desta sessão.'),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                child: const Text('Cancelar')),
                                            FilledButton(
                                                onPressed: () => Navigator.pop(
                                                    context, true),
                                                child: const Text('Excluir'))
                                          ]));
                              if (approved != true || !context.mounted) return;
                              catalog.remove(id);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Livro excluído.')));
                            },
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Excluir livro')),
                      ]),
                    ]));
              })));
}
