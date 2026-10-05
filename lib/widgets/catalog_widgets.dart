import 'package:flutter/material.dart';
import '../models/book.dart';

class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => SafeArea(
      child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child:
                  Padding(padding: const EdgeInsets.all(20), child: child))));
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});
  final ReadingStatus status;
  @override
  Widget build(BuildContext context) => Chip(
      avatar: const Icon(Icons.bookmark_outline, size: 18),
      label: Text(status.label));
}

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book, required this.onTap});
  final Book book;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: onTap,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.auto_stories_outlined, size: 32),
                    const SizedBox(height: 12),
                    Text(book.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 6),
                    Text('${book.author} • ${book.year}'),
                    const SizedBox(height: 8),
                    StatusBadge(status: book.status),
                    const SizedBox(height: 4),
                    const Row(children: [
                      Expanded(child: Text('Ver detalhes')),
                      Icon(Icons.arrow_forward, semanticLabel: 'Abrir livro')
                    ]),
                  ]))));
}
