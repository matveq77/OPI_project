
Program TextTrainingProgram;

Uses
    SysUtils;

Const
    MaxWidth = 20;
    LevelStep = 2;

Type
    TStringArray = Array Of String;
    TArr = Array Of TStringArray;

Function CreateText(Const Dictionary: TStringArray;
  OriginalString: String): String;
Var
    I: Integer;
    Word: String;
    Num: Integer;
Begin
    Randomize;
    Num := Random(9);
    Word := Dictionary[Num];
    OriginalString := OriginalString + ' ' + Word;
    CreateText := OriginalString;
End;

Function CreateDictionary(Const PathToIn: String; OriginalString: String): TArr;
Var
    InputFile: TextFile;
    Dictionary: TStringArray;
    I: Integer;
    Word: String;
    Arr: TArr;
Begin
    SetLength(Arr, 2, 1);
    SetLength(Dictionary, 10);
    AssignFile(InputFile, PathToIn);
    Reset(InputFile);
    For I := 0 To High(Dictionary) Do
    Begin
        Readln(InputFile, Word);
        Dictionary[I] := Word;
    End;
    OriginalString := CreateText(Dictionary, OriginalString);
    Arr[0][0] := OriginalString;
    Arr[1] := Dictionary;
    CreateDictionary := Arr;
End;

Function InputTextFromFile(Const Num: Integer; OriginalString: String)
  : TStringArray;
Var
    PathToIn: String;
    Arr: TArr;
    Orr: TStringArray;
Begin
    Setlength(Orr, 2);
    Case Num Of
        2:
            PathToIn := 'C:\Users\matve\Desktop\ОПИ ИГРА 2\Win32\Debug\2.txt';
        3:
            PathToIn := 'C:\Users\matve\Desktop\ОПИ ИГРА 2\Win32\Debug\3.txt';
        4:
            PathToIn := 'C:\Users\matve\Desktop\ОПИ ИГРА 2\Win32\Debug\4.txt';
        5:
            PathToIn := 'C:\Users\matve\Desktop\ОПИ ИГРА 2\Win32\Debug\5.txt';
        6:
            PathToIn := 'C:\Users\matve\Desktop\ОПИ ИГРА 2\Win32\Debug\6.txt';
        7:
            PathToIn := 'C:\Users\matve\Desktop\ОПИ ИГРА 2\Win32\Debug\7.txt';
        8:
            PathToIn := 'C:\Users\matve\Desktop\ОПИ ИГРА 2\Win32\Debug\8.txt';
    End;
    Arr := CreateDictionary(PathToIn, OriginalString);
    OriginalString := Arr[0][0];
    Orr[0] := OriginalString;
    Orr[1] := Pathtoin;
    InputTextFromFile := Orr;
End;

Function CreateStr(Const LenStr: Integer): String;
Var
    ResultValue, RandomNumber, Num, I: Integer;
    OriginalString: String;
    Orr: TStringArray;
Begin
    ResultValue := 0;
    Randomize;
    Case Lenstr Of
        20:
            Num := Random(6) + 12;
        18:
            Num := Random(4) + 10;
        16:
            Num := Random(3) + 8;
        14:
            Num := Random(2) + 6;
        12:
            Num := 9;
        10:
            Num := 7;
        8:
            Num := 4;
        6:
            Num := 3;
        4:
            Num := 1;
        2:
            Num := Random(Lenstr - 12) + 9;
    End;
    If LenStr > 12 Then
    Begin
        While ResultValue < Num Do
        Begin
            RandomNumber := Random(7) + 2;
            ResultValue := ResultValue + RandomNumber + 1;
            Orr := InputTextFromFile(RandomNumber, OriginalString);
            OriginalString := Orr[0];
        End;
    End
    Else If (LenStr > 6) And (LenStr < 14) Then
    Begin
        While ResultValue < Num Do
        Begin
            RandomNumber := Random(6) + 2;
            ResultValue := ResultValue + RandomNumber + 1;
            Orr := InputTextFromFile(RandomNumber, OriginalString);
            OriginalString := Orr[0];
        End;
    End
    Else If LenStr = 6 Then
    Begin
        RandomNumber := 2;
        Orr := InputTextFromFile(RandomNumber, OriginalString);
        OriginalString := Orr[0];
        RandomNumber := 3;
        Orr := InputTextFromFile(RandomNumber, OriginalString);
        OriginalString := Orr[0];
    End
    Else If LenStr = 4 Then
    Begin
        RandomNumber := 4;
        Orr := InputTextFromFile(RandomNumber, OriginalString);
        OriginalString := Orr[0];
    End
    Else If LenStr = 2 Then
    Begin
        RandomNumber := 2;
        Orr := InputTextFromFile(RandomNumber, OriginalString);
        OriginalString := Orr[0];
    End;
    If (LenStr > 6) And (ResultValue < LenStr) And (LenStr - ResultValue <> 1)
      And (LenStr - ResultValue <> 9) Then
    Begin
        RandomNumber := LenStr - ResultValue;
        ResultValue := ResultValue + RandomNumber;
        Orr := InputTextFromFile(RandomNumber, OriginalString);
        OriginalString := Orr[0];
    End;
    CreateStr := OriginalString;
