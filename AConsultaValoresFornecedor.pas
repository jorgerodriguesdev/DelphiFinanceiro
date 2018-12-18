unit AConsultaValoresFornecedor;
{          Autor: Sergio Luiz Censi
    Data Criação: 30/03/1999;
  Data Alteração: 30/03/1999;
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores,
  ConfigImpressora, ToolWin, ImgList, numericos, UnContasAPAgar,
  UnDespesas;

type
  TFConsultaValoresFornecedor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Localiza: TConsultaPadrao;
    DataMovParcelas: TDataSource;
    ContasAPagar: TQuery;
    tempo: TPainelTempo;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    Parcela: TRadioGroup;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    EFornecedor: TEditLocaliza;
    GParcelas: TGridIndice;
    BBAjuda: TBitBtn;
    ContasAPagarC_NOM_CLI: TStringField;
    ContasAPagarVALOR: TFloatField;
    ContasAPagarPAGO: TFloatField;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    EPlano: TEditColor;
    Label17: TLabel;
    ContasAPagarDESCONTO: TFloatField;
    ContasAPagarACRESCIMO: TFloatField;
    EValorTotal: Tnumerico;
    EAcrescimos: Tnumerico;
    EDescontos: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    AUX: TQuery;
    BImprimir: TBitBtn;
    Agrupar: TRadioGroup;
    ContasAPagarDATA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure DataParcela1Exit(Sender: TObject);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BImprimirClick(Sender: TObject);
  private
    procedure PosicionaTitulos;
  public
    { Public declarations }
  end;

var
  FConsultaValoresFornecedor: TFConsultaValoresFornecedor;

implementation

uses Fundata,  APrincipal, Constmsg, FunSQL, APlanoConta,
  AImprimeValoresFornecedor;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaValoresFornecedor.FormCreate(Sender: TObject);
begin
  DataParcela1.Date := PrimeiroDiaMes(date);
  DataParcela2.Date := UltimoDiaMes(date);
  PosicionaTitulos;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaValoresFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(AUX);
  FechaTabela(ContasAPagar);
  Action := CaFree;
end;

{***************************Atualiza a tabela MovDespesas*************************}
procedure TFConsultaValoresFornecedor.PosicionaTitulos;
var
  GrupoPor,
  Select: string;
begin
  case Agrupar.ItemIndex of
    0: begin
         GParcelas.Columns[1].Title.Caption := 'Data';
         Select := ' SELECT C_NOM_CLI, CONVERT(char(10), MOV.D_DAT_VEN, 103) DATA, ';
       end;
    1: begin
         GParcelas.Columns[1].Title.Caption := 'Mês';
         Select := ' SELECT C_NOM_CLI, CAST(MONTH(MOV.D_DAT_VEN) AS char(10)) DATA, ';
       end;
    2: begin
         GParcelas.Columns[1].Title.Caption := 'Cód. Fornecedor';
         Select := ' SELECT C_NOM_CLI, CAST(CLI.I_COD_CLI AS CHAR(10)) DATA, ';
       end;
  end;
  LimpaSQLTabela(ContasAPagar);
  InseriLinhaSQL(ContasAPagar, 0, ' SELECT ');
  InseriLinhaSQL(ContasAPagar, 1,
    ' SUM(ISNULL(N_VLR_DUP, 0)) VALOR, SUM(ISNULL(N_VLR_PAG, 0)) PAGO, ' +
    ' SUM(ISNULL(N_VLR_DES, 0)) DESCONTO, SUM(ISNULL(N_VLR_ACR, 0)) ACRESCIMO ' +
    ' FROM MOVCONTASAPAGAR MOV KEY JOIN CADCONTASAPAGAR CAD, CADCLIENTES CLI ' +
    ' WHERE CLI.I_COD_CLI = CAD.I_COD_CLI ' +
    ' AND CLI.C_TIP_CAD <> ''C'' ' +
    ' AND MOV.C_DUP_CAN = ''N'' ' +
    ' AND CAD.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
  if (Parcela.ItemIndex = 0) then
  begin
    GParcelas.Columns[2].Visible := True; // Abertas e sem parciais.
    GParcelas.Columns[3].Visible := False;
    GParcelas.Columns[4].Visible := False;
    GParcelas.Columns[5].Visible := False;
    InseriLinhaSQL(ContasAPagar, 2,' AND MOV.D_DAT_PAG IS NULL AND MOV.C_FLA_PAR = ''N'' ');
  end
  else
  begin
    GParcelas.Columns[2].Visible := False; // Fechadas e com parciais.
    GParcelas.Columns[3].Visible := True;
    GParcelas.Columns[4].Visible := True;
    GParcelas.Columns[5].Visible := True;
    InseriLinhaSQL(ContasAPagar, 2,' AND NOT MOV.D_DAT_PAG IS NULL ');
  end;
  if (EFornecedor.Text = '') then
    InseriLinhaSQL(ContasAPagar, 3,' ')
  else
    InseriLinhaSQL(ContasAPagar, 3,' AND CAD.I_COD_CLI = ' + EFornecedor.Text);
  if (EPlano.Text = '') then
    InseriLinhaSQL(ContasAPagar, 4,'')
  else
    InseriLinhaSQL(ContasAPagar, 4,' AND CAD.C_CLA_PLA = ''' + EPlano.Text + '''');
  InseriLinhaSQL(ContasAPagar, 5, (SQLTextoDataEntreAAAAMMDD( 'MOV.D_DAT_VEN', DataParcela1.Date, DataParcela2.Date, True)));
  AUX.SQL.Clear;
  AUX.SQL := ContasAPagar.SQL;
  AbreTabela(AUX);
  if (Parcela.ItemIndex = 0) then
    EValorTotal.AValor := AUX.FieldByName('VALOR').AsFloat
  else
    EValorTotal.AValor := AUX.FieldByName('PAGO').AsFloat;
  EAcrescimos.AValor := AUX.FieldByName('ACRESCIMO').AsFloat;
  EDescontos.AValor := AUX.FieldByName('DESCONTO').AsFloat;
  DeletaLinhaSQL(ContasAPagar, 0);
  InseriLinhaSQL(ContasAPagar, 0, Select);
  InseriLinhaSQL(ContasAPagar, 6,' GROUP BY C_NOM_CLI, DATA, CAD.I_COD_CLI ');
  AbreTabela(ContasAPagar);
end;

{**************************Visualiza a nota Fiscal*****************************}
procedure TFConsultaValoresFornecedor.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFConsultaValoresFornecedor.DataParcela1Exit(Sender: TObject);
begin
  PosicionaTitulos;
end;

procedure TFConsultaValoresFornecedor.EFornecedorRetorno(Retorno1,
  Retorno2: String);
begin
  PosicionaTitulos;
end;

procedure TFConsultaValoresFornecedor.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.VerificaCodigo(VpfCodigo,'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.Text := VpfCodigo;
  PosicionaTitulos;  
end;

procedure TFConsultaValoresFornecedor.EPlanoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

procedure TFConsultaValoresFornecedor.BImprimirClick(Sender: TObject);
begin
  FImprimeValoresFornecedor := TFImprimeValoresFornecedor.CriarSDI(application,'',true);
  FImprimeValoresFornecedor.CarregaImpressao(
  ContasAPagar.Text, DataParcela1.Date,DataParcela2.Date,
  LPlano.Caption, GParcelas.Columns[1].Title.Caption, (Parcela.ItemIndex = 0));
end;

Initialization
  RegisterClasses([TFConsultaValoresFornecedor]);
end.
