unit ABaixaChequePre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, PainelGradiente, ExtCtrls,
  Componentes1, StdCtrls, Buttons, LabelCorMove, Localizacao, ComCtrls;

type
  TFBaixaChequePre = class(TFormularioPermissao)
    PanelColor3: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DBGridColor1: TDBGridColor;
    DataMovContas: TDataSource;
    MovContas: TQuery;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    BBAjuda: TBitBtn;
    Localiza: TConsultaPadrao;
    MovContasc_nro_doc: TStringField;
    MovContasc_nom_cli: TStringField;
    Label4: TLabel;
    EFornecedor: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label6: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Data1: TCalendario;
    Label1: TLabel;
    Data2: TCalendario;
    Label2: TLabel;
    MovContasN_VLR_MOV: TFloatField;
    MovContasC_NRO_CON: TStringField;
    MovContasD_CHE_VEN: TDateField;
    MovContasI_EMP_FIL: TIntegerField;
    MovContasI_LAN_REC: TIntegerField;
    MovContasI_NRO_PAR: TIntegerField;
    DataBaixa: TCalendario;
    Label3: TLabel;
    MovContasI_COD_BAN: TIntegerField;
    ENroCheque: TEditColor;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure MovContasAfterInsert(DataSet: TDataSet);
    procedure BBAjudaClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
  private
  public
    procedure CarregaContas;
  end;

var
  FBaixaChequePre: TFBaixaChequePre;

implementation

{$R *.DFM}

uses Fundata, Constantes, funsql, AConciliacaoBan, UnContasAReceber,
     APrincipal;

{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaChequePre.FormCreate(Sender: TObject);
begin
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  data1.DateTime := date;
  data2.DateTime := date;
  DataBaixa.DateTime := date;
  CarregaContas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaChequePre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovContas.close;
  Action := CaFree;
end;

{ *************************** carrega contas a conciliar ********************* }
procedure TFBaixaChequePre.CarregaContas;
begin
  LimpaSQLTabela(MovContas);
  InseriLinhaSQL(MovContas, 0, 'Select MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR,' );
  InseriLinhaSQL(MovContas, 1, ' FRM.c_nro_doc, FRM.C_NRO_CON, FRM.n_vlr_mov, FRM.d_che_ven, cli.c_nom_cli, frm.i_cod_ban  ' );
  InseriLinhaSQL(MovContas, 2, ' from MOvForma FRM, MovContasaReceber MOV, CadContasaReceber CAD, CadClientes cli, CadFormasPagamento pag' );
  InseriLinhaSQL(MovContas, 3, ' where ' + SQLTextoDataEntreAAAAMMDD( 'FRM.D_CHE_VEN',data1.DateTime, data2.DateTime, false) +
                               ' and mov.d_dat_pag is null ' +
                               ' and FRM.I_EMP_FIL = MOV.I_EMP_FIL ' +
                               ' and FRM.I_LAN_REC = MOV.I_LAN_REC ' +
                               ' and FRM.I_NRO_PAR = MOV.I_NRO_PAR ' +
                               ' and mov.I_EMP_FIL = cad.I_EMP_FIL ' +
                               ' and mov.I_LAN_REC = cad.I_LAN_REC ' +
                               ' and Cad.I_COD_CLI = cli.I_COD_CLI ' +
                               ' and mov.c_dup_can = ''N''' +
                               ' and frm.i_cod_frm = pag.i_cod_frm ' +
                               ' and (pag.c_fla_tip = ''C'' or pag.c_fla_tip = ''R'')' );
  if EFornecedor.Text <> '' then
    AdicionaSQLTabela(MovContas, ' and Cad.i_cod_cli = ' + EFornecedor.Text );

  if ENroCheque.Text <> '' then
    AdicionaSQLTabela(MovContas,  ' and frm.c_nro_doc = ''' + ENroCheque.Text + '''' );


  AbreTabela(MovContas);
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFBaixaChequePre.BitBtn1Click(Sender: TObject);
begin
  if MovContas.State = dsEdit then
    GravaReg(MovContas);
  self.close;
end;


{************* cancela caso tente enserir novo registro ******************** }
procedure TFBaixaChequePre.MovContasAfterInsert(DataSet: TDataSet);
begin
  MovContas.Cancel;
end;

procedure TFBaixaChequePre.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FBaixaChequePre.HelpContext);
end;


{ ************ baixa o titulo com cheque-pre selecionado ********************* }
procedure TFBaixaChequePre.BitBtn2Click(Sender: TObject);
var
  unCR : TFuncoesContasAReceber;
begin
  unCR := TFuncoesContasAReceber.criar(self,FPrincipal.BaseDados);
  unCR.BaixaChequePre( MovContasI_EMP_FIL.AsInteger, MovContasI_LAN_REC.AsInteger, MovContasI_NRO_PAR.AsInteger,DataBaixa.DateTime);
  unCR.free;
  CarregaContas;
end;

{ ************ baixa todos os titulos  com cheque-pre ********************* }
procedure TFBaixaChequePre.BitBtn3Click(Sender: TObject);
var
  unCR : TFuncoesContasAReceber;
begin
  unCR := TFuncoesContasAReceber.criar(self,FPrincipal.BaseDados);
  MovContas.DisableControls;
  MovContas.First;
  while not MovContas.Eof do
  begin
    unCR.BaixaChequePre( MovContasI_EMP_FIL.AsInteger, MovContasI_LAN_REC.AsInteger, MovContasI_NRO_PAR.AsInteger,DataBaixa.DateTime);
    MovContas.next;
  end;
  MovContas.EnableControls;
  unCR.Free;
  AtualizaSQLTabela(MovContas);
end;

procedure TFBaixaChequePre.Data1CloseUp(Sender: TObject);
begin
  CarregaContas;
end;

procedure TFBaixaChequePre.EFornecedorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
   CarregaContas;
end;

Initialization
  RegisterClasses([TFBaixaChequePre]);

end.
