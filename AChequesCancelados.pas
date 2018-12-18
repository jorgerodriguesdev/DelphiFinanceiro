unit AChequesCancelados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, Componentes1, ExtCtrls, PainelGradiente, ComCtrls,
  Db, DBTables, BotaoCadastro, StdCtrls, Buttons, Localizacao,
  DBKeyViolation, Mask, numericos, UnBancario, DBCtrls;

type
  TFChequesCancelados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Data1: TCalendario;
    Data2: TCalendario;
    BitBtn1: TBitBtn;
    MovContas: TQuery;
    DataMovContas: TDataSource;
    Localiza: TConsultaPadrao;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EConta: TEditLocaliza;
    Label8: TLabel;
    Label10: TLabel;
    MovContasI_LAN_BAC: TIntegerField;
    MovContasC_NRO_CON: TStringField;
    MovContasN_VLR_ENT: TFloatField;
    MovContasN_VLR_SAI: TFloatField;
    MovContasN_SAL_ATU: TFloatField;
    MovContasD_DAT_COM: TDateField;
    MovContasC_NRO_DOC: TStringField;
    MovContasC_CON_BAN: TStringField;
    GridIndice1: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    MovContasL_OBS_BAN: TMemoField;
    Label1: TLabel;
    ETotalCancelado: Tnumerico;
    MovContasVALOR: TFloatField;
    BBAjuda: TBitBtn;
    MovContasC_OPE_BAN: TStringField;
    MovContasCREDITO_DEBITO: TStringField;
    Label3: TLabel;
    EDebito: Tnumerico;
    ECredito: Tnumerico;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure EContaChange(Sender: TObject);
    procedure MovContasVALORGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure BBAjudaClick(Sender: TObject);
    procedure EContaRetorno(Retorno1, Retorno2: String);
    procedure MovContasCREDITO_DEBITOGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
  private
    MB : TFuncoesBancario;
    procedure CarregaContas;
  public
    { Public declarations }
  end;

var
  FChequesCancelados: TFChequesCancelados;

implementation

uses APrincipal, funstring, fundata, AConciliacaoBan, constantes, funsql, ConstMsg;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFChequesCancelados.FormCreate(Sender: TObject);
begin
  MB := TFuncoesBancario.criar(self,FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  Data1.Date := PrimeiroDiaMes(date);
  Data2.Date := UltimoDiaMes(date);
  CarregaContas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFChequesCancelados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Mb.Destroy;
  MovContas.Cancel;
  MovContas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações de Inicialização
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************carrega as contas*********************************}
procedure TFChequesCancelados.CarregaContas;
var
  Conta : string;
  Ent, Sai: Double;
begin
  if (EConta.Text <> '') then
    Conta := ' and Ban.c_nro_con = ''' + Trim(EConta.Text) + ''''
  else
    Conta := '';
  LimpaSQLTabela(MovContas);
  AdicionaSQLTabela(MovContas, ' Select '  +
                               ' Ban.I_LAN_BAC, Ban.C_OPE_BAN, Ban.C_NRO_CON, ISNULL(Ban.N_VLR_ENT, 0) N_VLR_ENT, ISNULL(Ban.N_VLR_SAI, 0) N_VLR_SAI, Ban.L_OBS_BAN, ' +
                               ' Ban.N_SAL_ATU, Ban.D_DAT_COM, Ban.C_NRO_DOC, Ban.C_CON_BAN ' +
                               ' from Movbancos as Ban, CadContas as Co' +
                               ' where c_che_can = ''S''' +
                               Conta +
                               ' and Ban.C_NRO_CON = Co.C_NRO_CON ' +
                               ' and ' + SQLTextoDataEntreAAAAMMDD( 'D_DAT_COM', Data1.Date, Data2.Date, False) );
  AdicionaSQLTabela(MovContas, ' order by d_dat_com, i_lan_bac ' );
  AbreTabela(MovContas);
  ETotalCancelado.AValor := MB.SomaCancelados(Data1.Date, Data2.Date, EConta.Text, Ent, Sai);
  EDebito.AValor := Sai;
  ECredito.AValor := Ent;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFChequesCancelados.BitBtn1Click(Sender: TObject);
begin
  Self.close;
end;

{**************************atualiza a consulta*********************************}
procedure TFChequesCancelados.EContaChange(Sender: TObject);
begin
  CarregaContas;
end;

procedure TFChequesCancelados.MovContasVALORGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if MovContasN_VLR_ENT.AsFloat > 0 then
    Text := FormatFloat(varia.MascaraValor ,MovContasN_VLR_ENT.AsFloat)
  else

    if MovContasN_VLR_SAI.AsFloat > 0 then
      Text := FormatFloat(varia.MascaraValor, MovContasN_VLR_SAI.AsFloat)
    else
      Text := '0,00';
end;

procedure TFChequesCancelados.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FChequesCancelados.HelpContext);
end;

procedure TFChequesCancelados.EContaRetorno(Retorno1, Retorno2: String);
begin
  CarregaContas;
end;

procedure TFChequesCancelados.MovContasCREDITO_DEBITOGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if MovContasN_VLR_ENT.AsFloat > 0 then
    Text := 'C'
  else
    if MovContasN_VLR_SAI.AsFloat > 0 then
      Text := 'D'
    else
      Text := '';
end;

Initialization
  RegisterClasses([TFChequesCancelados]);
end.
