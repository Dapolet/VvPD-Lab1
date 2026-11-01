# Linux x86-64 (System V AMD64 ABI), GNU Assembler (GAS), Intel-синтаксис.
# Сборка: as assembler_x86_64_linux.s -o assembler.o && gcc assembler.o -o assembler

    .intel_syntax noprefix

    .section .rodata
message:
    .asciz "Hello to 304 from Poletaev Dmitriy, number 15, group M3O-119BV-26!"

    .text
    .globl main
    .extern puts

main:
    push rbp
    mov rbp, rsp

    lea rdi, [rip + message]
    call puts

    xor eax, eax
    pop rbp
    ret
