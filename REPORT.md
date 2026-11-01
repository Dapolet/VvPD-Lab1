# Отчёт по лабораторной работе № 1

**Дисциплина:** Введение в профессиональную деятельность  
**Тема:** Языки программирования, терминал и Git  
**Студент:** Полетаев Дмитрий  
**Группа:** М3О-119БВ-26  
**Номер в списке:** 15  
**ОС и окружение:** Windows 11 + Debian GNU/Linux 13 (trixie), WSL 2, ядро 6.18.33.2;
архитектура `x86_64`. Все команды сборки и запуска выполнялись в терминале WSL.

## 1. Установленные инструменты

| Инструмент | Версия |
| --- | --- |
| gcc | 14.2.0 (Debian 14.2.0-19) |
| g++ | 14.2.0 (Debian 14.2.0-19) |
| GNU as (binutils) | 2.44 |
| Python | 3.13.5 |
| Node.js | 20.19.2 |
| npm | 9.2.0 |
| TypeScript (tsc) | 7.0.2 |
| OpenJDK (javac/java) | 21.0.13 |
| .NET SDK | 9.0.320 |
| Go | 1.24.4 linux/amd64 |
| Rust (rustc) | 1.85.1 |
| GNU bash | 5.2.37 |
| SWI-Prolog | 9.2.9 for x86_64-linux |
| Git | 2.47.3 |

## 2. Сводная таблица по 13 языкам

| Язык | Файл | Команда сборки/запуска | Тип результата | «Визитная карточка» |
| --- | --- | --- | --- | --- |
| C | `c/main.c` | `gcc -Wall -Wextra -pedantic main.c -o main && ./main` | native executable (ELF) | `printf` со спецификаторами, `%02d` для номера |
| C++ | `cpp/main.cpp` | `g++ -Wall -Wextra -pedantic main.cpp -o main && ./main` | native executable | `std::cout`, `setw`/`setfill` |
| Python | `python/main.py` | `python3 main.py` | скрипт, интерпретация | f-строки + подсчёт слов в имени |
| JavaScript | `javascript/main.js` | `node main.js` | скрипт, JIT | template literals + длина имени |
| TypeScript | `typescript/main.ts` | `tsc main.ts --outDir dist && node dist/main.js` | транспиляция в JS, затем запуск | `interface`, типизированный объект |
| Java | `java/Main.java` | `javac Main.java && java Main` | байт-код `.class` + JVM | `record`, `System.out.printf`, `javap -c` |
| C# | `csharp/Program.cs` | `dotnet run` | IL + JIT | интерполяция `$"..."`, `record` |
| F# | `fsharp/Program.fs` | `dotnet run` | IL + JIT | конвейер `\|>`: слова → длины → сумма |
| Go | `go/main.go` | `go run main.go` | native executable | `fmt.Printf`, `studentID :=` |
| Rust | `rust/main.rs` | `rustc main.rs -o main && ./main` | native executable | `let`, `format!`, отдельная строка с `student_id` |
| Bash | `bash/main.sh` | `bash main.sh` | интерпретация | реальный pipe `\| wc` и `$(...)` |
| Prolog | `prolog/main.pl` | `swipl -q -s main.pl -g main -t halt` | интерпретация запроса | факт `student/4`, правила `group_of/2`, `control_value/2` |
| Assembler | `asm/assembler_x86_64_linux.s` (Linux) и `asm/assembler_arm64_macos.s` (macOS arm64) | `bash asm/build.sh && ./asm/build/assembler` | native executable | x86-64 GAS / AArch64 Apple Clang; вывод — одна английская строка |

**Assembler:** вариант выбирается по архитектуре компьютера.
* x86-64: Debian GNU/Linux 13 (WSL 2), GNU as 2.44, Intel-синтаксис, ELF, System V AMD64 ABI.
* arm64: macOS Apple Silicon, Apple Clang, Mach-O, AAPCS64; символы `_main`/`_puts`,
  аргумент `puts` передаётся в `x0`, адрес строки — через `adrp` + `add …@PAGEOFF`.

