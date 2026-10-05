# Meu Catálogo

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

## Subir ao GitHub e fixar a versão

Crie um repositório vazio e acessível ao professor. Nesta pasta:

```sh
git init
git add .
git commit -m "Trabalho final: Meu Catalogo"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
git push -u origin main
git tag entrega-v1
git push origin entrega-v1
git rev-parse HEAD
```

Guarde o hash completo e informe no PDF a URL e a tag `entrega-v1`.
Se modificar o código depois, crie uma nova tag e atualize o PDF.
Não mova uma tag já usada como referência de avaliação.

## Preparar o PDF

O PDF tem campos editáveis para nome, matrícula, repositório e versão.
Preencha todos, salve uma cópia e renomeie para
`M1_trabalho_final_SUA_MATRICULA_SEU_NOME.pdf`.
Se o build Android ainda estiver pendente, execute o workflow, confirme
o resultado e acrescente a evidência do APK antes de enviar. Confira a
matriz de critérios do PDF e compare com o modelo oficial da disciplina,
que não foi disponibilizado nesta conversa.

Abra o PDF salvo, teste o link do repositório, confira tag/hash e legibilidade.
A entrega ao professor é somente o PDF; o código e o APK ficam no repositório
ou artefatos identificados na mesma versão.