End;

Function SecondIncorrectLetters(Const OriginalString: String;
  Var Input: String): String;
// Удвоение букв + до или после
Var
    CorrectedString: String;
    I: Integer;

Begin
    For I := 1 To Length(OriginalString) Do
    Begin
        If OriginalString[I] <> Input[I] Then
        Begin
            If I >= 1 Then
            Begin
                CorrectedString := CorrectedString + OriginalString[I - 1] +
                  OriginalString[I] + OriginalString[I];
            End
            Else
            Begin
                CorrectedString := CorrectedString + OriginalString[I] +
                  OriginalString[I] + OriginalString[I + 1];
            End;
        End
        Else
        Begin
            // Добавляем совпадающий символ к результату
            CorrectedString := CorrectedString + OriginalString[I];
        End;
    End;
    SecondIncorrectLetters := CorrectedString;
End;

Function FirstIncorrectLetters(Var OriginalString: String;
  Const Input: String): String;
// Удвоение букв
Var
    CorrectedString: String;
    I: Integer;
Begin
    For I := 1 To Length(OriginalString) Do
    Begin
        If OriginalString[I] <> Input[I] Then
        Begin
            CorrectedString := CorrectedString + OriginalString[I] +
              OriginalString[I];
        End
        Else
        Begin
            // Добавляем совпадающий символ к результату
            CorrectedString := CorrectedString + OriginalString[I];
        End;
    End;
    FirstIncorrectLetters := CorrectedString;
End;

Function TherdIncorrectLetters(Const OriginalString: String;
  Var Input: String): String;
// Удвоение слов
Var
    CorrectedString, WordIn, WordOr: String;
    I, StartIdx, StartOr, EndIn, EndOr: Integer;
Begin
    // Инициализируем начальный индекс для поиска слов в строке str1
    StartIdx := 1;

    // Проверяем каждое слово из второй строки
    For I := 1 To Length(Input) Do
    Begin
        // Если текущий символ является пробелом или достигнут конец строки
        If (Input[I] = ' ') Or (I = Length(Input)) Then
        Begin
            // Получаем слово из второй строки
            If I = Length(Input) Then
                WordIn := Copy(Input, StartIdx, I - StartIdx + 1)
            Else
                Wordin := Copy(Input, StartIdx, I - StartIdx);

            // Ищем совпадение в первой строке
            StartIdx := 1;
            While StartIdx <= Length(OriginalString) Do
            Begin
                // Если текущий символ является пробелом или достигнут конец строки
                If (OriginalString[StartIdx] = ' ') Or
                  (StartIdx = Length(OriginalString)) Then
                Begin
                    // Получаем слово из первой строки
                    If StartIdx = Length(OriginalString) Then
                        Wordor := Copy(OriginalString, StartIdx,
                          StartIdx - StartIdx + 1)
                    Else
                        Wordor := Copy(OriginalString, StartIdx,
                          StartIdx - StartIdx);

                    // Сравниваем слова
                    If CompareText(Wordin, Wordor) <> 0 Then
                    Begin
                        // Слово не найдено, добавляем его два раза в результат
                        CorrectedString := CorrectedString + ' ' + Wordor + ' ' +
                          Wordor ;
                    End
                    Else
                    Begin
                        // Слово найдено, добавляем его один раз в результат
                        CorrectedString := CorrectedString + ' ' + Wordor ;
                    End;

                    // Переходим к следующему слову в первой строке
                    StartIdx := StartIdx + 1;
                    Break;
                End;

                // Переходим к следующему символу в первой строке
                StartIdx := StartIdx + 1;
            End;
        End;

        // Переходим к следующему символу во второй строке
        StartIdx := StartIdx + 1;
    End;
    //CorrectedString := TrimLeft(CorrectedString);
    writeln(CorrectedString);
    TherdIncorrectLetters := CorrectedString;
