# Changelog

Формат основан на принципах Keep a Changelog; версии проекта ведутся вручную.

## [Unreleased]

## [1.0.1] - 2026-11-01

Патч-релиз: вторая реализация assembler, автоматическая сверка вывода и
ручной CI-workflow.

### Добавлено

- Вторая реализация assembler — `asm/assembler_arm64_macos.s` для macOS Apple Silicon
  (AArch64, Apple Clang, Mach-O, AAPCS64); x86-64-вариант переименован в
  `asm/assembler_x86_64_linux.s`.
- Скрипт `asm/build.sh`: выбирает вариант по ОС и архитектуре (`uname -s`/`uname -m`),
  собирает результат в `asm/build/assembler`.
- GitHub Actions workflow `.github/workflows/ci.yml`: установка всех тулчейнов, сборка и
  запуск 13 реализаций, кросс-проверка ARM64-варианта assembler.
- Скрипт `scripts/check_output.sh`: сверка фактического вывода всех реализаций
  с ожидаемым (три строки, «визитные карточки», те же три строки у assembler).
- Бейдж состояния сборки в `README.md`.

### Изменено

- Workflow запускается только вручную (`workflow_dispatch`), без автоматических
  запусков по push и pull request.
- Assembler-реализации печатают те же три строки, что и остальные языки: английское
  и русское приветствие и строку `Student ID … | Language: Assembler | Control …`.

### Исправлено

- В `asm/assembler_x86_64_linux.s` и `asm/assembler_arm64_macos.s` группа была записана
  латиницей (`M3O-119BV-26`) и выводилась только одна строка; теперь используется
  `М3О-119БВ-26` и печатаются все три строки, как в остальных реализациях.
- `scripts/check_output.sh` проверяет у assembler три строки, а не только английскую.

## [1.0.0] - 2026-11-01

Первая законченная версия лабораторной работы № 1.

### Добавлено

- Персонализированные реализации на 13 языках: C, C++, Python, JavaScript,
  TypeScript, Java, C#, F#, Go, Rust, Bash, Prolog, Assembler.
- Единый формат вывода: приветствие на английском, приветствие на русском,
  строка `Student ID` / `Language` / `Control` (для assembler — только английская строка).
- «Визитные карточки» языков: `printf` в C, потоковый вывод в C++, f-строки в Python,
  template literals в JS/TS, `System.out.printf` и `record` в Java, интерполяция в C#,
  конвейер `|>` в F#, короткое объявление в Go, `let`/`format!` в Rust, реальный pipe в Bash,
  факт и правило в Prolog, x86-64 GAS в assembler.
- Документация: `README.md` (цель, инструменты, команды, ожидаемый вывод, кириллица,
  assembler-вариант) и `.gitignore` с пояснением каждого исключения.

### Исправлено

- Настроен вывод UTF-8 в C/C++ на Windows через `SetConsoleCP`/`SetConsoleOutputCP`.
- Разрешён конфликт слияния в `README.md` при имитации второго разработчика.
