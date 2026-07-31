unit BoardEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB;

type
  TBoardMode = (bmInsert, bmEdit, bmView);

  TfrmBoardEdit = class(TForm)
    pnlBottom: TPanel;
    btnSave: TButton;
    btnCancel: TButton;

    lblTitle: TLabel;
    edtTitle: TEdit;
    lblWriter: TLabel;
    edtWriterName: TEdit;
    chkIsNotice: TCheckBox;

    lblContent: TLabel;
    mmoContent: TMemo;

    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FMode: TBoardMode;
    FBoardID: Integer;
    FConnection: TADOConnection;
    procedure LoadBoardDetail;
  public
    { Public declarations }
    procedure InitForm(AMode: TBoardMode; ABoardID: Integer; AConnection: TADOConnection);
  end;

var
  frmBoardEdit: TfrmBoardEdit;

implementation

{$R *.dfm}

procedure TfrmBoardEdit.InitForm(AMode: TBoardMode; ABoardID: Integer; AConnection: TADOConnection);
begin
  FMode := AMode;
  FBoardID := ABoardID;
  FConnection := AConnection;

  case FMode of
    bmInsert:
      begin
        Caption := '게시글 신규 작성';
        edtTitle.Text := '';
        edtWriterName.Text := '';
        mmoContent.Text := '';
        chkIsNotice.Checked := False;

        btnSave.Visible := True;
        btnCancel.Caption := '취소';
        edtTitle.ReadOnly := False;
        edtWriterName.ReadOnly := False;
        mmoContent.ReadOnly := False;
        chkIsNotice.Enabled := True;
      end;
    bmEdit:
      begin
        Caption := '게시글 수정 (No. ' + IntToStr(FBoardID) + ')';
        LoadBoardDetail;

        btnSave.Visible := True;
        btnCancel.Caption := '취소';
        edtTitle.ReadOnly := False;
        edtWriterName.ReadOnly := False;
        mmoContent.ReadOnly := False;
        chkIsNotice.Enabled := True;
      end;
    bmView:
      begin
        Caption := '게시글 상세보기 (No. ' + IntToStr(FBoardID) + ')';
        LoadBoardDetail;

        btnSave.Visible := False;
        btnCancel.Caption := '닫기';
        edtTitle.ReadOnly := True;
        edtWriterName.ReadOnly := True;
        mmoContent.ReadOnly := True;
        chkIsNotice.Enabled := False;
      end;
  end;
end;

procedure TfrmBoardEdit.LoadBoardDetail;
var
  Qry: TADOQuery;
begin
  Qry := TADOQuery.Create(Self);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT BoardID, Title, Content, WriterName, IsNotice FROM dbo.TB_BOARD WHERE BoardID = :ID';
    Qry.Parameters.ParamByName('ID').Value := FBoardID;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      edtTitle.Text := Qry.FieldByName('Title').AsString;
      edtWriterName.Text := Qry.FieldByName('WriterName').AsString;
      mmoContent.Text := Qry.FieldByName('Content').AsString;
      chkIsNotice.Checked := Qry.FieldByName('IsNotice').AsBoolean;
    end;
  finally
    Qry.Free;
  end;
end;

procedure TfrmBoardEdit.btnSaveClick(Sender: TObject);
var
  Qry: TADOQuery;
begin
  if Trim(edtTitle.Text) = '' then
  begin
    ShowMessage('제목을 입력하세요.');
    edtTitle.SetFocus;
    Exit;
  end;

  if Trim(edtWriterName.Text) = '' then
  begin
    ShowMessage('작성자를 입력하세요.');
    edtWriterName.SetFocus;
    Exit;
  end;

  Qry := TADOQuery.Create(Self);
  try
    Qry.Connection := FConnection;

    if FMode = bmInsert then
    begin
      Qry.SQL.Text :=
        'INSERT INTO dbo.TB_BOARD (Title, Content, WriterName, IsNotice, RegDate) ' +
        'VALUES (:Title, :Content, :WriterName, :IsNotice, GETDATE())';
    end
    else if FMode = bmEdit then
    begin
      Qry.SQL.Text :=
        'UPDATE dbo.TB_BOARD ' +
        'SET Title = :Title, Content = :Content, WriterName = :WriterName, IsNotice = :IsNotice, ModDate = GETDATE() ' +
        'WHERE BoardID = :ID';
      Qry.Parameters.ParamByName('ID').Value := FBoardID;
    end;

    Qry.Parameters.ParamByName('Title').Value := Trim(edtTitle.Text);
    Qry.Parameters.ParamByName('Content').Value := mmoContent.Text;
    Qry.Parameters.ParamByName('WriterName').Value := Trim(edtWriterName.Text);
    Qry.Parameters.ParamByName('IsNotice').Value := chkIsNotice.Checked;

    Qry.ExecSQL;
    ModalResult := mrOk;
  finally
    Qry.Free;
  end;
end;

procedure TfrmBoardEdit.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
