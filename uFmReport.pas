unit uFmReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FR_DSet, FR_DBSet, FR_Class, ExtCtrls;

type
  TfmReport = class(TForm)
    frMain: TfrReport;
    frdsVars: TfrDBDataSet;
    frdsWords: TfrDBDataSet;
    imgTemp: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReport: TfmReport;

implementation

uses unDmMain;

{$R *.dfm}



end.