В соответствии с заданием assembler выводит только персонализированную английскую строку.
ARM64-вариант проверен двумя способами: кросс-компиляцией в объектный файл Mach-O arm64
(`clang -target arm64-apple-macos11 -c`) и запуском того же кода под Linux AArch64 в
QEMU (`qemu-aarch64-static`) — вывод совпадает с x86-64-вариантом.

## 3. Подтверждение корректного вывода

Все реализации, кроме assembler, выводят английскую и русскую строки, а также строку
`Student ID ... | Language ... | Control ...`. Ниже — фактический вывод (сборка и запуск
через `bash scripts/run_all.sh`).

```text
=== C ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: C | Control: 4560

=== C++ ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: C++ | Control: 4560

=== Python ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: Python | Control: 4560
Words in student_name_en: 2

=== JavaScript ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: JavaScript | Control: 4560
Length of student_name_en: 16

=== TypeScript ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: TypeScript | Control: 4560

=== Java ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: Java | Control: 4560

=== C# ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: C# | Control: 4560

=== F# ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: F# | Control: 4560
Words in student_name_en: 2, total letters: 15

=== Go ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: Go | Control: 4560

=== Rust ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: Rust | Control: 4560
Formatted student_id: М3О-119БВ-26/15

=== Bash ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: Bash | Control: 4560
Words: 2, characters: 16

=== Prolog ===
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: Prolog | Control: 4560
Members of М3О-119БВ-26: Полетаев Дмитрий; Poletaev Dmitriy;

=== Assembler ===
Hello to 304 from Poletaev Dmitriy, number 15, group M3O-119BV-26!
```

### Java: байт-код и `javap -c`

После `javac Main.java` в каталоге `java/` появились файлы `Main.class` и
`Main$Student.class` (байт-код, а не машинный код). Проверка `javap -c Main`:

```text
Compiled from "Main.java"
public class Main {
  public static void main(java.lang.String[]);
    Code:
       0: new           #7                  // class Main$Student
       3: dup
       4: ldc           #9                  // String Полетаев Дмитрий
       6: ldc           #11                 // String Poletaev Dmitriy
       8: bipush        15
      10: ldc           #13                 // String М3О-119БВ-26
      12: invokespecial #15                 // Method Main$Student."<init>":(...)V
      19: sipush        304
      22: aload_1
      23: invokevirtual #20                 // Method Main$Student.number:()I
      26: imul
      27: istore_3
```

`javap` показывает байт-код JVM: константы, вызов конструктора `record` и умножение
`304 * number` инструкцией `imul` — то есть исходный код Java компилируется в
платформенно-независимый байт-код, который затем исполняет JVM.

## 4. Кириллица в C/C++

Исходные файлы сохранены в UTF-8. В Windows консоль по умолчанию использует CP866,
поэтому русские строки выводятся как мусор. В `c/main.c` и `cpp/main.cpp` под
`#ifdef _WIN32` вызываются:

```c
SetConsoleCP(CP_UTF8);
SetConsoleOutputCP(CP_UTF8);
```

Альтернатива для текущей сессии — `chcp 65001`. В Linux/WSL терминал уже работает в
UTF-8, поэтому дополнительных действий не требуется: на приведённом выше выводе обе
строки корректны.

## 5. Фрагменты README.md и CHANGELOG.md

`README.md` содержит заголовок, данные студента, цель, список языков, таблицу
«язык — версия — команда», inline-code, fenced code block, ожидаемый вывод, описание
решения проблемы кириллицы и описание assembler-варианта. Пример таблицы:

| Язык | Версия инструмента | Команда сборки/запуска | Тип результата |
| --- | --- | --- | --- |
| C | gcc 14.2.0 | `gcc -Wall -Wextra -pedantic main.c -o main && ./main` | native executable |
| Java | OpenJDK 21.0.13 | `javac Main.java && java Main` | bytecode `.class` |

