# macOS Apple Silicon (arm64 / AArch64), нативный Apple Clang.
# Сборка: clang -c assembler_arm64_macos.s -o assembler_arm64.o
#         clang assembler_arm64.o -o assembler
#
# Отличия от x86-64-варианта: другой набор инструкций (AArch64), Mach-O вместо ELF,
# имена символов с подчёркиванием (_main, _puts) и первый аргумент puts в регистре x0.
#
# Вывод совпадает с x86-64-вариантом и с остальными реализациями: три строки.
# Файл сохранён в UTF-8 без BOM: .asciz копирует байты строки в секцию cstring,
# поэтому кириллица выводится как есть, без настройки локали.

    .section __TEXT,__cstring,cstring_literals
line1:
    .asciz "Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!"
line2:
    .asciz "Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!"
line3:
    .asciz "Student ID: М3О-119БВ-26/15 | Language: Assembler | Control: 4560"

    .section __TEXT,__text,regular,pure_instructions
    .globl _main
    .p2align 2

_main:
    stp x29, x30, [sp, #-16]!      // сохранить frame pointer и адрес возврата
    mov x29, sp

    adrp x0, line1@PAGE            // адрес строки: старшие биты страницы
    add x0, x0, line1@PAGEOFF      // плюс смещение внутри страницы
    bl _puts                       // puts(line1)
    adrp x0, line2@PAGE
    add x0, x0, line2@PAGEOFF
    bl _puts                       // puts(line2)
    adrp x0, line3@PAGE
    add x0, x0, line3@PAGEOFF
    bl _puts                       // puts(line3)

    mov w0, #0                     // код возврата 0
    ldp x29, x30, [sp], #16        // восстановить регистры
    ret
