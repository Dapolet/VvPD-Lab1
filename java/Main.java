public class Main {

    record Student(String nameRu, String nameEn, int number, String group) {
    }

    public static void main(String[] args) {
        final int courseNumber = 304;
        Student student = new Student("Полетаев Дмитрий", "Poletaev Dmitriy", 15, "М3О-119БВ-26");
        String languageName = "Java";

        int controlValue = 304 * student.number();
        String studentId = String.format("%s/%02d", student.group(), student.number());

        System.out.printf("Hello to %d from %s, number %d, group %s!%n",
                courseNumber, student.nameEn(), student.number(), student.group());
        System.out.printf("Привет, %d! Это %s, номер %d, группа %s!%n",
                courseNumber, student.nameRu(), student.number(), student.group());
        System.out.printf("Student ID: %s | Language: %s | Control: %d%n",
                studentId, languageName, controlValue);
    }
}
