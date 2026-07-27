unit ThreadForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  // 백그라운드 작업을 처리할 TThread 서브 클래스 정의
  TDownloadThread = class(TThread)
  private
    FProgress: Integer;
    procedure UpdateUI;
  protected
    procedure Execute; override;
  end;

  TFormThread = class(TForm)
    ProgressBar1: TProgressBar;
    BtnStartThread: TButton;
    LabelStatus: TLabel;
    MemoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure BtnStartThreadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormThread: TFormThread;

implementation

{$R *.dfm}

{ TDownloadThread }

procedure TDownloadThread.Execute;
var
  I: Integer;
begin
  // 1%부터 100%까지 0.05초 간격으로 진행 (총 5초 소요)
  for I := 1 to 100 do
  begin
    if Terminated then Break;

    FProgress := I;
    
    // 메인 UI를 업데이트하기 위해 Synchronize 호출!
    Synchronize(UpdateUI);
    
    Sleep(50); // 50ms 대기 (비동기 작업 시뮬레이션!)
  end;
end;

procedure TDownloadThread.UpdateUI;
begin
  // Synchronize 내부에서 호출되므로 메인 UI를 안전하게 수정!
  FormThread.ProgressBar1.Position := FProgress;
  FormThread.LabelStatus.Caption := '진행률: ' + IntToStr(FProgress) + '%';
  
  if FProgress = 100 then
  begin
    FormThread.MemoLog.Lines.Add('=== 비동기 다운로드가 완료되었습니다! ===');
    FormThread.BtnStartThread.Enabled := True;
  end;
end;

{ TFormThread }

procedure TFormThread.FormCreate(Sender: TObject);
begin
  Caption := 'Delphi 7 멀티스레드(TThread) & UI 동기화 실습';
  LabelStatus.Caption := '진행률: 0%';
  ProgressBar1.Position := 0;
end;

procedure TFormThread.BtnStartThreadClick(Sender: TObject);
var
  WorkerThread: TDownloadThread;
begin
  BtnStartThread.Enabled := False;
  MemoLog.Lines.Add('=== 스레드 다운로드 시작 (화면 멈춤 없음!) ===');
  ProgressBar1.Position := 0;

  // 스레드 생성 및 실행 (CreateSuspended = False)
  WorkerThread := TDownloadThread.Create(False);
  WorkerThread.FreeOnTerminate := True; // 스레드 종료 시 메모리 자동 해제!
end;

end.
