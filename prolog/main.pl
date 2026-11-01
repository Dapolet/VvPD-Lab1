:- encoding(utf8).

% Исходные данные студента — факт.
student('Полетаев Дмитрий', 'Poletaev Dmitriy', 15, 'М3О-119БВ-26').

% Правило 1: принадлежность к группе (имя может быть русским или латинским).
group_of(Name, Group) :-
    student(Name, _, _, Group).
group_of(Name, Group) :-
    student(_, Name, _, Group).

% Правило 2: вычисление control_value.
control_value(Name, Value) :-
    student(Name, _, Number, _),
    Value is 304 * Number.
control_value(Name, Value) :-
    student(_, Name, Number, _),
    Value is 304 * Number.

% Номер в student_id выводится минимум двумя цифрами.
student_id(Group, Number, Id) :-
    format(string(Num), "~w", [Number]),
    string_length(Num, Len),
    (   Len < 2
    ->  atom_concat('0', Num, Padded)
    ;   Padded = Num
    ),
    format(string(Id), "~w/~w", [Group, Padded]).

main :-
    student(NameRu, NameEn, Number, Group),
    % Запросы к правилам на основе факта.
    group_of(NameEn, Group),
    control_value(NameEn, Control),
    student_id(Group, Number, Id),
    format("Hello to ~w from ~w, number ~w, group ~w!~n",
           [304, NameEn, Number, Group]),
    format("Привет, ~w! Это ~w, номер ~w, группа ~w!~n",
           [304, NameRu, Number, Group]),
    format("Student ID: ~w | Language: ~w | Control: ~w~n",
           [Id, 'Prolog', Control]),
    format("Members of ~w: ", [Group]),
    forall(group_of(Member, Group), format("~w; ", [Member])),
    nl.
