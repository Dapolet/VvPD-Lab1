# macOS Apple Silicon (arm64 / AArch64), нативный Apple Clang.
# Сборка: clang -c assembler_arm64_macos.s -o assembler_arm64.o
#         clang assembler_arm64.o -o assembler
#
# Отличия от x86-64-варианта: другой набор инструкций (AArch64), Mach-O вместо ELF,
# имена символов с подчёркиванием (_main, _puts) и первый аргумент puts в регистре x0.

    .section __TEXT,__cstring,cstring_literals
message:
    .asciz "Hello to 304 from Poletaev Dmitriy, number 15, group M3O-119BV-26!"

    .section __TEXT,__text,regular,pure_instructions
    .globl _main
    .p2align 2

_main:
    stp x29, x30, [sp, #-16]!      // сохранить frame pointer и адрес возврата
    mov x29, sp

    adrp x0, message@PAGE          // адрес строки: старшие биты страницы
    add x0, x0, message@PAGEOFF    // плюс смещение внутри страницы
    bl _puts                       // puts(message)

    mov w0, #0                     // код возврата 0
    ldp x29, x30, [sp], #16        // восстановить регистры
    ret
