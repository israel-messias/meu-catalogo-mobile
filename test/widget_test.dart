import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meu_catalogo/main.dart';
import 'package:meu_catalogo/models/book.dart';
import 'package:meu_catalogo/state/catalog.dart';

void main() {
  testWidgets('Valida, cadastra, abre detalhe e edita o mesmo livro',
      (tester) async {
    await tester.pumpWidget(const CatalogApp());
    expect(find.text('Sua estante começa aqui'), findsOneWidget);
    await tester.tap(find.byKey(const Key('addBook')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('saveBook')));
    await tester.tap(find.byKey(const Key('saveBook')));
    await tester.pumpAndSettle();
    expect(find.text('Campo obrigatório.'), findsNWidgets(2));
    await tester.enterText(find.byKey(const Key('title')), 'Dom Casmurro');
    await tester.enterText(find.byKey(const Key('author')), 'Machado de Assis');
    await tester.enterText(find.byKey(const Key('year')), '1899');
    await tester.ensureVisible(find.byKey(const Key('saveBook')));
    await tester.tap(find.byKey(const Key('saveBook')));
    await tester.pumpAndSettle();
    expect(find.text('Livro cadastrado.'), findsOneWidget);
    expect(find.text('Dom Casmurro'), findsOneWidget);
    await tester.tap(find.text('Dom Casmurro'));
    await tester.pumpAndSettle();
    expect(find.text('Autor: Machado de Assis'), findsOneWidget);
    await tester.tap(find.byKey(const Key('editBook')));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key('title')), 'Dom Casmurro - relido');
    await tester.ensureVisible(find.byKey(const Key('saveBook')));
    await tester.tap(find.byKey(const Key('saveBook')));
    await tester.pumpAndSettle();
    expect(find.text('Dom Casmurro - relido'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Dom Casmurro - relido'), findsOneWidget);
    expect(find.text('1 livro(s) na sua estante'), findsOneWidget);
  });

  for (final size in [const Size(360, 800), const Size(900, 1000)]) {
    testWidgets('Telas sem overflow em $size e texto ampliado', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final catalog = Catalog(initial: [
        const Book(
            id: '1',
            title:
                'Um título longo para verificar a adaptação do cartão de livro',
            author: 'Um nome de autor extenso para testar a quebra de linha',
            year: 2020,
            status: ReadingStatus.reading)
      ]);
      addTearDown(catalog.dispose);
      await tester.pumpWidget(CatalogApp(catalog: catalog));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.textContaining('Um título longo'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.byKey(const Key('editBook')));
      await tester.tap(find.byKey(const Key('editBook')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
