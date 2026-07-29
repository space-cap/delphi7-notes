unit UserListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, ExtCtrls, DataModule;

type
  TFormUserList = class(TForm)
    PanelTop: TPanel;
    LabelSearch: TLabel;
    EditSearch: TEdit;
    BtnSearch: TButton;
    BtnRefresh: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQueryUserList: TADOQuery;
    PanelBottom: TPanel;
    LabelCount: TLabel;
    BtnClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnRefreshClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    procedure FetchUserList(const ASearchKeyword: string = '');
  public
  end;

var
  FormUserList: TFormUserList;

implementation

{$R *.dfm}

procedure TFormUserList.FormCreate(Sender: TObject);
begin
  Caption := '사용자 목록 관리 (DB 커넥션 재활용 조회 화면)';
  Position := poOwnerFormCenter;
end;

procedure TFormUserList.FormShow(Sender: TObject);
begin
  // [핵심] 새로 DB 접속을 하지 않고 전역 DataModuleMain.ADOConnection1 을 그대로 재활용!
  ADOQueryUserList.Connection := DataModuleMain.ADOConnection1;
  DataSource1.DataSet := ADOQueryUserList;
  DBGrid1.DataSource := DataSource1;

  FetchUserList;
end;

procedure TFormUserList.FetchUserList(const ASearchKeyword: string);
begin
  if not DataModuleMain.ConnectDB then Exit;

  try
    ADOQueryUserList.Close;
    ADOQueryUserList.SQL.Clear;
    ADOQueryUserList.SQL.Add('SELECT User_ID, User_Name, User_Role, Is_Active, Created_At');
    ADOQueryUserList.SQL.Add('FROM USERS');

    if Trim(ASearchKeyword) <> '' then
    begin
      ADOQueryUserList.SQL.Add('WHERE User_ID LIKE :SearchKey OR User_Name LIKE :SearchKey');
      ADOQueryUserList.Parameters.ParamByName('SearchKey').Value := '%' + Trim(ASearchKeyword) + '%';
    end;

    ADOQueryUserList.SQL.Add('ORDER BY User_ID ASC');
    ADOQueryUserList.Open;

    LabelCount.Caption := Format('총 %d 명의 사용자가 조회되었습니다.', [ADOQueryUserList.RecordCount]);
  except
    on E: Exception do
      ShowMessage('사용자 목록 조회 실패: ' + E.Message);
  end;
end;

procedure TFormUserList.BtnSearchClick(Sender: TObject);
begin
  FetchUserList(EditSearch.Text);
end;

procedure TFormUserList.BtnRefreshClick(Sender: TObject);
begin
  EditSearch.Text := '';
  FetchUserList('');
end;

procedure TFormUserList.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
