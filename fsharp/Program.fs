module Program

type Student =
    { NameRu: string
      NameEn: string
      Number: int
      Group: string }

let courseNumber = 304

let student =
    { NameRu = "Полетаев Дмитрий"
      NameEn = "Poletaev Dmitriy"
      Number = 15
      Group = "М3О-119БВ-26" }

let languageName = "F#"

let controlValue = 304 * student.Number
let studentId = sprintf "%s/%02d" student.Group student.Number

[<EntryPoint>]
let main _ =
    printfn "Hello to %d from %s, number %d, group %s!" courseNumber student.NameEn student.Number student.Group
    printfn "Привет, %d! Это %s, номер %d, группа %s!" courseNumber student.NameRu student.Number student.Group
    printfn "Student ID: %s | Language: %s | Control: %d" studentId languageName controlValue

    // «Визитная карточка»: цепочка преобразований через оператор конвейера.
    let words, totalLetters =
        student.NameEn.Split(' ')
        |> Array.map (fun word -> word.Length)
        |> fun lengths -> lengths.Length, Array.sum lengths

    printfn "Words in student_name_en: %d, total letters: %d" words totalLetters

    0