`CHANGELOG.md` описывает версию 1.0.0:

```markdown
## [1.0.0] - 2026-11-01

### Добавлено

- Персонализированные реализации на 13 языках: C, C++, Python, JavaScript,
  TypeScript, Java, C#, F#, Go, Rust, Bash, Prolog, Assembler.
```

## 6. Работа с Git

### 6.1. Ветка feature/rust и слияние

Номер в списке 15, `15 mod 5 = 0`, поэтому отдельная feature-ветка — Rust:

```bash
git switch -c feature/rust
git add rust/
git commit -m "Add Rust implementation"
git switch main
git merge --no-ff -m "Merge feature/rust into main" feature/rust
git push -u origin feature/rust
```

Реализация появилась в `main`, коммит ветки виден в истории, сама ветка отправлена
в origin:

```text
$ git branch -a
  feature/rust
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/feature/rust
  remotes/origin/main

$ git log --oneline --graph --all --decorate
*   7bc3cd1 (HEAD -> main) Merge feature/rust into main
|\
| * 06c7b9c (feature/rust) Add Rust implementation
|/
* 016eb62 Add script that builds and runs every implementation

$ git ls-tree --name-only main -- rust/
rust/main.rs
```

Проверка вливания: `git merge-base --is-ancestor feature/rust main` завершается с
кодом 0, то есть feature-ветка полностью содержится в `main`, а `rust/main.rs`
присутствует в дереве основной ветки.

### 6.2. Merge conflict до разрешения

Второй разработчик (отдельный клон репозитория) изменил ту же строку `Status`, что и
основная ветка. После `git pull --no-rebase` Git остановил слияние:

```text
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

Файл содержал маркеры конфликта:

```text
<<<<<<< HEAD
**Status:** ready for v1.0.0
=======
**Status:** checked by second developer
>>>>>>> 72e80936a0c8cb181c94e8287a450213ed4bc251
```

### 6.3. Разрешение конфликта

Обе правки объединены в осмысленную строку, маркеры удалены:

```text
**Status:** checked by second developer, ready for v1.0.0
```

Затем `git add README.md`, merge-коммит и отправка в origin:

```bash
git add README.md
git commit -m "Merge second developer README changes and resolve status conflict"
git push origin main
```

Второй клон после `git pull` получил уже разрешённый вариант строки — конфликт
закрыт для всех участников.

### 6.4. История, теги, состояние

```text
*   ee3a3da (origin/main, origin/HEAD) Merge second developer README changes and resolve status conflict
|\
| * 72e8093 Update README status after review
* | 1b4c697 Set project status to ready for v1.0.0
|/
*   7bc3cd1 Merge feature/rust into main
|\
| * 06c7b9c (feature/rust) Add Rust implementation
|/
* 016eb62 Add script that builds and runs every implementation
* db93877 Add Bash, Prolog and assembler implementations
* 83f684a Add Go implementation
* 3a470de Add C# and F# implementations
* fe62daf Add TypeScript and Java implementations
* 3b37b81 Add Python and JavaScript implementations
* 5e738e6 Add C and C++ implementations
* 1940052 Document project structure, tools and build rules
* ce12bc6 Create README.md
```

Граф содержит обе точки слияния: `feature/rust` (коммит `06c7b9c`) и merge-конфликт
второго разработчика (`72e8093`, `1b4c697`). Поверх этого графа добавлен релизный
коммит `Complete documentation and release files` (README.md, CHANGELOG.md,
REPORT.md) и на него поставлен аннотированный тег `v1.0.0`, поэтому полный вывод
`git log --oneline --graph --all --decorate` дополнительно содержит строку
`(HEAD -> main, tag: v1.0.0)`.

### 6.5. Финальные `git status` и теги

```text
$ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

$ git tag
v1.0.0

$ git remote -v
origin  https://github.com/Dapolet/VvPD-Lab1.git (fetch)
origin  https://github.com/Dapolet/VvPD-Lab1.git (push)
```

