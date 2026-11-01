#!/usr/bin/env bash
# Собирает assembler-реализацию под текущую платформу и кладёт результат в asm/build/.
#   Linux x86_64  -> assembler_x86_64_linux.s через GNU as + gcc (ELF, System V AMD64 ABI)
#   macOS arm64   -> assembler_arm64_macos.s через Apple Clang (Mach-O, AArch64)
set -euo pipefail

cd "$(dirname "$0")"
mkdir -p build

os="$(uname -s)"
arch="$(uname -m)"

case "$os/$arch" in
    Linux/x86_64)
        as assembler_x86_64_linux.s -o build/assembler_x86_64.o
        gcc build/assembler_x86_64.o -o build/assembler
        echo "Собрано: asm/build/assembler (x86-64, GNU as, ELF)"
        ;;
    Darwin/arm64)
        clang -c assembler_arm64_macos.s -o build/assembler_arm64.o
        clang build/assembler_arm64.o -o build/assembler
        echo "Собрано: asm/build/assembler (arm64, Apple Clang, Mach-O)"
        ;;
    Darwin/x86_64)
        echo "ОШИБКА: для macOS на Intel вариант не предусмотрен." >&2
        echo "По заданию x86-64 собирается через GNU as (Linux/Windows), см. README.md." >&2
        exit 1
        ;;
    *)
        echo "ОШИБКА: неподдерживаемая платформа $os/$arch." >&2
        echo "Поддерживаются Linux x86_64 и macOS arm64; см. README.md." >&2
        exit 1
        ;;
esac
