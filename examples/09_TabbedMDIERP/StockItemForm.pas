unit StockItemForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TFormStockItem = class(TForm)
    LabelTitle: TLabel;
    StringGridStock: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStockItem: TFormStockItem;

implementation

uses TabbedMDIMainForm;

{$R *.dfm}

procedure TFormStockItem.FormCreate(Sender: TObject);
begin
  StringGridStock.Cells[0, 0] := '품목코드';
  StringGridStock.Cells[1, 0] := '품목명';
  StringGridStock.Cells[2, 0] := '창고';
  StringGridStock.Cells[3, 0] := '현재재고';

  StringGridStock.Cells[0, 1] := 'P001';
  StringGridStock.Cells[1, 1] := '노트북 A';
  StringGridStock.Cells[2, 1] := '제1창고';
  StringGridStock.Cells[3, 1] := '45';

  StringGridStock.Cells[0, 2] := 'P002';
  StringGridStock.Cells[1, 2] := '모니터 27인치';
  StringGridStock.Cells[2, 2] := '제2창고';
  StringGridStock.Cells[3, 2] := '120';
end;

procedure TFormStockItem.FormActivate(Sender: TObject);
begin
  if FormTabbedMDIMain <> nil then
    FormTabbedMDIMain.SetActiveTabForChild(Self);
end;

procedure TFormStockItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if FormTabbedMDIMain <> nil then
    FormTabbedMDIMain.ChildClosedNotification;
end;

end.
