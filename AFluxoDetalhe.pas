unit AFluxoDetalhe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, AxCtrls,
  OleCtrls, vcf1, StdCtrls, ComCtrls, Spin, DBGrids, Tabela, DBCtrls,
  Buttons, Mask, numericos, Graficos, ToolWin, ImgList, UnFluxo,
  EditorImagem;

type
  TFFluxoDetalhe = class(TFormularioPermissao)
    PFluxo: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DetalheDia: TQuery;
    DataDetalhes: TDataSource;
    zoom: TSpinEditColor;
    Label3: TLabel;
    BImprime: TBitBtn;
    BSalvar: TBitBtn;
    BOk: TBitBtn;
    BSuprimir: TBitBtn;
    BExpandir: TBitBtn;
    Grade: TF1Book;
    BNivel: TBitBtn;
    LPlano: TLabel;
    Label1: TLabel;
    BBAjuda: TBitBtn;
    Cor: TCor16;
    PainelDetalhes: TCorPainelGra;
    Label2: TLabel;
    DBText1: TDBText;
    Grid: TDBGridColor;
    BitBtn1: TBitBtn;
    PanelColor3: TPanelColor;
    BitBtn2: TBitBtn;
    BDetalhes: TBitBtn;
    DetalheDiaC_NOM_PLA: TStringField;
    DetalheDiad_dat_ven: TDateField;
    DetalheDiavalor: TFloatField;
    DetalheDiac_nom_cli: TStringField;
    PanelColor4: TPanelColor;
    PFormatos: TCorPainelGra;
    BitBtn3: TBitBtn;
    PanelColor5: TPanelColor;
    BitBtn4: TBitBtn;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    Label13: TLabel;
    Shape2: TShape;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Shape3: TShape;
    SpeedButton3: TSpeedButton;
    Label15: TLabel;
    Shape4: TShape;
    SpeedButton4: TSpeedButton;
    Label16: TLabel;
    Shape5: TShape;
    SpeedButton5: TSpeedButton;
    TamFonte: TSpinEditColor;
    Fonte: TComboBoxColor;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label10: TLabel;
    LarguraLinha: TSpinEditColor;
    TamanhoLinha: TSpinEditColor;
    PretoBranco: TCheckBox;
    BitBtn5: TBitBtn;
    BCofiguraImpressora: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure zoomChange(Sender: TObject);
    procedure BSuprimirClick(Sender: TObject);
    procedure BCofiguraImpressoraClick(Sender: TObject);
    procedure BImprimeClick(Sender: TObject);
    procedure BSalvarClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure BNivelClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BDetalhesClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TamFonteChange(Sender: TObject);
    procedure FonteChange(Sender: TObject);
    procedure LarguraLinhaChange(Sender: TObject);
    procedure TamanhoLinhaChange(Sender: TObject);
    procedure PretoBrancoClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    UnFluxo : TFuncoesFluxo;
    LinhaAtual : Integer;

    // utlizado para gerar o proximo nivel da propria
    VpgDiaInicio, VpgDiaFim, VpgMes, VpgAno: Word;
    VpgTipoFluxo, VpgFilialEmpresa : integer;
    VpgDiario,VpgPagar, TipoVencimento: Boolean;
    VpgPlanoContaPai : string;

  public
    procedure CarregaFluxoDetalhe(VpaDiaInicio, VpaDiaFim, VpaMes, VpaAno: Word; VpaTipoFluxo, VpaFilialEmpresa : integer;
                                  VpaPlano, VpaDesPlano: string;  VpaDiario, VpaPagar, TipoVencimento: Boolean);

  end;
var
  FFluxoDetalhe: TFFluxoDetalhe;

implementation

uses APrincipal, funstring, fundata,  constantes,
     AGraficosFluxo, FunSql, constmsg, funobjeto;

{$R *.DFM}

