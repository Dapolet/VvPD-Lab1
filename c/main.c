#include <stdio.h>

#ifdef _WIN32
#include <windows.h>
#endif

int main(void) {
#ifdef _WIN32
    /* Без этого консоль Windows выводит кириллицу из UTF-8 файла как мусор. */
    SetConsoleCP(CP_UTF8);
    SetConsoleOutputCP(CP_UTF8);
#endif

    const char *student_name_ru = "Полетаев Дмитрий";
    const char *student_name_en = "Poletaev Dmitriy";
    const int student_number = 15;
    const char *group_name = "М3О-119БВ-26";
    const char *language_name = "C";

    const unsigned control_value = 304u * (unsigned)student_number;

    printf("Hello to %d from %s, number %d, group %s!\n",
           304, student_name_en, student_number, group_name);
    printf("Привет, %d! Это %s, номер %d, группа %s!\n",
           304, student_name_ru, student_number, group_name);
    printf("Student ID: %s/%02d | Language: %s | Control: %u\n",
           group_name, student_number, language_name, control_value);

    return 0;
}
