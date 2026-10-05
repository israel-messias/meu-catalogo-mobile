import 'package:flutter/material.dart';
import '../models/book.dart';
import '../state/catalog.dart';
import '../widgets/catalog_widgets.dart';

class BookFormScreen extends StatefulWidget {
  const BookFormScreen({super.key, required this.catalog, this.book});
  final Catalog catalog;
  final Book? book;
  @override
  State<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  final formKey = GlobalKey<FormState>();
  late final title = TextEditingController(text: widget.book?.title);
  late final author = TextEditingController(text: widget.book?.author);
  late final year = TextEditingController(text: widget.book?.year.toString());
  late final notes = TextEditingController(text: widget.book?.notes);
  late ReadingStatus status = widget.book?.status ?? ReadingStatus.want;
  @override
  void dispose() {
    title.dispose();
    author.dispose();
    year.dispose();
    notes.dispose();
    super.dispose();
  }

  String? requiredText(String? value) =>
      value == null || value.trim().isEmpty ? 'Campo obrigatório.' : null;
  void save() {
    if (!formKey.currentState!.validate()) return;
    final editing = widget.book != null;
    widget.catalog.save(Book(
        id: widget.book?.id ?? widget.catalog.newId(),
        title: title.text.trim(),
        author: author.text.trim(),
        year: int.parse(year.text.trim()),
        status: status,
        notes: notes.text.trim()));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(editing ? 'Livro atualizado.' : 'Livro cadastrado.')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: Text(widget.book == null ? 'Novo livro' : 'Editar livro')),
      body: PageBody(
          child: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                            'Título, autor e ano são obrigatórios. Os dados ficam nesta sessão.'),
                        const SizedBox(height: 20),
                        TextFormField(
                            key: const Key('title'),
                            controller: title,
                            decoration: const InputDecoration(
                                labelText: 'Título',
                                border: OutlineInputBorder()),
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 120,
                            textInputAction: TextInputAction.next,
                            validator: requiredText),
                        const SizedBox(height: 16),
                        TextFormField(
                            key: const Key('author'),
                            controller: author,
                            decoration: const InputDecoration(
                                labelText: 'Autor',
                                border: OutlineInputBorder()),
                            textCapitalization: TextCapitalization.words,
                            maxLength: 100,
                            textInputAction: TextInputAction.next,
                            validator: requiredText),
                        const SizedBox(height: 16),
                        TextFormField(
                            key: const Key('year'),
                            controller: year,
                            decoration: const InputDecoration(
                                labelText: 'Ano de publicação',
                                hintText: 'Ex.: 1899',
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              final number = int.tryParse(value?.trim() ?? '');
                              if (number == null ||
                                  number < 1 ||
                                  number > DateTime.now().year) {
                                return 'Informe um ano entre 1 e ${DateTime.now().year}.';
                              }
                              return null;
                            }),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<ReadingStatus>(
                            initialValue: status,
                            isExpanded: true,
                            decoration: const InputDecoration(
                                labelText: 'Situação de leitura',
                                border: OutlineInputBorder()),
                            items: [
                              for (final item in ReadingStatus.values)
                                DropdownMenuItem(
                                    value: item, child: Text(item.label))
                            ],
                            onChanged: (value) =>
                                setState(() => status = value ?? status)),
                        const SizedBox(height: 20),
                        TextFormField(
                            key: const Key('notes'),
                            controller: notes,
                            minLines: 3,
                            maxLines: 6,
                            maxLength: 1000,
                            decoration: const InputDecoration(
                                labelText: 'Notas (opcional)',
                                border: OutlineInputBorder())),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                            key: const Key('saveBook'),
                            onPressed: save,
                            icon: const Icon(Icons.check),
                            label: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text('Salvar livro'))),
                        const SizedBox(height: 24),
                      ])))));
}
