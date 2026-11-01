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
| clang (для проверки ARM64-варианта) | 19.1.7 |
| Git | 2.47.3 |

## 2. Сводная таблица по 13 языкам

| Язык | Файл | Команда сборки/запуска | Тип результата | «Визитная карточка» |
| --- | --- | --- | --- | --- |
| C | `c/main.c` | `gcc -Wall -Wextra -pedantic main.c -o main && ./main` | native executable (ELF) | да — `printf` со спецификаторами, `%02d` для номера |
| C++ | `cpp/main.cpp` | `g++ -Wall -Wextra -pedantic main.cpp -o main && ./main` | native executable | да — `std::cout`, `setw`/`setfill` |
| Python | `python/main.py` | `python3 main.py` | скрипт, интерпретация | да — f-строки + подсчёт слов в имени |
| JavaScript | `javascript/main.js` | `node main.js` | скрипт, JIT | да — template literals + длина имени |
| TypeScript | `typescript/main.ts` | `tsc main.ts --outDir dist && node dist/main.js` | транспиляция в JS, затем запуск | да — `interface`, типизированный объект |
| Java | `java/Main.java` | `javac Main.java && java Main` | байт-код `.class` + JVM | да — `record`, `System.out.printf`, `javap -c` |
| C# | `csharp/Program.cs` | `dotnet run` | IL + JIT | да — интерполяция `$"..."`, `record` |
| F# | `fsharp/Program.fs` | `dotnet run` | IL + JIT | да — конвейер `\|>`: слова → длины → сумма |
| Go | `go/main.go` | `go run main.go` | native executable | да — `fmt.Printf`, `studentID :=` |
| Rust | `rust/main.rs` | `rustc main.rs -o main && ./main` | native executable | да — `let`, `format!`, отдельная строка с `student_id` |
| Bash | `bash/main.sh` | `bash main.sh` | интерпретация | да — реальный pipe `\| wc` и `$(...)` |
| Prolog | `prolog/main.pl` | `swipl -q -s main.pl -g main -t halt` | интерпретация запроса | да — факт `student/4`, правила `group_of/2`, `control_value/2` |
| Assembler | `asm/assembler_x86_64_linux.s` (Linux) и `asm/assembler_arm64_macos.s` (macOS arm64) | `bash asm/build.sh && ./asm/build/assembler` | native executable | да — x86-64 GAS / AArch64 Apple Clang; те же три строки, что и у остальных |

**Assembler:** вариант выбирается по архитектуре компьютера.
* x86-64: Debian GNU/Linux 13 (WSL 2), GNU as 2.44, Intel-синтаксис, ELF, System V AMD64 ABI.
* arm64: macOS Apple Silicon, Apple Clang, Mach-O, AAPCS64; символы `_main`/`_puts`,
  аргумент `puts` передаётся в `x0`, адрес строки — через `adrp` + `add …@PAGEOFF`.

Assembler выводит те же три строки, что и остальные реализации: кириллица в `.asciz`
сохранена в UTF-8 и печатается как есть, поэтому вывод совпадает байт в байт.
ARM64-вариант проверен двумя способами: кросс-компиляцией в объектный файл Mach-O arm64
(`clang -target arm64-apple-macos11 -c`) и запуском того же кода под Linux AArch64 в
QEMU (`qemu-aarch64-static`) — вывод совпадает с x86-64-вариантом.

## 3. Подтверждение корректного вывода

Все реализации выводят английскую и русскую строки, а также строку
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
Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!
Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!
Student ID: М3О-119БВ-26/15 | Language: Assembler | Control: 4560
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

### 6.0. Репозиторий, origin и рабочая копия

* `origin` — локальный bare-репозиторий
  `C:\Users\Dapoleta\Projects\Git\VvPD-Lab1-origin.git`, созданный командой
  `git init --bare` (п. 4.3). В нём лежат все ветки (`main`, `feature/rust`) и тег
  `v1.0.0`; проверка клонированием выполняется ниже.
* публичное зеркало — GitHub <https://github.com/Dapolet/VvPD-Lab1.git>, remote
  `github`. История дополнительно отправляется туда (`git push github main --tags`),
  чтобы проект был доступен по ссылке и работал badge CI.
