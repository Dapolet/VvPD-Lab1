# VvPD Lab 01 — языки программирования, терминал и Git

**Студент:** Полетаев Дмитрий
**Группа:** М3О-119БВ-26
**Номер в списке:** 15
**ОС и окружение:** Windows 11 + Debian GNU/Linux 13 (WSL 2), сборка и запуск выполняются в WSL.
**Status:** checked by second developer

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
13. Assembler (x86-64)

## Инструменты и команды

| Язык | Версия инструмента | Команда сборки/запуска | Тип результата |
| --- | --- | --- | --- |
| C | gcc 14.2.0 | `gcc -Wall -Wextra -pedantic main.c -o main && ./main` | native executable |
| C++ | g++ 14.2.0 | `g++ -Wall -Wextra -pedantic main.cpp -o main && ./main` | native executable |
| Python | Python 3.13 | `python3 main.py` | скрипт (интерпретация) |
| JavaScript | Node.js 20 | `node main.js` | скрипт (JIT) |
| TypeScript | tsc 5.x | `tsc main.ts --outDir dist && node dist/main.js` | транспиляция в JS |
| Java | OpenJDK 21 | `javac Main.java && java Main` | bytecode `.class` |
| C# | .NET SDK 9.0 | `dotnet run` | IL + JIT |
| F# | .NET SDK 9.0 | `dotnet run` | IL + JIT |
| Go | go 1.24 | `go run main.go` | native executable |
| Rust | rustc 1.85 | `rustc main.rs -o main && ./main` | native executable |
| Bash | GNU bash 5.2 | `bash main.sh` | интерпретация |
| Prolog | SWI-Prolog 9.x | `swipl -q -s main.pl -g main -t halt` | интерпретация запроса |
| Assembler | GNU as 2.44 | `as assembler.s -o assembler.o && gcc assembler.o -o assembler` | native executable |

Имя файла каждой реализации — `main.<ext>` в каталоге языка (например, `c/main.c`);
исключения: `java/Main.java`, `csharp/Program.cs` + `csharp/LabCSharp.csproj`,
`fsharp/Program.fs` + `fsharp/LabFSharp.fsproj`, `asm/assembler.s`.

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

* ОС: Debian GNU/Linux 13 (WSL 2), архитектура `x86_64`;
* ассемблер: GNU Assembler (GAS) 2.44, Intel-синтаксис, System V AMD64 ABI;
* сборка и запуск:

```bash
cd asm
as assembler.s -o assembler.o
gcc assembler.o -o assembler
./assembler
```

## Структура проекта

```text
c/ cpp/ python/ javascript/ typescript/ java/ csharp/ fsharp/
go/ rust/ bash/ prolog/ asm/
README.md  CHANGELOG.md  .gitignore
```
