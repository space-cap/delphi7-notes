unit UserListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TFormUserList = class(TForm)
    LabelTitle: TLabel;
    StringGridUsers: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUserList: TFormUserList;

implementation

uses TabbedMDIMainForm;

{$R *.dfm}

procedure TFormUserList.FormCreate(Sender: TObject);
begin
  StringGridUsers.Cells[0, 0] := 'ID';
  StringGridUsers.Cells[1, 0] := 'ÀÌ¸§';
  StringGridUsers.Cells[2, 0] := 'ºÎ¼­';
  StringGridUsers.Cells[3, 0] := '±ÇÇÑ';

  StringGridUsers.Cells[0, 1] := 'admin';
  StringGridUsers.Cells[1, 1] := 'È«±æµ¿';
  StringGridUsers.Cells[2, 1] := 'Àü»êÆÀ';
  StringGridUsers.Cells[3, 1] := '°ü¸®ÀÚ';

  StringGridUsers.Cells[0, 2] := 'user01';
  StringGridUsers.Cells[1, 2] := '±èÃ¶¼ö';
  StringGridUsers.Cells[2, 2] := '¿µ¾÷ÆÀ';
  StringGridUsers.Cells[3, 2] := 'ÀÏ¹Ý';
end;

procedure TFormUserList.FormActivate(Sender: TObject);
begin
  if FormTabbedMDIMain <> nil then
    FormTabbedMDIMain.SetActiveTabForChild(Self);
end;

procedure TFormUserList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if FormTabbedMDIMain <> nil then
    FormTabbedMDIMain.ChildClosedNotification;
end;

end.
