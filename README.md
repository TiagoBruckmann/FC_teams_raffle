# fc_teams_raffle

An app for all FIFA players or any other soccer game.

```
# Versionamento
#
# ┌────── Marcos
# │ ┌─────── Épicos
# │ │ ┌──────── Funcionalidade nova (reseta ao finalizar um marco/Épico)
# │ │ │
# 1.1.1
```

---

### :star: Compilação Bundle release da loja android

```sh
    flutter build appbundle --release
```

---

### :star2: Compilação APK release com ofuscação de codigo

```sh
    flutter build apk --split-per-abi --release
```

---

## :gear: Flutter Setup
```sh
    flutter pub get
    flutter pub run flutter_native_splash:create
    flutter pub run flutter_launcher_icons
    flutter pub run build_runner build
    flutter run
```

## :bulb: Caso algo não estiver funcionando adequadamente
```sh
    flutter clean
    rm -rf pubspec.lock
    flutter pub get
    flutter pub run flutter_native_splash:create
    flutter pub run flutter_launcher_icons
    flutter pub run build_runner build --delete-conflicting-outputs
    flutter run
```

---

### :gear: MacOS Setup

```sh
cd ios/

pod clean
pod cache
pod deintegrate
pod install
```

---

### :gear: Configurações do firebase debug - ANDROID
Para que os dados do firebase não sejam poluidos com dados do desenvolvimento precisa ser utilizado o comando abaixo para que todos os logs e ações dentro do app de desenvolvimento seja realocada no setor de dev do proprio firebase. Este comando ativará o modo depuração do analytics até que seja desativado.

```
adb shell setprop debug.firebase.analytics.app dev.tiagobruckmann.fc_teams_drawer

Execute o app em modo debug -> Vá para as opções de desenvolvedor -> Selecione app debug -> selecione o app fc_teams_drawer

o processo acima irá exibir o dispositivo no debugview.
```

Desativar depuração

```
adb shell setprop debug.firebase.analytics.app .none.
```

---
