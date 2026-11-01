#!/usr/bin/env bash
# Проверка работоспособности всех реализаций: собирает и запускает их через
# scripts/run_all.sh и сверяет фактический вывод с ожидаемым.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

GROUP="М3О-119БВ-26"
NAME_EN="Poletaev Dmitriy"
NAME_RU="Полетаев Дмитрий"
NUMBER=15
CONTROL=4560

OUTPUT="$(mktemp)"
trap 'rm -f "$OUTPUT"' EXIT

echo "Сборка и запуск всех реализаций..."
if ! bash scripts/run_all.sh >"$OUTPUT" 2>&1; then
    echo "ОШИБКА: scripts/run_all.sh завершился с ошибкой"
    cat "$OUTPUT"
    exit 1
fi

# Возвращает вывод одной секции из run_all.sh по её заголовку.
section_output() {
    awk -v header="=== $1 ===" '
        $0 == header { inside = 1; next }
        /^=== /      { inside = 0 }
        inside       { print }
    ' "$OUTPUT"
}

failures=0

# check_lang <метка языка в run_all.sh> <значение Language: в выводе>
check_lang() {
    local section="$1"
    local lang="$2"
    local body
    body="$(section_output "$section")"

    local line1="Hello to 304 from ${NAME_EN}, number ${NUMBER}, group ${GROUP}!"
    local line2="Привет, 304! Это ${NAME_RU}, номер ${NUMBER}, группа ${GROUP}!"
    local line3="Student ID: ${GROUP}/${NUMBER} | Language: ${lang} | Control: ${CONTROL}"

    local ok=1
    for expected in "$line1" "$line2" "$line3"; do
        if ! grep -Fqx -- "$expected" <<<"$body"; then
            echo "ОШИБКА [$section]: нет строки: $expected"
            ok=0
            failures=$((failures + 1))
        fi
    done

    if [ "$ok" -eq 1 ]; then
        echo "OK    [$section]"
    fi
}

check_lang "C" "C"
check_lang "C++" "C++"
check_lang "Python" "Python"
check_lang "JavaScript" "JavaScript"
check_lang "TypeScript" "TypeScript"
check_lang "Java" "Java"
check_lang "C#" "C#"
check_lang "F#" "F#"
check_lang "Go" "Go"
check_lang "Rust" "Rust"
check_lang "Bash" "Bash"
check_lang "Prolog" "Prolog"

# Для assembler по заданию достаточно одной английской строки.
ASM_EXPECTED="Hello to 304 from ${NAME_EN}, number ${NUMBER}, group M3O-119BV-26!"
if grep -Fqx -- "$ASM_EXPECTED" <<<"$(section_output "Assembler")"; then
    echo "OK    [Assembler]"
else
    echo "ОШИБКА [Assembler]: нет строки: $ASM_EXPECTED"
    failures=$((failures + 1))
fi

# Визитные карточки: проверяем, что дополнительный вывод действительно есть.
check_extra() {
    local section="$1"
    local pattern="$2"
    if grep -Fq -- "$pattern" <<<"$(section_output "$section")"; then
        echo "OK    [$section] визитная карточка: $pattern"
    else
        echo "ОШИБКА [$section]: отсутствует вывод «$pattern»"
        failures=$((failures + 1))
    fi
}

check_extra "Python" "Words in student_name_en:"
check_extra "JavaScript" "Length of student_name_en:"
check_extra "F#" "total letters:"
check_extra "Rust" "Formatted student_id:"
check_extra "Bash" "Words:"
check_extra "Prolog" "Members of"

echo
if [ "$failures" -ne 0 ]; then
    echo "ПРОВЕРКА НЕ ПРОЙДЕНА: ошибок — $failures"
    echo "Полный вывод:"
    cat "$OUTPUT"
    exit 1
fi

echo "Все 13 реализаций собраны, запущены и выдали ожидаемый вывод."
