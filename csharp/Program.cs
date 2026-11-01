using System;

namespace LabCSharp;

public record Student(string NameRu, string NameEn, int Number, string Group);

public static class Program
{
    public static void Main()
    {
        const int courseNumber = 304;

        Student student = new(
            NameRu: "Полетаев Дмитрий",
            NameEn: "Poletaev Dmitriy",
            Number: 15,
            Group: "М3О-119БВ-26");

        const string languageName = "C#";

        int controlValue = 304 * student.Number;
        string studentId = $"{student.Group}/{student.Number:D2}";

        Console.WriteLine($"Hello to {courseNumber} from {student.NameEn}, number {student.Number}, group {student.Group}!");
        Console.WriteLine($"Привет, {courseNumber}! Это {student.NameRu}, номер {student.Number}, группа {student.Group}!");
        Console.WriteLine($"Student ID: {studentId} | Language: {languageName} | Control: {controlValue}");
    }
}