* рабочая копия (`dev`) — существующий проект
  `C:\Users\Dapoleta\Projects\Git\VvPD-Lab1`, ветка `main`; remote `origin` переключён
  на локальный bare, вся история отправлена в него (`git push -u origin main`,
  `git push origin feature/rust`, `git push origin v1.0.0`).
* вторая рабочая копия (`second_dev`) — `C:\Users\Dapoleta\Projects\Git\VvPD-Lab1-second_dev`,
  отдельный `git clone --no-hardlinks` того же локального origin; имитирует второго
  разработчика (п. 4.7).
* первые изменения добавлялись в индекс конкретными путями (`git add README.md`,
  `git add c/ cpp/`), `git add .` не использовался;
* все коммиты имеют осмысленные сообщения (`Initialize`-подобных «1», «fix», «готово» нет),
  всего коммитов в `main` — больше 20 (минимальное требование задания — 6).

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
  remotes/github/HEAD -> github/main
  remotes/github/feature/rust
  remotes/github/main
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

Второй разработчик (отдельный клон локального origin) изменил ту же строку `Status`,
что и основная ветка. После `git pull --no-rebase` Git остановил слияние:

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
закрыт для всех участников (вывод на момент разрешения конфликта):

```text
$ git -C second_dev pull origin main
Updating 72e8093..ee3a3da
Fast-forward
 README.md | 2 +-

$ grep Status second_dev/README.md
**Status:** checked by second developer, ready for v1.0.0
```

Позже эта строка ещё раз менялась вручную через веб-интерфейс GitHub: коммит
`fab0a45` поставил `Working i guess?`, а коммит `303319d` — актуальное значение
`checked, ready for v1.0.0`; на момент разрешения конфликта итоговый текст был именно
таким, как показано выше.

### 6.4. История, теги, состояние

Финальный вывод `git log --oneline --graph --all --decorate` (без коммита с самой этой
правкой отчёта, который добавляется сверху):

```text
* 303319d Update README.md
* d217e45 Fix assembler rows in README and final git output in report
* fe07426 Clarify tool versions and checkmark language cards in report
* e70c07e Fix Prolog language value and refresh Git evidence in report
* 2769bb5 Document feature branch merge evidence in report
* 368009f Add macOS arm64 assembler variant and run CI only on manual dispatch
* fab0a45 Update README.md
* 085a041 Add GitHub Actions workflow that verifies all implementations
* 41227ba (tag: v1.0.0) Complete documentation and release files
*   ee3a3da Merge second developer README changes and resolve status conflict
|\
| * 72e8093 Update README status after review
* | 1b4c697 Set project status to ready for v1.0.0
|/
*   7bc3cd1 Merge feature/rust into main
|\
| * 06c7b9c (origin/feature/rust, github/feature/rust, feature/rust) Add Rust implementation
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
второго разработчика (`72e8093`, `1b4c697`). Тег `v1.0.0` стоит на релизном коммите
`41227ba` (`Complete documentation and release files`), после него добавлены только
служебные коммиты (CI, ARM64-вариант assembler, уточнения отчёта), не меняющие состав
версии 1.0.0. Тег аннотированный:

```text
$ git tag -n1
v1.0.0          VPD Lab 01 release

$ git cat-file -t v1.0.0
tag
```

### 6.5. Финальные `git status` и теги

```text
$ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

$ git tag
v1.0.0

$ git remote -v
github  https://github.com/Dapolet/VvPD-Lab1.git (fetch)
github  https://github.com/Dapolet/VvPD-Lab1.git (push)
origin  C:\Users\Dapoleta\Projects\Git\VvPD-Lab1-origin.git (fetch)
origin  C:\Users\Dapoleta\Projects\Git\VvPD-Lab1-origin.git (push)
```

`origin` — локальный bare-репозиторий из п. 4.3 (основной), `github` — публичное
зеркало. Вторая рабочая копия `VvPD-Lab1-second_dev` клонирована именно из `origin`:

```text
$ git -C ..\VvPD-Lab1-second_dev remote -v
origin  C:\Users\Dapoleta\Projects\Git\VvPD-Lab1-origin.git (fetch)
origin  C:\Users\Dapoleta\Projects\Git\VvPD-Lab1-origin.git (push)
```

