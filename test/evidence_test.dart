import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meu_catalogo/main.dart';
import 'package:meu_catalogo/models/book.dart';
import 'package:meu_catalogo/state/catalog.dart';

void main() {
  testWidgets('Capturas reais de listagem, vazio, detalhe e validação',
      (tester) async {
    await tester.runAsync(() async {
      final font = FontLoader('Roboto');
      font.addFont(Future.value(ByteData.sublistView(
          File('C:/Windows/Fonts/segoeui.ttf').readAsBytesSync())));
      await font.load();
      final icons = FontLoader('MaterialIcons');
      icons.addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
      await icons.load();
    });
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final boundaryKey = GlobalKey();
    final catalog = Catalog();
    addTearDown(catalog.dispose);
    await tester.pumpWidget(
        RepaintBoundary(key: boundaryKey, child: CatalogApp(catalog: catalog)));
    await tester.pumpAndSettle();
    Future<void> capture(String name) async {
      await tester.pumpAndSettle();
      final boundary = boundaryKey.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 2);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        Directory('evidencias').createSync(recursive: true);
        File('evidencias/$name.png')
            .writeAsBytesSync(bytes!.buffer.asUint8List());
        image.dispose();
      });
      expect(tester.takeException(), isNull);
    }

    await capture('01_vazio_360');
    catalog.save(const Book(
        id: '1',
        title: 'Dom Casmurro',
        author: 'Machado de Assis',
        year: 1899,
        status: ReadingStatus.reading,
        notes: 'Uma leitura para revisitar a literatura brasileira.'));
    catalog.save(const Book(
        id: '2',
        title: 'O Pequeno Príncipe',
        author: 'Antoine de Saint-Exupéry',
        year: 1943,
        status: ReadingStatus.want));
    await capture('02_lista_360');
    tester.view.physicalSize = const Size(900, 1000);
    await capture('03_lista_900');
    tester.view.physicalSize = const Size(360, 800);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dom Casmurro'));
    await capture('04_detalhe');
    await tester.tap(find.byKey(const Key('editBook')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('title')), '');
    await capture('05_validacao');
    await tester.enterText(
        find.byKey(const Key('title')), 'Dom Casmurro - relido');
    await tester.ensureVisible(find.byKey(const Key('saveBook')));
    await tester.tap(find.byKey(const Key('saveBook')));
    await capture('06_editado');
  }, skip: !File('C:/Windows/Fonts/segoeui.ttf').existsSync());
}
