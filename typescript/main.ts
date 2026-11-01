interface Student {
  nameRu: string;
  nameEn: string;
  number: number;
  group: string;
}

const courseNumber: number = 304;

const student: Student = {
  nameRu: "Полетаев Дмитрий",
  nameEn: "Poletaev Dmitriy",
  number: 15,
  group: "М3О-119БВ-26",
};

const languageName: string = "TypeScript";
const controlValue: number = 304 * student.number;
const studentId: string = `${student.group}/${String(student.number).padStart(2, "0")}`;

console.log(`Hello to ${courseNumber} from ${student.nameEn}, number ${student.number}, group ${student.group}!`);
console.log(`Привет, ${courseNumber}! Это ${student.nameRu}, номер ${student.number}, группа ${student.group}!`);
console.log(`Student ID: ${studentId} | Language: ${languageName} | Control: ${controlValue}`);
