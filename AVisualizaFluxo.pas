unit AVisualizaFluxo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, AxCtrls,
  OleCtrls, vcf1, ComCtrls;

type
  TFVisualizaFluxo = class(TFormularioPermissao)
    PFluxo: TPainelGradiente;
    PanelColor2: TPanelColor;
    BCofiguraImpressora: TBitBtn;
    BImprime: TBitBtn;
    BitBtn9: TBitBtn;
    BAbrir: TBitBtn;
    BBAjuda: TBitBtn;
    Paginas: TPageControl;
    BitBtn1: TBitBtn;
    PagInicial: TTabSheet;
    GradeInicial: TF1Book;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn9Click(Sender: TObject);
    procedure BImprimeClick(Sender: TObject);
    procedure BCofiguraImpressoraClick(Sender: TObject);
    procedure BAbrirClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    Pags : array[1..10] of TTabSheet;
    Grades : array[1..10] of TF1Book;
  public
    { Public declarations }
  end;

var
  FVisualizaFluxo: TFVisualizaFluxo;

implementation

uses APrincipal, constmsg, funobjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFVisualizaFluxo.FormCreate(Sender: TObject);
var
  laco : Integer;
begin
  for laco := 1 to 10 do
  begin
    Grades[laco] := nil;
    Pags[laco] := nil;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVisualizaFluxo.FormClose(Sender: TObject; var Action: TCloseAction);
var
  laco : Integer;
begin
  for laco := 1 to 10 do
    if grades[laco] <> nil then
    begin
      Grades[laco].free;
      Pags[laco].free;
    end;
 Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFVisualizaFluxo.BitBtn9Click(Sender: TObject);
begin
  self.close;
end;

{**************** Imprime fluxo ********************************************** }
procedure TFVisualizaFluxo.BImprimeClick(Sender: TObject);
begin
  if paginas.ActivePage = PagInicial then
    ImprimeGrade(GradeInicial)
  else
    ImprimeGrade(grades[Paginas.ActivePage.Tag]);
end;

{*****************  configura impressora ************************************ }
procedure TFVisualizaFluxo.BCofiguraImpressoraClick(Sender: TObject);
begin
  if paginas.ActivePage = PagInicial then
    ConfigImpressoraGrade(GradeInicial)
  else
    ConfigImpressoraGrade(grades[Paginas.ActivePage.Tag]);
end;

{******************** Abrir um fluxo ja salvo ******************************* }
procedure TFVisualizaFluxo.BAbrirClick(Sender: TObject);
var
  pag : TTabSheet;
  gra : TF1Book;
  ultimoInserido, laco : Integer;
begin
  if gradeinicial.Tag <> 0 then
  begin
    ultimoInserido := 0;
    for laco := 1 to 3 do
      if Grades[laco] = nil then  // localiza o proximo espaco a para criar uma nova grade.
      begin
        ultimoInserido := laco;
        Break;
      end;

    if ultimoInserido <> 0 then
    begin
      // cria nova pagina
      pag := TTabSheet.Create(self);
      pag.PageControl := paginas;
      paginas.ActivePage := pag;
      // cria nova grade
      gra := TF1Book.create(self);
      gra.parent := pag;
      gra.ShowGridLines := false;
      gra.Visible := true;
      gra.Align := alClient;
      gra.ShowRowHeading := false;

      // abre um fluxo
      AbreGrade(gra);
      pag.Caption := gra.SheetName[1];

      Grades[UltimoInserido] := gra;
      Pags[UltimoInserido] := pag;
      pag.tag :=UltimoInserido;
    end
    else
      aviso(Ct_MemoriaFluxo);
  end
  else
  begin
    // abre
    AbreGrade(gradeInicial);
    PagInicial.Caption := gradeInicial.SheetName[1];
    gradeInicial.tag := 1;
    paginas.ActivePage := PagInicial;
  end;
end;

{******************** fecha um fluxo aberto ********************************}
procedure TFVisualizaFluxo.BitBtn1Click(Sender: TObject);
var
  PonteiroDestruir : Integer;
begin
 if Paginas.ActivePage <> PagInicial then
 begin
    PonteiroDestruir := Paginas.ActivePage.Tag;
    grades[PonteiroDestruir].Free;
    pags[PonteiroDestruir].Free;
    Grades[PonteiroDestruir] := nil;
    Pags[PonteiroDestruir] := nil;
 end
 else
 begin
   GradeInicial.ClearRange(1, 1, 200, 34, F1ClearAll);
   gradeInicial.Tag := 0;
   PagInicial.Caption := 'Inicial';
 end;
end;


Initialization
 RegisterClasses([TFVisualizaFluxo]);
end.
