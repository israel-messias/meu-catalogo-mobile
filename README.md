# Meu Catálogo

## Versão publicada para avaliação

- Repositório: https://github.com/israel-messias/meu-catalogo-mobile
- Tag imutável: `entrega-v1`
- Commit do código avaliado: `81dd77e62975ec7f313df5e5066652262ef2c796`
- Build aprovado: https://github.com/israel-messias/meu-catalogo-mobile/actions/runs/37245793995
- APK: https://github.com/israel-messias/meu-catalogo-mobile/releases/tag/entrega-v1

Formatação, análise estática, três widget tests e geração do APK debug foram
concluídos com sucesso no GitHub Actions. A release corresponde ao commit
da tag. Commits posteriores que acrescentam documentação não alteram essa
versão do aplicativo. A instalação em aparelho Android não foi auditada.

Catálogo pessoal de livros para Desenvolvimento Mobile I. Flutter e Dart,
Material 3, idioma português. Três telas: coleção, detalhe e formulário.
Estado em memória: encerrar o app elimina os dados. Não usa API, Firebase,
autenticação ou persistência.

## Executar

Instale o Flutter estável e configure um dispositivo/emulador Android.

```sh
flutter pub get
flutter run
```

## Validar e gerar Android

```sh
dart format lib test
flutter analyze
flutter test test/widget_test.dart
flutter build apk --debug
```

APK: `build/app/outputs/flutter-apk/app-debug.apk`. A versão debug é um
artefato Android instalável para avaliação acadêmica, sem publicação em loja.
O workflow em `.github/workflows/validar.yml` executa as verificações e
disponibiliza o APK como artefato da execução no GitHub Actions.

## Evidências reais

`evidencias/` contém capturas renderizadas pelo Flutter em teste de widget,
com dimensões lógicas de 360 x 800 e 900 x 1000. Não são fotos de emulador.
O teste de fluxo cadastra e edita; o teste de adaptação também usa texto 150%.
Para regenerar capturas no Windows com Segoe UI:

```sh
flutter test test/evidence_test.dart
```

O teste de captura carrega a fonte local `C:/Windows/Fonts/segoeui.ttf`.
Em outros sistemas, adapte esse caminho a uma fonte disponível antes de
executá-lo. O teste funcional não depende dessa fonte.
O teste de captura é ignorado automaticamente se a fonte Windows não existir.

Nesta preparação, os testes passaram com `--no-test-assets`, reutilizando
o bundle criado pelo Flutter, pois a política de segurança do Windows
bloqueou o compilador do shader padrão. O app usa `InkRipple` e dispensa
esse shader em execução. Em ambiente configurado normalmente, use os
comandos de validação acima sem essa opção.

## Recuperar a versão avaliada

```sh
git clone https://github.com/israel-messias/meu-catalogo-mobile.git
cd meu-catalogo-mobile
git checkout entrega-v1
flutter pub get
flutter run
```

A tag `entrega-v1` identifica exatamente o código compilado. Se modificar
o aplicativo, crie outra tag e atualize a versão citada no relatório.

## Preparar o PDF

O PDF individual preenchido é entregue diretamente ao aluno. Ele contém
o repositório, o hash completo, a tag e a execução de build desta versão.
Confira a matriz de critérios do PDF e compare com o modelo oficial da
disciplina, que não foi disponibilizado nesta conversa.

Abra o PDF salvo, teste o link do repositório, confira tag/hash e legibilidade.
A entrega ao professor é somente o PDF; o código e o APK ficam no repositório
ou artefatos identificados na mesma versão.
