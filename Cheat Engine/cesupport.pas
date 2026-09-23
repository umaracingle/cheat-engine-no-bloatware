unit cesupport;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, LMessages;

type
  { Compatibility stub retained for older callers. Advertising and all
    third-party promotional content have been removed. }
  TADWindow = class(TCustomForm)
  private
    attachedForm: TCustomForm;
    attachedWindowProc: TWndMethod;
    attachSide: TAnchorKind;
    userUrl: string;
    userPercentage: integer;
    procedure Hook(var TheMessage: TLMessage);
  public
    optional: string;
    procedure HandleMove;
    procedure AttachToForm(Form: TCustomForm);
    procedure SetCanClose(State: boolean);
    procedure SetPosition(Side: TAnchorKind);
    procedure SetUserUrl(Url: string);
    procedure SetUserPercentage(Percentage: integer);
    procedure LoadAd;
    procedure LoadAdNow;
    constructor Create2(AOwner: TComponent; CanClose: boolean);
    destructor Destroy; override;
  end;

var
  adwindow: TADWindow;

implementation

procedure TADWindow.SetUserUrl(Url: string);
begin
  { Deliberately ignored: remote/user-supplied promotional URLs are disabled. }
  userUrl := '';
end;

procedure TADWindow.SetUserPercentage(Percentage: integer);
begin
  userPercentage := 0;
end;

procedure TADWindow.HandleMove;
begin
  { No promotional window is displayed. }
end;

procedure TADWindow.Hook(var TheMessage: TLMessage);
begin
  if Assigned(attachedWindowProc) then
    attachedWindowProc(TheMessage);
end;

procedure TADWindow.SetPosition(Side: TAnchorKind);
begin
  attachSide := Side;
end;

procedure TADWindow.AttachToForm(Form: TCustomForm);
begin
  if Assigned(attachedWindowProc) and Assigned(attachedForm) then
    attachedForm.WindowProc := attachedWindowProc;

  attachedForm := Form;
  attachedWindowProc := nil;

  if Assigned(Form) then
  begin
    attachedWindowProc := Form.WindowProc;
    Form.WindowProc := @Hook;
  end;
end;

procedure TADWindow.SetCanClose(State: boolean);
begin
  { Kept for source compatibility; there is no ad window to configure. }
end;

procedure TADWindow.LoadAd;
begin
  { Advertising/PUP delivery intentionally removed. }
end;

procedure TADWindow.LoadAdNow;
begin
  { Advertising/PUP delivery intentionally removed. }
end;

constructor TADWindow.Create2(AOwner: TComponent; CanClose: boolean);
begin
  inherited CreateNew(AOwner);
  SetCanClose(CanClose);
  Visible := False;
end;

destructor TADWindow.Destroy;
begin
  if Assigned(attachedWindowProc) and Assigned(attachedForm) then
    attachedForm.WindowProc := attachedWindowProc;
  inherited Destroy;
end;

initialization
  adwindow := nil;

finalization
  adwindow := nil;

end.
