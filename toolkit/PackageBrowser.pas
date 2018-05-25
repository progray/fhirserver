unit PackageBrowser;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Edit, FMX.ListBox, FMX.StdCtrls, FMX.Grid, FMX.ScrollBox,
  FMX.Controls.Presentation,
  FHIR.Support.Objects, FHIR.Support.DateTime, FHIR.Support.Json, FHIR.Support.Generics, FHIR.Web.Fetcher;

type
  TPackageDefinition = class (TFslObject)
  private
    FId : String;
    FVersion : String;
    FCanonical : String;
    FDate : TDateTime;
    FDescription : String;
    FFHIRVersion : String;
    FUrl: String;
  public
    function link : TPackageDefinition; overload;

    property Id : String read FId write FId;
    property Version : String read FVersion write FVersion;
    property Canonical : String read FCanonical write FCanonical;
    property Date : TDateTime read FDate write FDate;
    property Description : String read FDescription write FDescription;
    property FHIRVersion : String read FFHIRVersion write FFHIRVersion;
    property Url : String read FUrl write FUrl;
  end;

  TOnLoadUrlEvent = procedure (sender : TObject; url : String) of object;

  TPackageFinderForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    btnInstall: TButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    edtFilter: TEdit;
    grid: TGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    DateColumn1: TDateColumn;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridGetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure edtFilterChange(Sender: TObject);
    procedure gridCellClick(const Column: TColumn; const Row: Integer);
    procedure btnInstallClick(Sender: TObject);
  private
    FChanged: boolean;
    FLoaded : boolean;
    FList : TFslList<TPackageDefinition>;
    FFiltered : TFslList<TPackageDefinition>;
    FOnLoad : TOnLoadUrlEvent;
    procedure loadServer;
    procedure applyFilter;
    function matchesFilter(pck : TPackageDefinition) : boolean;
    procedure AddStandardPackages;
  public
    property OnLoadUrl : TOnLoadUrlEvent read FOnLoad write FOnLoad;
  end;

var
  PackageFinderForm: TPackageFinderForm;

implementation

{$R *.fmx}

procedure TPackageFinderForm.applyFilter;
var
  pck : TPackageDefinition;
begin
  FFiltered.Clear;
  if edtFilter.Text = '' then
    FFiltered.AddAll(FList)
  else
  begin
    for pck in FList do
      if matchesFilter(pck) then
        FFiltered.Add(pck.link);
  end;
end;

procedure TPackageFinderForm.btnInstallClick(Sender: TObject);
begin
  FOnLoad(self, FFiltered[grid.Row].Url);
end;

procedure TPackageFinderForm.edtFilterChange(Sender: TObject);
begin
  applyFilter;
  grid.RowCount := 0;
  grid.RowCount := FFiltered.Count;
  gridCellClick(nil, grid.Row);
end;

procedure TPackageFinderForm.FormActivate(Sender: TObject);
begin
  if not FLoaded then
    loadServer;
end;

procedure TPackageFinderForm.FormCreate(Sender: TObject);
begin
  FList := TFslList<TPackageDefinition>.create;
  FFiltered := TFslList<TPackageDefinition>.create;
end;

procedure TPackageFinderForm.FormDestroy(Sender: TObject);
begin
  FFiltered.Free;
  FList.Free;
end;

procedure TPackageFinderForm.gridCellClick(const Column: TColumn; const Row: Integer);
begin
  btnInstall.Enabled := Row <> -1;
end;

procedure TPackageFinderForm.gridGetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
var
  pck : TPackageDefinition;
begin
  pck := FFiltered[ARow];
  case aCol of
    0: value := pck.Id;
    1: value := pck.Version;
    2: value := pck.Description;
    3: value := pck.Canonical;
    4: value := pck.FHIRVersion;
    5: value := pck.Date;
  end;
end;

procedure TPackageFinderForm.AddStandardPackages;
var
  p : TPackageDefinition;
begin
  p := TPackageDefinition.Create;
  try
    p.Id := 'hl7.fhir.core';
    p.Version := '3.4.0';
    p.Canonical := 'http://hl7.org/fhir';
    p.Date := Now;
    p.Description := 'FHIR Current Build';
    p.FHIRVersion := '3.4.0';
    p.Url := 'https://build.fhir.org/';
    FList.Add(p.Link);
  finally
    p.Free;
  end;

  p := TPackageDefinition.Create;
  try
    p.Id := 'hl7.fhir.core';
    p.Version := '3.0.1';
    p.Canonical := 'http://hl7.org/fhir';
    p.Date := EncodeDate(2017, 4, 19);
    p.Description := 'FHIR R3';
    p.FHIRVersion := '3.0.1';
    p.Url := 'https://hl7.org/fhir';
    FList.Add(p.Link);
  finally
    p.Free;
  end;

  p := TPackageDefinition.Create;
  try
    p.Id := 'hl7.fhir.core';
    p.Version := '1.0.2';
    p.Canonical := 'http://hl7.org/fhir';
    p.Date := EncodeDate(2016, 5, 15);
    p.Description := 'FHIR R2';
    p.FHIRVersion := '1.0.2';
    p.Url := 'https://hl7.org/fhir';
    FList.Add(p.Link);
  finally
    p.Free;
  end;
end;

procedure TPackageFinderForm.loadServer;
var
  j : TJsonObject;
  a : TJsonArray;
  i : TJsonNode;
  p : TPackageDefinition;
begin
  FList.clear;
  AddStandardPackages;
  a := TInternetFetcher.fetchJsonArr('https://build.fhir.org/ig/qas.json');
  try
    for i in a do
    begin
      j := i as TJsonObject;
      if (j.str['package-id'].Contains('.')) then
      begin
        p := TPackageDefinition.Create;
        try
          p.Id := j.str['package-id'];
          p.Version := j.str['ig-ver'];
          p.Canonical := j.str['url'];
          p.Date := TDateTimeEx.fromFormat('DDD, dd mmm, yyyy hh:nn:ss Z', j.str['date']).DateTime;
          p.Description := j.str['name'];
          p.FHIRVersion := j.str['version'];
          p.Url := 'https://build.fhir.org/ig/'+j.str['repo'];
          FList.Add(p.Link);
        finally
          p.Free;
        end;
      end;
    end;
  finally
    a.Free;
  end;
  FLoaded := true;
  applyFilter;
  grid.RowCount := 0;
  grid.RowCount := FFiltered.Count;
  gridCellClick(nil, grid.Row);
end;

function TPackageFinderForm.matchesFilter(pck: TPackageDefinition): boolean;
begin
  result :=
    pck.id.Contains(edtFilter.Text) or
    pck.Version.Contains(edtFilter.Text) or
    pck.Description.Contains(edtFilter.Text) or
    pck.FHIRVersion.Contains(edtFilter.Text) or
    pck.Canonical.Contains(edtFilter.Text) or
    formatDateTime('c', pck.Date).Contains(edtFilter.Text);
end;

{ TPackageDefinition }

function TPackageDefinition.link: TPackageDefinition;
begin
  result := TPackageDefinition(inherited link);
end;

end.
