unit ABaixaCPBancos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, PainelGradiente, ExtCtrls,
  Componentes1, StdCtrls, Buttons, LabelCorMove, Localizacao, ComCtrls;

type
  TFBaixaCPBancos = class(TFormularioPermissao)
    PanelColor3: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DBGridColor1: TDBGridColor;
    DataMovContas: TDataSource;
    MovContas: TQuery;
    CadPlano: TQuery;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    BBAjuda: TBitBtn;
    Localiza: TConsultaPadrao;
    Label5: TLabel;
    EConta: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    LConta: TLabel;
    MovContasc_nro_doc: TStringField;
    MovContasn_vlr_sai: TFloatField;
    MovContasd_dat_com: TDateField;
    MovContasc_nom_cli: TStringField;
    Label4: TLabel;
    EFornecedor: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label6: TLabel;
    BitBtn2: TBitBtn;
    MovContasn_vlr_acr: TFloatField;
    MovContasn_vlr_des: TFloatField;
    MovContasi_lan_apg: TIntegerField;
    MovContasi_nro_par: TIntegerField;
    BitBtn3: TBitBtn;
    Data: TCalendario;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure MovContasC_CON_BANSetText(Sender: TField;
      const Text: String);
    procedure MovContasAfterInsert(DataSet: TDataSet);
    procedure BBAjudaClick(Sender: TObject);
    procedure EContaRetorno(Retorno1, Retorno2: String);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DataCloseUp(Sender: TObject);
  private
//    procedure BaixaConta( valor : Double; LancamentoApg, NroParcela : integer );
  public
    procedure CarregaContas( NroConta : string );
  end;

var
  FBaixaCPBancos: TFBaixaCPBancos;

implementation

{$R *.DFM}

uses Fundata, Constantes, funsql, AConciliacaoBan, UnContasAPagar,
     APrincipal;

{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaCPBancos.FormCreate(Sender: TObject);
begin
  AbreTabela(CadPlano);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  data.DateTime := date;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaCPBancos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CadPlano);
  MovContas.close;
  Action := CaFree;
end;

{ *************************** carrega contas a conciliar ********************* }
procedure TFBaixaCPBancos.CarregaContas( NroConta : string );
begin
  LimpaSQLTabela(MovContas);
  InseriLinhaSQL(MovContas, 0, 'Select ' );
  InseriLinhaSQL(MovContas, 1, ' MovBan.c_nro_doc, Movban.n_vlr_sai, MovBan.d_dat_com, cli.c_nom_cli, MovPag.n_vlr_acr, MovPag.n_vlr_des, MovPag.i_lan_apg, MovPag.i_nro_par ' );
  InseriLinhaSQL(MovContas, 2, ' from Movbancos as movBan, movContasAPagar as MovPag, CadContasAPAgar as CadPag, CadClientes as cli ' );
  InseriLinhaSQL(MovContas, 3, ' where Movban.C_NRO_CON = ''' + NroConta + '''' );
  InseriLinhaSQL(MovContas, 4, ' and MovBan.D_DAT_COM = ' + SQLTextoDataAAAAMMMDD(data.DateTime) +
                               ' and MovBan.c_che_can = ''N'''+
                               ' and MovBan.i_lan_bac = MovPag.i_lan_bac ' +
                               ' and MovPag.d_dat_pag is null ' +
                               ' and MovPAg.i_emp_fil = CadPag.i_emp_fil ' +
                               ' and MovPag.i_lan_apg = CadPag.i_lan_apg ' +
                               ' and CadPag.i_cod_cli = Cli.i_cod_cli' );
  if EFornecedor.Text <> '' then
    InseriLinhaSQL(MovContas, 5, ' and CadPag.i_cod_cli = ' + EFornecedor.Text );
  AbreTabela(MovContas);
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFBaixaCPBancos.BitBtn1Click(Sender: TObject);
begin
  if MovContas.State = dsEdit then
    GravaReg(MovContas);
  self.close;
end;

{******************** valida apenas , S, s, N, s no campo conciliado ********* }
procedure TFBaixaCPBancos.MovContasC_CON_BANSetText(Sender: TField;
  const Text: String);
begin
  if (text = 's') or (text =  'S' ) then
    sender.Value := 'S';

  if (text = 'n') or (text =  'N' ) then
    sender.Value := 'N';
end;

{************* cancela caso tente enserir novo registro ******************** }
procedure TFBaixaCPBancos.MovContasAfterInsert(DataSet: TDataSet);
begin
  MovContas.Cancel;
end;

procedure TFBaixaCPBancos.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FBaixaCPBancos.HelpContext);
end;

procedure TFBaixaCPBancos.EContaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    CarregaContas(Retorno1);
end;

procedure TFBaixaCPBancos.EFornecedorRetorno(Retorno1, Retorno2: String);
begin
  if EConta.Text <> '' then
    CarregaContas(EConta.Text);
end;

{procedure TFBaixaCPBancos.BaixaConta( valor : Double; LancamentoApg, NroParcela : integer );
var
  CP : TFuncoesContasAPagar;
begin
    CP := TFuncoesContasAPagar.criar(self, FPrincipal.BaseDados);
    cp.BaixaConta(valor,0,0,date,LancamentoApg,NroParcela);
end; }

{ ************ baixa o titulo com cheque-pre selecionado ********************* }
procedure TFBaixaCPBancos.BitBtn2Click(Sender: TObject);
var
  unCP : TFuncoesContasAPagar;
begin
  unCP := TFuncoesContasAPagar.criar(self, FPrincipal.BaseDados);
  unCP.BaixaConta( MovContasn_vlr_sai.AsFloat, MovContasn_vlr_des.AsFloat, MovContasn_vlr_acr.AsFloat, date, MovContasi_lan_apg.AsInteger, MovContasi_nro_par.AsInteger);
  unCP.Free;
  AtualizaSQLTabela(MovContas);
end;

{ ************ baixa todos os titulos  com cheque-pre ********************* }
procedure TFBaixaCPBancos.BitBtn3Click(Sender: TObject);
var
  unCP : TFuncoesContasAPagar;
begin
  unCP := TFuncoesContasAPagar.criar(self, FPrincipal.BaseDados);
  MovContas.DisableControls;
  MovContas.First;
  while not MovContas.Eof do
  begin
    unCP.BaixaConta( MovContasn_vlr_sai.AsFloat, MovContasn_vlr_des.AsFloat, MovContasn_vlr_acr.AsFloat, date, MovContasi_lan_apg.AsInteger, MovContasi_nro_par.AsInteger);
    MovContas.next;
  end;
  MovContas.EnableControls;
  unCP.Free;
  AtualizaSQLTabela(MovContas);
end;

procedure TFBaixaCPBancos.DataCloseUp(Sender: TObject);
begin
  if EConta.Text <> '' then
    CarregaContas(EConta.Text);
end;

Initialization
  RegisterClasses([TFBaixaCPBancos]);

end.