End;

Function FothIncorrectLetters(Const OriginalString: String;
  Var Input: String): String;
// Удвоение строки
Var
    CorrectedString: String;
    I: Integer;
Begin
    For I := 1 To Length(OriginalString) Do
        If OriginalString[I] <> Input[I] Then
        Begin
            CorrectedString := OriginalString + OriginalString;
            Break;
        End
        Else
            CorrectedString := OriginalString;
    FothIncorrectLetters := CorrectedString;
End;

Function UserTry(Var OriginalString: String): String;
Var
    Input: String;
    IsCorrect: Boolean;
Begin
    IsCorrect := True;
    Repeat
    Begin
        IsCorrect := True;
        Write('Введите строку: ');
        Readln(Input);
        If Input = '13' Then
        Begin
            Writeln('Выход из программы-тренажера.');
            Break;
        End;
        If Length(OriginalString) <> Length(Input) Then
        Begin
            Writeln('Вы ввели не правильное количество символов !');
            IsCorrect := False;
        End;
    End;
    Until IsCorrect;
    UserTry := Input;
End;

Function LevelRools(Const Level: Integer; OriginalString: String;
  Input: String): String;
Var
    CorrectedString: String;
Begin
    Case Level Of
        1:
            CorrectedString := FirstIncorrectLetters(OriginalString, Input);
        2:
            CorrectedString := SecondIncorrectLetters(OriginalString, Input);
        3:
            CorrectedString := TherdIncorrectLetters(OriginalString, Input);
        4:
            CorrectedString := FothIncorrectLetters(OriginalString, Input);
    End;
    LevelRools := CorrectedString;
End;

Procedure Game();
Var
    Level, Width: Integer;
    Input, OriginalString, CorrectedString: String;
    IsCorrect: Boolean;
    LenStr: Integer;
    I: Integer;
Begin
    Level := 1;
    Width := 50;
    While Level < 5 Do
    Begin
        LenStr := 20;
        Writeln('Уровень ', Level);
        While LenStr > 0 Do
        Begin
            OriginalString := CreateStr(LenStr);
            OriginalString := TrimLeft(OriginalString);
            Writeln('Исходная строка: ', OriginalString);
            Repeat
                Input := UserTry(OriginalString);
                If Input = '13' Then
                Begin
                    Exit;
                End;
                CorrectedString := LevelRools(Level, OriginalString, Input);
                If CorrectedString <> OriginalString Then
                Begin
                    Writeln('К сожалению вы ощиблись , попробуйте ещё раз. ');
                    Writeln('Исправленная строка : ', CorrectedString);
                    OriginalString := CorrectedString
                End
                Else If Input = OriginalString Then
                Begin
                    Writeln('Вы ввели строку верно , продолжайте в том же духе. ');
                    LenStr := LenStr - LevelStep;
                    Break;
                End;
                If Length(OriginalString) > Width Then
                Begin
                    Writeln('Вы превысили ширину экрана. Жаль , но вы проиграли.');
                    Exit;
                End;
            Until OriginalString <> CorrectedString;
            If LenStr = 0 Then
            Begin
                Writeln('Вы прошли ', Level, '-й уровень !');
                Inc(Level);
            End;
            If Level = 5 Then
            Begin
                Writeln('ПОЗДРАВЛЯЮ !!! ВЫ ПРОШЛИ ВСЕ УРОВНИ !!! ТРЕНИРОВКА ЗАКОНЧЕНА !!! ');
                Exit;
            End;
        End;
    End;
    Readln;
End;

Function InputChoice(): Integer;
Var
    IsCorrect: Boolean;
    X: Integer;
Begin
    IsCorrect:=False;
    Repeat
        Try
            Readln(X);
            IsCorrect:=True;
        Except
            Writeln('Проверьте правильность введённых данных!');
        End;
        if (x <> 0) and (x <> 1) Then
        begin
            Writeln('Введите либо 1, либо 0!');
            IsCorrect := False;
        end;
    Until IsCorrect;
    InputChoice := X;
End;

Procedure RunGame();
Var
    Choice: Integer;
Begin
    Choice := 1;
    While (Choice = 1) Do
    Begin
        Game;
        Write('Желаете ли вы продолжить игру? Введите 1 если да, 0 - если нет: ');
        InputChoice();
    End;
    Writeln('Poka!!!');
End;

Begin
    Randomize;
    RunGame();
    Readln;
End.
