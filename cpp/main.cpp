#include <iomanip>
#include <iostream>
#include <string>

#ifdef _WIN32
#include <windows.h>
#endif

int main() {
#ifdef _WIN32
    SetConsoleCP(CP_UTF8);
    SetConsoleOutputCP(CP_UTF8);
#endif

    const std::string student_name_ru = "Полетаев Дмитрий";
    const std::string student_name_en = "Poletaev Dmitriy";
    const int student_number = 15;
    const std::string group_name = "М3О-119БВ-26";
    const std::string language_name = "C++";

    const unsigned control_value = 304u * static_cast<unsigned>(student_number);

    std::cout << "Hello to " << 304 << " from " << student_name_en
              << ", number " << student_number
              << ", group " << group_name << "!" << std::endl;

    std::cout << "Привет, " << 304 << "! Это " << student_name_ru
              << ", номер " << student_number
              << ", группа " << group_name << "!" << std::endl;

    std::cout << "Student ID: " << group_name << "/"
              << std::setw(2) << std::setfill('0') << student_number
              << " | Language: " << language_name
              << " | Control: " << control_value << std::endl;

    return 0;
}
