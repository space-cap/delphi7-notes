program BasicSyntaxDemo;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes;

// 1. 함수 선언 (결과값을 리턴하는 함수)
function AddNumbers(A, B: Integer): Integer;
begin
  Result := A + B;
end;

// 2. 프로시저 선언 (일만 수행하는 프로시저)
procedure PrintHeader(Title: String);
begin
  Writeln('========================================');
  Writeln('  ', Title);
  Writeln('========================================');
end;

var
  I, Total: Integer;
  FruitList: TStringList;
begin
  // 헤더 출력
  PrintHeader('Delphi 7 기본 문법 & TStringList 실습');

  // [실습 1] 변수 및 사칙 연산
  Total := AddNumbers(15, 25);
  Writeln('1. AddNumbers(15, 25) 결과: ', Total);
  Writeln;

  // [실습 2] 반복문 (for ... to ... do)
  Writeln('2. 1부터 5까지 반복문 실습:');
  for I := 1 to 5 do
  begin
    Writeln('   Count: ', I);
  end;
  Writeln;

  // [실습 3] TStringList 및 try...finally 안전한 객체 관리
  Writeln('3. TStringList 활용 및 메모리 안전 해제:');
  FruitList := TStringList.Create; // 객체 생성
  try
    FruitList.Add('사과 (Apple)');
    FruitList.Add('바나나 (Banana)');
    FruitList.Add('포도 (Grape)');

    Writeln('   총 과일 개수: ', FruitList.Count);
    for I := 0 to FruitList.Count - 1 do
    begin
      Writeln('   [' + IntToStr(I) + '] ' + FruitList[I]);
    end;
  finally
    FruitList.Free; // 메모리 해제!
    Writeln('   -> FruitList 메모리가 안전하게 해제되었습니다.');
  end;

  Writeln;
  Writeln('엔터 키(Enter)를 누르면 프로그램이 종료됩니다...');
  Readln;
end.
