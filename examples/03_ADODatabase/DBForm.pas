unit DBForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls;

type
  TFormDB = class(TForm)
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    BtnAdd: TButton;
    BtnFirst: TButton;
    BtnNext: TButton;
    EditName: TEdit;
    EditAge: TEdit;
    LabelName: TLabel;
    LabelAge: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnFirstClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDB: TFormDB;

implementation

{$R *.dfm}

procedure TFormDB.FormCreate(Sender: TObject);
begin
  Caption := 'Delphi 7 DataSet & DBGrid 실습';

  // 메모리 인메모리 DB 컬럼 정의 (이름, 나이)
  ClientDataSet1.FieldDefs.Add('ID', ftInteger, 0, False);
  ClientDataSet1.FieldDefs.Add('NAME', ftString, 20, False);
  ClientDataSet1.FieldDefs.Add('AGE', ftInteger, 0, False);
  ClientDataSet1.CreateDataSet; // DataSet 데이터 생성

  // 샘플 데이터 삽입
  ClientDataSet1.AppendRecord([1, '김철수', 25]);
  ClientDataSet1.AppendRecord([2, '이영희', 28]);
  ClientDataSet1.AppendRecord([3, '박민수', 30]);

  // DataSource와 DBGrid 바인딩 연결
  DataSource1.DataSet := ClientDataSet1;
  DBGrid1.DataSource := DataSource1;
end;

procedure TFormDB.BtnAddClick(Sender: TObject);
var
  NewID: Integer;
begin
  if Trim(EditName.Text) = '' then
  begin
    ShowMessage('이름을 입력하세요.');
    Exit;
  end;

  NewID := ClientDataSet1.RecordCount + 1;
  
  // 데이터 추가 (Append -> FieldByName -> Post)
  ClientDataSet1.Append;
  ClientDataSet1.FieldByName('ID').AsInteger := NewID;
  ClientDataSet1.FieldByName('NAME').AsString := Trim(EditName.Text);
  ClientDataSet1.FieldByName('AGE').AsInteger := StrToIntDef(EditAge.Text, 20);
  ClientDataSet1.Post;

  ShowMessage('데이터가 성공적으로 추가되었습니다!');
end;

procedure TFormDB.BtnFirstClick(Sender: TObject);
begin
  ClientDataSet1.First;
end;

procedure TFormDB.BtnNextClick(Sender: TObject);
begin
  if not ClientDataSet1.Eof then
    ClientDataSet1.Next;
end;

end.
