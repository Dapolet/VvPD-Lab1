# Сборка и запуск на macOS

Документ описывает подготовку окружения и команды для всех 13 реализаций из
[README.md](README.md) на macOS. Примеры рассчитаны на **Apple Silicon (arm64)**;
на Intel Mac всё работает, кроме assembler-варианта из этого репозитория (см.
[Assembler](#assembler)).

Все команды выполняются из **корня репозитория** (каталог, где лежит этот файл),
если не указано иное.

## 1. Что понадобится

| Компонент | Зачем | Откуда |
| --- | --- | --- |
| Xcode Command Line Tools | `clang`, `clang++`, заголовочные файлы, `make` | Apple |
| Homebrew | установка остальных инструментов | https://brew.sh |
| Python 3 | Python | Homebrew |
| Node.js + npm | JavaScript, TypeScript | Homebrew |
| TypeScript (`tsc`) | компиляция TypeScript | npm |
| OpenJDK 21 | Java | Homebrew |
| .NET SDK 9 | C#, F# | Homebrew Cask |
| Go | Go | Homebrew |
| Rust | Rust | Homebrew |
| GNU Bash 5 | Bash-реализация | Homebrew |
| SWI-Prolog | Prolog | Homebrew |

## 2. Установка инструментов

### 2.1. Xcode Command Line Tools

```bash
xcode-select --install
```

Если инструменты уже установлены, команда покажет соответствующее сообщение.
При необходимости принять лицензию:

```bash
sudo xcodebuild -license accept
```

Проверка:

```bash
clang --version
clang++ --version
```

### 2.2. Homebrew

Если Homebrew ещё нет:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

На Apple Silicon Homebrew ставится в `/opt/homebrew`. Добавьте его в `PATH`
(команда `brew shellenv` печатает нужные строки):

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Чтобы настройка сохранилась, добавьте эту же строку в `~/.zshrc`:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
```

### 2.3. Все инструменты одной командой

```bash
brew install python node go rust bash swi-prolog openjdk@21
brew install --cask dotnet-sdk@9
npm install -g typescript
```

Пояснения:

- `openjdk@21` — keg-only формула, поэтому её нужно дополнительно подключить
  (см. [Java](#java)).
- `dotnet-sdk@9` ставит SDK 9.0.x, под который настроены проекты `net9.0`.
  Cask может поставить и актуальный SDK рядом; это нормально.
- `typescript` ставится глобально через npm. Если глобальная установка недоступна
  (например, из-за прав), используйте `nvm` или настройте npm-prefix
  (см. [Частые ошибки](#частые-ошибки)).

### 2.4. Проверка окружения

```bash
clang --version
python3 --version
node --version
npm --version
tsc --version
javac --version
java --version
dotnet --version
go version
rustc --version
bash --version | head -n 1
swipl --version
```

Версии могут быть новее указанных в README — это допустимо, команды сборки и
запуска не меняются.

## 3. Быстрая шпаргалка

| Язык | Команда из корня репозитория |
| --- | --- |
| C | `cd c && clang -Wall -Wextra -pedantic main.c -o main && ./main` |
| C++ | `cd cpp && clang++ -Wall -Wextra -pedantic main.cpp -o main && ./main` |
| Python | `cd python && python3 main.py` |
| JavaScript | `cd javascript && node main.js` |
| TypeScript | `cd typescript && tsc main.ts --outDir dist && node dist/main.js` |
| Java | `cd java && javac Main.java && java Main` |
| C# | `cd csharp && dotnet run --nologo` |
| F# | `cd fsharp && dotnet run --nologo` |
| Go | `cd go && go run main.go` |
| Rust | `cd rust && rustc main.rs -o main && ./main` |
| Bash | `cd bash && bash main.sh` |
| Prolog | `cd prolog && swipl -q -s main.pl -g main -t halt` |
| Assembler (arm64) | `bash asm/build.sh && ./asm/build/assembler` |

Все 13 реализаций печатают три одинаковые по смыслу строки; ожидаемый вывод
приведён в README.

## 4. Подробно по языкам

### C

```bash
cd c
clang -Wall -Wextra -pedantic main.c -o main
./main
```

На macOS команда `gcc` — это ссылка на Apple Clang, поэтому вариант из README
(`gcc ...`) тоже работает. Явный `clang` понятнее показывает, какой компилятор
используется.

Очистка:

```bash
rm -f main ./*.o
```

### C++

```bash
cd cpp
clang++ -Wall -Wextra -pedantic main.cpp -o main
./main
```

Аналогично C, `g++` на macOS по умолчанию является Apple Clang. Можно добавить
`-std=c++17` — код совместим.

Очистка:

```bash
rm -f main ./*.o
```

### Python

Компиляция не нужна:

```bash
cd python
python3 main.py
```

Если `python3` указывает на старую системную версию, проверьте:

```bash
python3 --version
command -v python3
```

Homebrew-версия обычно находится в `/opt/homebrew/bin/python3`.

### JavaScript

```bash
cd javascript
node main.js
```

### TypeScript

```bash
cd typescript
tsc main.ts --outDir dist
node dist/main.js
```

Команда совпадает с `scripts/run_all.sh`. Если ваша версия `tsc` по умолчанию
компилирует в слишком старый стандарт и ругается на `padStart`, укажите цель
явно:

```bash
tsc main.ts --outDir dist --target ES2022
node dist/main.js
```

Очистка: `rm -rf dist`.

### Java

Сначала подключите OpenJDK 21 из Homebrew:

```bash
export PATH="$(brew --prefix openjdk@21)/bin:$PATH"
sudo ln -sfn "$(brew --prefix openjdk@21)/libexec/openjdk.jdk" \
  /Library/Java/JavaVirtualMachines/openjdk-21.jdk
```

Строку с `export PATH=...` добавьте в `~/.zshrc`, чтобы `javac` и `java` были
доступны в новых терминалах. Симлинк нужен, чтобы Java находилась через
`/usr/libexec/java_home`.

Проверка и запуск:

```bash
javac -version
cd java
javac Main.java
java Main
```

`javac` создаёт байт-код `Main.class`, который затем исполняет JVM. Очистка:
`rm -f ./*.class`.

### C#

```bash
cd csharp
dotnet run --nologo
```

Первый запуск автоматически восстанавливает зависимости и собирает проект
`LabCSharp.csproj` (целевая платформа `net9.0`). Для сборки без запуска:

```bash
dotnet build --nologo
```

Очистка: `dotnet clean` либо `rm -rf bin obj`.

### F#

```bash
cd fsharp
dotnet run --nologo
```

Проект — `LabFSharp.fsproj`, платформа `net9.0`. Очистка: `rm -rf bin obj`.

### Go

```bash
cd go
go run main.go
```

`go run` компилирует программу во временный исполняемый файл и сразу запускает
его. Явная сборка:

```bash
go build -o main main.go
./main
```

### Rust

```bash
cd rust
rustc main.rs -o main
./main
```

`rustc` создаёт нативный исполняемый файл без отдельной системы сборки.
Очистка: `rm -f main`.

### Bash

```bash
cd bash
bash main.sh
```

Скрипт использует `printf -v`, поэтому подходит и системный Bash 3.2, но для
соответствия README лучше поставить GNU Bash 5:

```bash
brew install bash
bash --version | head -n 1
```

### Prolog

```bash
cd prolog
swipl -q -s main.pl -g main -t halt
```

- `-q` — без приветствия интерпретатора;
- `-s main.pl` — загрузить файл;
- `-g main` — вызвать предикат `main`;
- `-t halt` — завершить процесс после выполнения.

### Assembler

В репозитории есть два варианта:

| Файл | Платформа | Сборка |
| --- | --- | --- |
| `asm/assembler_arm64_macos.s` | macOS Apple Silicon (arm64) | Apple Clang, Mach-O |
| `asm/assembler_x86_64_linux.s` | Linux/WSL x86-64 | GNU as, ELF |

Для macOS используется **только arm64-вариант**. Универсальный скрипт сам
определяет платформу и складывает результат в `asm/build/` (каталог исключён
из Git):

```bash
bash asm/build.sh
./asm/build/assembler
```

Ручная сборка:

```bash
cd asm
clang -c assembler_arm64_macos.s -o assembler_arm64.o
clang assembler_arm64.o -o assembler
./assembler
```

Проверить архитектуру:

```bash
uname -m      # arm64 — Apple Silicon, x86_64 — Intel
```

На Intel Mac `asm/build.sh` завершится ошибкой: x86-64-вариант в этом проекте
собран под Linux (ELF, System V AMD64 ABI) и не собирается нативным macOS
тулчейном. В этом случае используйте Apple Silicon, Linux или WSL.

## 5. Собрать и запустить всё сразу

```bash
bash scripts/run_all.sh
```

Скрипт последовательно собирает и запускает все реализации и печатает вывод с
заголовками `=== C ===`, `=== C++ ===` и т. д.

Полная проверка вывода:

```bash
bash scripts/check_output.sh
```

На Intel Mac эта проверка не пройдёт из-за assembler-секции — это ограничение
репозитория, а не ошибка установки.

## 6. Особенности macOS

1. **Компилятор по умолчанию — Clang.** `gcc` и `g++` в `/usr/bin` являются
   обёртками Apple Clang. Команды из README работают, но в этом документе
   используется явный `clang`/`clang++`.
2. **Две архитектуры.** На Apple Silicon `uname -m` возвращает `arm64`, на
   Intel — `x86_64`. Нативные сборки Go, Rust и .NET нужно делать на той же
   машине, где они будут запускаться.
3. **UTF-8 уже настроен.** Terminal.app и iTerm2 работают в UTF-8, поэтому
   кириллица в C/C++ выводится без `chcp` и дополнительных настроек. Код
   `SetConsoleCP`/`SetConsoleOutputCP` в `c/main.c` и `cpp/main.cpp` включён
   только под `_WIN32` и на macOS не выполняется.
4. **Системный Bash — 3.2.** Для проекта достаточно и его, но Homebrew-версия
   ближе к окружению из README. После `brew install bash` проверьте
   `command -v bash`: должен использоваться `/opt/homebrew/bin/bash`.
5. **Homebrew на разных Mac.** На Apple Silicon префикс — `/opt/homebrew`, на
   Intel — `/usr/local`. Используйте `$(brew --prefix ...)`, как в разделе про
   Java, чтобы команды были переносимыми.
6. **Артефакты сборки.** Исполняемые файлы `main`, `*.class`, `bin/`, `obj/`,
   `dist/` и `asm/build/` уже перечислены в `.gitignore` и не попадут в коммит.

## 7. Частые ошибки

| Симптом | Причина | Решение |
| --- | --- | --- |
| `xcrun: error: invalid active developer path` | не установлены или сломаны Command Line Tools | `xcode-select --install`, затем при необходимости `sudo xcode-select -s /Library/Developer/CommandLineTools` |
| `clang: error: no such file or directory` | команда выполнена не из каталога языка | перейдите в нужный каталог, например `cd c` |
| `tsc: command not found` | глобальный каталог npm не в `PATH` | `npm config get prefix`, добавьте `<prefix>/bin` в `PATH` или используйте `nvm` |
| `EACCES` при `npm install -g` | глобальный prefix принадлежит root | используйте `nvm` либо настройте пользовательский prefix npm |
| `Unable to locate a Java Runtime` | OpenJDK не подключён | выполните `export PATH=...` и симлинк из раздела [Java](#java) |
| `The operation couldn’t be completed. Unable to locate a Java Runtime` при вызове `java` | `/usr/bin/java` — заглушка без установленной JDK | установите `openjdk@21` и создайте симлинк |
| `dotnet: command not found` | Cask не добавил путь в текущую сессию | откройте новый терминал или `export PATH="/usr/local/share/dotnet:$PATH"` |
| `framework 'Microsoft.NETCore.App', version '9.0.0' was not found` | установлен только .NET 10, а проект целится в `net9.0` | `brew install --cask dotnet-sdk@9` |
| `swipl: command not found` | Prolog не установлен | `brew install swi-prolog` |
| `asm/build.sh`: «неподдерживаемая платформа Darwin/x86_64» | Intel Mac, для него в репозитории нет варианта | используйте Apple Silicon, Linux или WSL |
| `bad CPU type in executable` | бинарник собран под другую архитектуру | пересоберите нативно на текущей машине |
| Кириллица выводится как `????` | терминал не в UTF-8 | проверьте настройки кодировки терминала; для macOS обычно достаточно UTF-8 |

## 8. Полный цикл с нуля

```bash
# 1. Инструменты
xcode-select --install
brew install python node go rust bash swi-prolog openjdk@21
brew install --cask dotnet-sdk@9
npm install -g typescript

# 2. Java
export PATH="$(brew --prefix openjdk@21)/bin:$PATH"
sudo ln -sfn "$(brew --prefix openjdk@21)/libexec/openjdk.jdk" \
  /Library/Java/JavaVirtualMachines/openjdk-21.jdk

# 3. Проверка версий
clang --version && python3 --version && node --version && tsc --version
javac --version && dotnet --version && go version && rustc --version
bash --version | head -n 1 && swipl --version

# 4. Сборка и запуск всех реализаций
bash scripts/run_all.sh

# 5. Проверка ожидаемого вывода
bash scripts/check_output.sh
```
