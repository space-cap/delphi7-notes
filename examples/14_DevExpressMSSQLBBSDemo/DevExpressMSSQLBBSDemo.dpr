program DevExpressMSSQLBBSDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain},
  BoardEditForm in 'BoardEditForm.pas' {frmBoardEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DevExpress TcxGrid 게시판 (BBS) CRUD & 페이징 데모';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.