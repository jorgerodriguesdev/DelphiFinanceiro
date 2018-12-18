unit AConsultaMovimentoBancario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, Componentes1, ExtCtrls, PainelGradiente, ComCtrls,
  Db, DBTables, BotaoCadastro, StdCtrls, Buttons, Localizacao,
  DBKeyViolation, Mask, DBCtrls;

type
  TFConsultaMovimentoBancario = class(TFormularioPermissao)
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
    GGrade: TGridIndice;
    BBAjuda: TBitBtn;
    MovContascampo: TStringField;
    MovContastotalE: TFloatField;
    MovContastotalS: TFloatField;
    MovContasTOTAL: TFloatField;
    RCheque: TComboBoxColor;
    ROrdem: TComboBoxColor;
    Label3: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure EContaChange(Sender: TObject);
    procedure EContaRetorno(Retorno1, Retorno2: String);
  private
    procedure CarregaContas;
  public
    { Public declarations }
  end;

var
  FConsultaMovimentoBancario: TFConsultaMovimentoBancario;

implementation

uses APrincipal, funstring, fundata, AConciliacaoBan, constantes, funsql, ConstMsg;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaMovimentoBancario.FormCreate(Sender: TObject);
begin
  RCheque.ItemIndex := 0;
  ROrdem.ItemIndex := 0;
  Data1.Date := PrimeiroDiaMes(date);
  Data2.Date := UltimoDiaMes(date);
  CarregaContas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaMovimentoBancario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovContas.Cancel;
  MovContas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações de Inicialização
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************carrega as contas*********************************}
procedure TFConsultaMovimentoBancario.CarregaContas;
var
  OrderGroup,
  Cancelado,
  Conta,
  CampoAgrupar : string;
begin
  if (EConta.Text <> '') then
    Conta := ' and c_nro_con = ''' + Trim(EConta.Text) + ''''
  else
    Conta := '';
  case ROrdem.ItemIndex of
    0 : begin
          OrderGroup := ' group by D_DAT_COM order by D_DAT_COM ';
          CampoAgrupar := 'D_DAT_COM';
          GGrade.Columns[0].Title.Caption := 'Data de Compensação';
        end;
    1 : begin
          OrderGroup := ' group by C_OPE_BAN order by C_OPE_BAN ';
          CampoAgrupar := 'C_OPE_BAN';
          GGrade.Columns[0].Title.Caption := 'Operação Bancária';
        end;
    2 : begin
          OrderGroup := ' group by C_CLA_PLA order by C_CLA_PLA ';
          CampoAgrupar := 'C_CLA_PLA';
          GGrade.Columns[0].Title.Caption := 'Plano de Contas';
        end;
    3 : begin
          OrderGroup := ' group by C_NRO_CON order by C_NRO_CON ';
          CampoAgrupar := 'C_NRO_CON';
          GGrade.Columns[0].Title.Caption := 'Número Conta';
        end;
  end;
  if (RCheque.ItemIndex = 0) then
    Cancelado := ' AND c_che_can = ''S'' '
  else
    Cancelado := ' AND c_che_can = ''N'' ';
  LimpaSQLTabela(MovContas);
  AdicionaSQLTabela(MovContas,
    ' select  cast( ' + CampoAgrupar + ' as char(40)) CAMPO , ' +
    ' isnull(sum(N_VLR_SAI),0) TOTALE, isnull(sum(N_VLR_ENT),0) TOTALS, ' +
    '( TOTALE - TOTALS) TOTAL from MOVBANCOS ' +
                               ' where ' +
                               SQLTextoDataEntreAAAAMMDD( ' D_DAT_COM ', Data1.Date, Data2.Date, False) +
                               Conta +
                               Cancelado +
                               OrderGroup);
  AbreTabela(Movcontas);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFConsultaMovimentoBancario.BitBtn1Click(Sender: TObject);
begin
  Self.close;
end;

{**************************atualiza a consulta*********************************}
procedure TFConsultaMovimentoBancario.EContaChange(Sender: TObject);
begin
  CarregaContas;
end;

procedure TFConsultaMovimentoBancario.EContaRetorno(Retorno1,
  Retorno2: String);
begin
  CarregaContas;
end;

Initialization
  RegisterClasses([TFConsultaMovimentoBancario]);
end.
