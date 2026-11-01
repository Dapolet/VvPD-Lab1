# Changelog

Формат основан на принципах Keep a Changelog; версии проекта ведутся вручную.

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
