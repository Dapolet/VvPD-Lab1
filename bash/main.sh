#!/usr/bin/env bash
set -euo pipefail

student_name_ru="Полетаев Дмитрий"
student_name_en="Poletaev Dmitriy"
student_number=15
group_name="М3О-119БВ-26"
language_name="Bash"

control_value=$((304 * student_number))
printf -v student_id "%s/%02d" "$group_name" "$student_number"

echo "Hello to 304 from ${student_name_en}, number ${student_number}, group ${group_name}!"
echo "Привет, 304! Это ${student_name_ru}, номер ${student_number}, группа ${group_name}!"
echo "Student ID: ${student_id} | Language: ${language_name} | Control: ${control_value}"

# «Визитная карточка»: настоящий pipe и command substitution.
words=$(printf '%s\n' "${student_name_en}" | wc -w)
chars=$(printf '%s' "${student_name_en}" | wc -c)
echo "Words: ${words}, characters: ${chars}"
