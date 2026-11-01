struct Student {
    name_ru: &'static str,
    name_en: &'static str,
    number: u32,
    group: &'static str,
}

fn main() {
    let course_number: u32 = 304;

    let student = Student {
        name_ru: "Полетаев Дмитрий",
        name_en: "Poletaev Dmitriy",
        number: 15,
        group: "М3О-119БВ-26",
    };
    let language_name = "Rust";

    let control_value: u32 = 304 * student.number;
    let student_id = format!("{}/{:02}", student.group, student.number);

    println!(
        "Hello to {} from {}, number {}, group {}!",
        course_number, student.name_en, student.number, student.group
    );
    println!(
        "Привет, {}! Это {}, номер {}, группа {}!",
        course_number, student.name_ru, student.number, student.group
    );
    println!(
        "Student ID: {} | Language: {} | Control: {}",
        student_id, language_name, control_value
    );

    // «Визитная карточка»: отдельная строка с сформированным student_id.
    println!("Formatted student_id: {student_id}");
}
