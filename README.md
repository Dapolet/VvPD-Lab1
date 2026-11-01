# VvPD Lab 01 — языки программирования, терминал и Git

[![Build and check all implementations](https://github.com/Dapolet/VvPD-Lab1/actions/workflows/ci.yml/badge.svg)](https://github.com/Dapolet/VvPD-Lab1/actions/workflows/ci.yml)

**Студент:** Полетаев Дмитрий  
**Группа:** М3О-119БВ-26  
**Номер в списке:** 15  
**ОС и окружение:** Windows 11 + Debian GNU/Linux 13 (WSL 2), сборка и запуск выполняются в WSL; Git 2.47.3, GNU bash 5.2.37.  
**Status:** Working i guess?

## Цель проекта

Сравнить модели выполнения разных языков программирования: собрать одну и ту же
персонализированную программу на 13 языках, увидеть различия между исходным кодом,
байт-кодом и машинным кодом, а также провести проект через полный жизненный цикл Git
(ветки, слияния, конфликт, теги).

## Используемые языки

1. C
2. C++
3. Python
4. JavaScript
5. TypeScript
6. Java
7. C#
8. F#
9. Go
10. Rust
11. Bash
12. Prolog
13. Assembler (x86-64 или ARM64 — по архитектуре компьютера)

## Инструменты и команды

| Язык | Версия инструмента | Команда сборки/запуска | Тип результата |
| --- | --- | --- | --- |
| C | gcc 14.2.0 | `gcc -Wall -Wextra -pedantic main.c -o main && ./main` | native executable |
| C++ | g++ 14.2.0 | `g++ -Wall -Wextra -pedantic main.cpp -o main && ./main` | native executable |
| Python | Python 3.13.5 | `python3 main.py` | скрипт (интерпретация) |
| JavaScript | Node.js 20.19.2 | `node main.js` | скрипт (JIT) |
| TypeScript | tsc 7.0.2 | `tsc main.ts --outDir dist && node dist/main.js` | транспиляция в JS |
| Java | OpenJDK 21.0.13 | `javac Main.java && java Main` | bytecode `.class` |
| C# | .NET SDK 9.0.320 | `dotnet run` | IL + JIT |
| F# | .NET SDK 9.0.320 | `dotnet run` | IL + JIT |
| Go | go 1.24.4 | `go run main.go` | native executable |
| Rust | rustc 1.85.1 | `rustc main.rs -o main && ./main` | native executable |
| Bash | GNU bash 5.2.37 | `bash main.sh` | интерпретация |
| Prolog | SWI-Prolog 9.2.9 | `swipl -q -s main.pl -g main -t halt` | интерпретация запроса |
| Assembler (x86-64) | GNU as 2.44 | `as assembler_x86_64_linux.s -o assembler.o && gcc assembler.o -o assembler && ./assembler` | native executable (ELF) |
| Assembler (ARM64) | Apple Clang | `clang -c assembler_arm64_macos.s -o assembler.o && clang assembler.o -o assembler && ./assembler` | native executable (Mach-O) |

Имя файла каждой реализации — `main.<ext>` в каталоге языка (например, `c/main.c`);
исключения: `java/Main.java`, `csharp/Program.cs` + `csharp/LabCSharp.csproj`,
`fsharp/Program.fs` + `fsharp/LabFSharp.fsproj`, `asm/assembler_x86_64_linux.s`,
`asm/assembler_arm64_macos.s`.

Собрать и запустить всё сразу: `bash scripts/run_all.sh`.

## Ожидаемый вывод

Реализации на всех языках, кроме assembler, печатают одинаковые по смыслу три строки:

```text
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: C | Control: 4560
```

Значение `304` — константа задания, `Control = 304 × 15 = 4560`.
Assembler печатает только персонализированную английскую строку.

Запуск отдельной реализации, например C:

```bash
cd c
gcc -Wall -Wextra -pedantic main.c -o main
./main
```

## Кириллица в C/C++

Исходные файлы сохранены в UTF-8. В Windows консоль по умолчанию работает в CP866,
поэтому в `c/main.c` и `cpp/main.cpp` под `#ifdef _WIN32` вызываются
`SetConsoleCP(CP_UTF8)` и `SetConsoleOutputCP(CP_UTF8)`; альтернатива для сессии —
`chcp 65001`. В Linux/WSL терминал уже работает в UTF-8, поэтому дополнительных
действий не требуется.

## Assembler

В проекте две реализации под разные архитектуры; нужная выбирается автоматически
скриптом `asm/build.sh` (по `uname -s` и `uname -m`).

| Файл | Платформа | Ассемблер | Формат | ABI |
| --- | --- | --- | --- | --- |
| `asm/assembler_x86_64_linux.s` | Linux/WSL x86-64 | GNU as 2.44 | ELF | System V AMD64 (аргумент `puts` в `rdi`) |
| `asm/assembler_arm64_macos.s` | macOS Apple Silicon (arm64) | Apple Clang | Mach-O | AAPCS64 (аргумент `puts` в `x0`, символы `_main`/`_puts`) |

Сборка и запуск на Linux x86-64:

```bash
cd asm
as assembler_x86_64_linux.s -o assembler_x86_64.o
gcc assembler_x86_64.o -o assembler
./assembler
```

Сборка и запуск на macOS (Apple Silicon):

```bash
cd asm
clang -c assembler_arm64_macos.s -o assembler_arm64.o
clang assembler_arm64.o -o assembler
./assembler
```

Универсальный вариант (сам определяет платформу, результат в `asm/build/`):

```bash
bash asm/build.sh
./asm/build/assembler
```

## Структура проекта

```text
c/ cpp/ python/ javascript/ typescript/ java/ csharp/ fsharp/
go/ rust/ bash/ prolog/
asm/                assembler_x86_64_linux.s, assembler_arm64_macos.s, build.sh
scripts/            run_all.sh, check_output.sh
.github/workflows/  ci.yml
README.md  CHANGELOG.md  REPORT.md  .gitignore
```

## Непрерывная проверка (GitHub Actions)

Файл `.github/workflows/ci.yml` запускается **только вручную**: вкладка Actions →
workflow «Build and check all implementations» → `Run workflow` (или
`gh workflow run ci.yml`). Автоматических запусков по push и pull request нет.

Workflow ставит все инструменты на `ubuntu-latest` (GCC, binutils, Node.js + tsc, JDK 21,
.NET SDK 9, Go, Rust, SWI-Prolog, clang), выполняет `scripts/check_output.sh`, а также
отдельно проверяет ARM64-вариант assembler кросс-компиляцией в объектный файл Mach-O
arm64 (`clang -target arm64-apple-macos11 -c`).

Скрипт `scripts/check_output.sh` сам собирает и запускает все 13 реализаций через
`scripts/run_all.sh`, а затем сверяет построчно ожидаемый вывод: английское и русское
приветствие, строку `Student ID … | Language … | Control …`, а также наличие
«визитной карточки» у Python, JavaScript, F#, Rust, Bash и Prolog. Для assembler
проверяется только английская строка. Любое расхождение завершает job с ошибкой.

Ту же проверку можно выполнить локально:

```bash
bash scripts/check_output.sh
```