{##############################################################################
                               Geral
############################################################################## }

{ ****************** Na criação do Formulário ******************************** }
procedure TFFluxoDetalhe.FormCreate(Sender: TObject);
begin
  UnFluxo := TFuncoesFluxo.criar(self,FPrincipal.BaseDados);
  LarguraLinha.Value := 400;
  TamanhoLinha.Value := 25;
  Fonte.Items := screen.Fonts;
  Fonte.Text := 'Arial';
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFluxoDetalhe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  DetalheDia.close;
end;

{************* quando o formulario é mostrado ******************************* }
procedure TFFluxoDetalhe.FormShow(Sender: TObject);
begin
  grade.SetFocus;
  Grade.SheetName[1] := UnFluxo.TextoPagina;
end;

{  *** chamada externa para abertura de um fluxo mensal excolhido *** }
procedure TFFluxoDetalhe.CarregaFluxoDetalhe(VpaDiaInicio, VpaDiaFim, VpaMes, VpaAno: Word; VpaTipoFluxo, VpaFilialEmpresa : integer;
                         VpaPlano, VpaDesPlano: string; VpaDiario,VpaPagar, TipoVencimento : Boolean);
begin
  VpgDiaInicio :=     VpaDiaInicio;
  VpgDiaFim :=        VpaDiaFim;
  VpgMes :=           VpaMes;
  VpgAno :=           VpaAno;
  VpgTipoFluxo :=     VpaTipoFluxo;
  VpgFilialEmpresa := VpaFilialEmpresa;
  VpgDiario :=        VpaDiario;
  VpgPagar :=         VpaPagar;
  VpgPlanoContaPai := VpaPlano;
  self.TipoVencimento := TipoVencimento;

  LinhaAtual := LinhaInicialFluxo;
  UnFluxo.CarregaCores( Shape3.Brush.Color, Shape4.Brush.Color, Shape1.Brush.Color,
                        Shape2.Brush.Color, Shape5.Brush.Color, fonte.Text, TamFonte.value );
  UnFluxo.ConfiguraVariaveisMesDia(VpaDiario,VpaDiaInicio,VpaDiaFim,VpaMes,VpaAno,VpaTipoFluxo);
  PFluxo.Caption := UnFluxo.TextoCabecalho;
  LPlano.Caption:= VpaDesPlano;
  LinhaAtual := UnFluxo.AdicionaDias(grade, ColunaInicialFluxo, LinhaAtual,LarguraLinha.value);
  if VpaPagar then   // caso a pagar
    LinhaAtual := UnFluxo.CarregaFluxoCP(grade, ColunaInicialFluxo, LinhaAtual,VpaTipoFluxo,VpaFilialEmpresa,VpaPlano)
  else    // caso a receber
    LinhaAtual := UnFluxo.CarregaFluxoCR(grade, ColunaInicialFluxo, LinhaAtual,VpaTipoFluxo,VpaFilialEmpresa,VpaPlano, TipoVencimento);
   UnFluxo.SuprimirFluxo(grade,0);
   SelecionaCelula(grade,3,3,4,4);
   UnFluxo.FormataCodPlanoTam(grade,LinhaAtual + 1);
   self.ShowModal;
end;

{*********** funcoes de atalhos via teclado ********************************** }
procedure TFFluxoDetalhe.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key in ['d','D'] then
  begin
     BDetalhesClick(BDetalhes);
     Abort;
  end;
  if key in ['n','N'] then
  begin
     BNivelClick(BNivel);
     Abort;
  end;
  key := #;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Camadas dos componentes superiores ao grid
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ************** modifica o zoom do fluxo *********************************** }
procedure TFFluxoDetalhe.zoomChange(Sender: TObject);
begin
  if zoom.Text <> '' then
    MudaZoomGrade(grade, zoom.Value);
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Camadas dos componentes inferiores ao grid
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{**************** imprimi fluxo ********************************************* }
procedure TFFluxoDetalhe.BImprimeClick(Sender: TObject);
begin
  ImprimeGrade(grade);
end;

{**************** chama um nivel inferior ************************************}
procedure TFFluxoDetalhe.BNivelClick(Sender: TObject);
var
  Formulario: TFFluxoDetalhe;
begin
  if (Grade.TextRC[Grade.Row,1] <> '') then
  begin
    try
      if UnFluxo.ExisteDadosNivelSuperior( Grade.TextRC[Grade.Row,ColunaInicialFluxo], VpgFilialEmpresa, VpgTipoFluxo, VpgPagar ) then
      begin
        Application.CreateForm(TFFluxoDetalhe, Formulario);
        Formulario.CarregaFluxoDetalhe( VpgDiaInicio, VpgDiaFim, VpgMes, VpgAno,VpgTipoFluxo, VpgFilialEmpresa,
                                        Grade.TextRC[Grade.Row,ColunaInicialFluxo], Grade.TextRC[Grade.Row,ColunaInicialFluxo+1],
                                        VpgDiario, VpgPagar, TipoVencimento );
      end;
    finally
      Formulario.Free;
    end;
  end;
end;

{******************** salva o fluxo ****************************************** }
procedure TFFluxoDetalhe.BSalvarClick(Sender: TObject);
begin
  SalvarGrade(grade);
end;

{*********** esconde todas as linhas em branco ****************************** }
procedure TFFluxoDetalhe.BSuprimirClick(Sender: TObject);
var
  Laco : integer;
