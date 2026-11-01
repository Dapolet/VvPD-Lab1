# Linux x86-64 (System V AMD64 ABI), GNU Assembler (GAS), Intel-синтаксис.
# Сборка: as assembler_x86_64_linux.s -o assembler.o && gcc assembler.o -o assembler
#
# Вывод совпадает с остальными реализациями: три строки, вторая — по-русски.
# Файл сохранён в UTF-8 без BOM: директива .asciz просто копирует байты строки
# в секцию .rodata, поэтому кириллица выводится как обычная последовательность
# байтов UTF-8 и никакой настройки локали не требует.

    .intel_syntax noprefix

    .section .rodata
line1:
    .asciz "Hello to 304 from Poletaev Dmitriy, number 15, group М3О-119БВ-26!"
line2:
    .asciz "Привет, 304! Это Полетаев Дмитрий, номер 15, группа М3О-119БВ-26!"
line3:
    .asciz "Student ID: М3О-119БВ-26/15 | Language: Assembler | Control: 4560"

    .text
    .globl main
    .extern puts

main:
    push rbp                   # выровнять стек: на входе rsp ≡ 8 (mod 16)
    mov rbp, rsp

    lea rdi, [rip + line1]     # первый аргумент puts — адрес строки
    call puts
    lea rdi, [rip + line2]
    call puts
    lea rdi, [rip + line3]
    call puts

    xor eax, eax               # код возврата 0
    pop rbp
    ret
