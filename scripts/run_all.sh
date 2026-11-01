#!/usr/bin/env bash
# Сборка и запуск всех реализаций. Предполагается Linux/WSL с установленными
# компиляторами и интерпретаторами (см. таблицу инструментов в README.md).
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

section() {
    echo
    echo "=== $1 ==="
}

section "C"
(cd c && gcc -Wall -Wextra -pedantic main.c -o main && ./main)

section "C++"
(cd cpp && g++ -Wall -Wextra -pedantic main.cpp -o main && ./main)

section "Python"
(cd python && python3 main.py)

section "JavaScript"
(cd javascript && node main.js)

section "TypeScript"
(cd typescript && tsc main.ts --outDir dist && node dist/main.js)

section "Java"
(cd java && javac Main.java && java Main)

section "C#"
(cd csharp && dotnet run --nologo)

section "F#"
(cd fsharp && dotnet run --nologo)

section "Go"
(cd go && go run main.go)

section "Rust"
(cd rust && rustc main.rs -o main && ./main)

section "Bash"
(cd bash && bash main.sh)

section "Prolog"
(cd prolog && swipl -q -s main.pl -g main -t halt)

section "Assembler"
(cd asm && bash build.sh && ./build/assembler)