begin
  UnFluxo.SuprimirFluxo(grade,0);
end;

{************* fecha o formulario ****************************************** }
procedure TFFluxoDetalhe.BOkClick(Sender: TObject);
begin
  Self.Close;
end;

{***************** ajuda da tela ******************************************** }
procedure TFFluxoDetalhe.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FFluxoDetalhe.HelpContext);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    detalhes do dia da conta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************ mostra detalhes *********************************************** }
procedure TFFluxoDetalhe.BDetalhesClick(Sender: TObject);
var
  NomeColuna : string;
begin
  if ValidaData(Grade.Col-2,VpgMes,VpgAno) then
    NomeColuna := UnFluxo.CarregaContaDia( DetalheDia, MontaData( Grade.Col-2,VpgMes,VpgAno),
                                     VpgPlanoContaPai,Grade.Row,
                                     VpgFilialEmpresa, VpgTipoFluxo,TipoVencimento);
   if NomeColuna <> '' then
   begin
     Grid.Columns[1].Title.Caption := NomeColuna;
     PainelDetalhes.Visible := true;
     BOk.Default := false;
   end;
end;

{************* fecha detalhes ********************************************** }
procedure TFFluxoDetalhe.BitBtn2Click(Sender: TObject);
begin
  PainelDetalhes.Visible := false;
  BOk.Default := true;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            formatacao da grade
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


procedure TFFluxoDetalhe.TamFonteChange(Sender: TObject);
begin
  MudaTamnhaFonte(grade,ColunaInicialFluxo,grade.MaxCol,LinhaInicialFluxo,grade.MaxRow, TamFonte.Value);
end;

procedure TFFluxoDetalhe.FonteChange(Sender: TObject);
begin
  MudaFonte(grade,ColunaInicialFluxo,Grade.MaxCol,LinhaInicialFluxo, Grade.MaxRow,TamFonte.value, Fonte.Text);
end;
{******************* muda cor do fluxo ************************************** }
procedure TFFluxoDetalhe.SpeedButton1Click(Sender: TObject);
var
  CorIni : TColor;
  fundo : Boolean;
begin
if (sender is TSpeedButton) then
  case(sender as TSpeedButton).Tag of
   1 : CorIni := Shape1.Brush.Color;
   2 : CorIni := Shape2.Brush.Color;
   3 : CorIni := Shape3.Brush.Color;
   4 : CorIni := Shape4.Brush.Color;
   5 : CorIni := Shape5.Brush.Color;
  end;

  if cor.Execute(CorIni) then
  begin
    fundo := false;
    case(sender as TSpeedButton).Tag of
     1 : begin Shape1.Brush.Color := Cor.ACor; end;
     2 : begin Shape2.Brush.Color := Cor.ACor; end;
     3 : begin Shape3.Brush.Color := Cor.ACor; fundo := true; end;
     4 : begin Shape4.Brush.Color := Cor.ACor; fundo := true; end;
     5 : begin Shape5.Brush.Color := Cor.ACor; end;
    end;
    UnFluxo.CarregaCores( Shape3.Brush.Color, Shape4.Brush.Color, Shape1.Brush.Color,
                          Shape2.Brush.Color, Shape5.Brush.Color, fonte.Text, TamFonte.value);
    UnFluxo.Redesenha( Grade, CorIni,Cor.ACor, LinhaAtual, TamFonte.Value, fundo);
  end;
end;



procedure TFFluxoDetalhe.LarguraLinhaChange(Sender: TObject);
begin
  if LarguraLinha.Text <> '' then
    UnFluxo.MudaTamanhoColuna(grade, LarguraLinha.Value);
end;

procedure TFFluxoDetalhe.TamanhoLinhaChange(Sender: TObject);
begin
   MudaTamanhoLinhaGrade(grade,LinhaInicialFluxo, LinhaAtual, TamanhoLinha.Value * 10);
end;

procedure TFFluxoDetalhe.PretoBrancoClick(Sender: TObject);
begin
  grade.PrintNoColor := not PretoBranco.Checked;
end;

procedure TFFluxoDetalhe.BitBtn4Click(Sender: TObject);
begin
  PFormatos.Visible := false;
end;

procedure TFFluxoDetalhe.BitBtn5Click(Sender: TObject);
begin
  PFormatos.Visible :=true;
end;

procedure TFFluxoDetalhe.BCofiguraImpressoraClick(Sender: TObject);
begin
  ConfigImpressoraGrade(grade);
end;

Initialization
  RegisterClasses([TFFluxoDetalhe]);
end.
