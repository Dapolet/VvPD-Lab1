student_name_ru = "Полетаев Дмитрий"
student_name_en = "Poletaev Dmitriy"
student_number = 15
group_name = "М3О-119БВ-26"
language_name = "Python"

control_value = 304 * student_number
student_id = f"{group_name}/{student_number:02d}"

print(f"Hello to {304} from {student_name_en}, number {student_number}, group {group_name}!")
print(f"Привет, {304}! Это {student_name_ru}, номер {student_number}, группа {group_name}!")
print(f"Student ID: {student_id} | Language: {language_name} | Control: {control_value}")

# «Визитная карточка»: количество слов в английском имени средствами языка.
print(f"Words in student_name_en: {len(student_name_en.split())}")
