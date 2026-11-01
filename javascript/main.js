const studentNameRu = "Полетаев Дмитрий";
const studentNameEn = "Poletaev Dmitriy";
const studentNumber = 15;
const groupName = "М3О-119БВ-26";
const languageName = "JavaScript";

const controlValue = 304 * studentNumber;
const studentId = `${groupName}/${String(studentNumber).padStart(2, "0")}`;

console.log(`Hello to ${304} from ${studentNameEn}, number ${studentNumber}, group ${groupName}!`);
console.log(`Привет, ${304}! Это ${studentNameRu}, номер ${studentNumber}, группа ${groupName}!`);
console.log(`Student ID: ${studentId} | Language: ${languageName} | Control: ${controlValue}`);

// «Визитная карточка»: длина английского имени.
console.log(`Length of student_name_en: ${studentNameEn.length}`);
