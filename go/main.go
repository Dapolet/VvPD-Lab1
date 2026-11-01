package main

import "fmt"

type student struct {
	nameRu string
	nameEn string
	number int
	group  string
}

func main() {
	studentNameRu := "Полетаев Дмитрий"
	studentNameEn := "Poletaev Dmitriy"
	studentNumber := 15
	groupName := "М3О-119БВ-26"
	languageName := "Go"

	// Короткое объявление вычисляемого значения.
	studentID := fmt.Sprintf("%s/%02d", groupName, studentNumber)

	s := student{
		nameRu: studentNameRu,
		nameEn: studentNameEn,
		number: studentNumber,
		group:  groupName,
	}

	controlValue := 304 * s.number

	fmt.Printf("Hello to %d from %s, number %d, group %s!\n", 304, studentNameEn, studentNumber, groupName)
	fmt.Printf("Привет, %d! Это %s, номер %d, группа %s!\n", 304, studentNameRu, studentNumber, groupName)
	fmt.Printf("Student ID: %s | Language: %s | Control: %d\n", studentID, languageName, controlValue)
}
