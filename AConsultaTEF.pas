unit AConsultaTEF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, Mask, numericos, UnTEF, UnECf;

type
  TFConsultaTEF = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    CadTEF: TQuery;
    DataCadTEF: TDataSource;
    CadTEFI_NRO_PAR: TIntegerField;
    CadTEFN_NRO_IDE: TFloatField;
    CadTEFN_DOC_VIN: TFloatField;
    CadTEFN_VLR_TOT: TFloatField;
    CadTEFC_CMC_TEF: TStringField;
    CadTEFC_TIP_PES: TStringField;
    CadTEFN_DOC_PES: TFloatField;
    CadTEFD_DAT_CHE: TDateField;
    CadTEFC_STA_TRA: TStringField;
    CadTEFC_NOM_RED: TStringField;
    CadTEFN_TIP_TRA: TFloatField;
    CadTEFN_TRA_NSU: TFloatField;
    CadTEFN_LOT_TRA: TFloatField;
    CadTEFT_TIM_HOS: TDateTimeField;
    CadTEFD_TRA_COM: TDateField;
    CadTEFH_TRA_COM: TTimeField;
    CadTEFN_TRA_CAN: TFloatField;
    CadTEFT_TRA_CAN: TDateTimeField;
    CadTEFC_FIN_TEF: TStringField;
    CadTEFN_QTD_LIN: TFloatField;
    CadTEFC_BAN_TEF: TStringField;
    CadTEFC_AGE_TEF: TStringField;
    CadTEFC_AGE_DCC: TStringField;
    CadTEFC_CON_COR: TStringField;
    CadTEFC_CON_DCC: TStringField;
    CadTEFC_NRO_CHE: TStringField;
    CadTEFC_CHE_DCC: TStringField;
    CadTEFI_COD_FRM: TIntegerField;
    CadTEFD_DAT_VEN: TDateField;
    CadTEFD_DAT_PAG: TDateField;
    CadTEFN_VLR_PAR: TFloatField;
    CadTEFN_VLR_PAG: TFloatField;
    ECartao: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Localiza: TConsultaPadrao;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ETransacao: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    CadTEFI_COD_TRA: TIntegerField;
    CadTEFC_NOM_TRA: TStringField;
    ENroTransacao: Tnumerico;
    Label5: TLabel;
    BParcelas: TBitBtn;
    CadTEFI_LAN_REC: TIntegerField;
    BCancelamento: TBitBtn;
    CadTEFI_SEQ_TEF: TIntegerField;
    CadTEFC_CAN_TEF: TStringField;
    BBAjuda: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure ECartaoRetorno(Retorno1, Retorno2: String);
    procedure ENroTransacaoExit(Sender: TObject);
    procedure BParcelasClick(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure CadTEFAfterScroll(DataSet: TDataSet);
    procedure BCancelamentoClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
    TEF : TFuncoesTEF;
    ECF : TECF;
    procedure CarregaTEF;
    function AdiconaFiltros : string;
    procedure AtualizaTab;
  public
  end;

var
  FConsultaTEF: TFConsultaTEF;

implementation

uses APrincipal, funSql, constantes, AAlteraParcelaCartao, funstring,
     ABaixaContasReceber, FTefDiscado, constmsg, funsistema, AMostraNroNSU;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaTEF.FormCreate(Sender: TObject);
begin
  TEF := TFuncoesTEF.criar(self, FPrincipal.BaseDados);
  ECF := TECF.criar(self, FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  CarregaTEF;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaTEF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TEF.Free;
  ECF.Free;
  CadTEF.close;
  Action := CaFree;
end;

procedure TFConsultaTEF.CarregaTEF;
begin
  LimpaSQLTabela(CadTEF);
  AdicionaSQLTabela(CadTEF, ' Select * '  +
                            ' from MovTef tef, MovContasaReceber mov, cadtipotransacao tra ' +
                            ' where Mov.i_emp_fil = ' + IntTostr(varia.CodigoEmpFil) +
                            AdiconaFiltros +
                            ' and mov.i_emp_fil = tef.i_emp_fil ' +
                            ' and mov.i_seq_tef = tef.i_seq_tef ' +
                            ' and tef.n_tip_tra *= tra.i_cod_tra ');
  AbreTabela(CadTEF);
end;

{************* monta os filtros de consulta ********************************** }
function TFConsultaTEF.AdiconaFiltros : string;
begin
  result := '';
  if ECartao.Text <> '' then
    result := result + ' and tef.c_nom_red = ''' + label1.Caption + '''';
  if ETransacao.Text <> '' then
    result := result + ' and tef.n_tip_tra = ' + ETransacao.Text;
  if ENroTransacao.AValor <> 0 then
    result := result + ' and tef.n_tra_nsu = ' + intToStr(trunc(ENroTransacao.AValor));
end;

{****************** atualiza a tabela marcando a posicao de inicio *********** }
procedure TFConsultaTEF.AtualizaTab;
var
  ponto : Tbookmark;
begin
  ponto := CadTEF.GetBookmark;
  AtualizaSQLTabela(CadTEF);
  CadTEF.GotoBookmark(ponto);
  CadTEF.FreeBookmark(ponto);
end;

{**************** configura os botoes de funcoes **************************** }
procedure TFConsultaTEF.CadTEFAfterScroll(DataSet: TDataSet);
begin
//  BPagamento.Enabled := (CadTEFN_VLR_PAG.ascurrency = 0) and (CadTEFC_CAN_TEF.AsString = 'N');
  BParcelas.Enabled := (CadTEFN_VLR_PAG.ascurrency = 0)  and (CadTEFC_CAN_TEF.AsString = 'N');
  BCancelamento.Enabled := (CadTEFN_VLR_PAG.ascurrency = 0) and (CadTEFC_CAN_TEF.AsString = 'N');
end;

{******************* retorno do cartao ************************************* }
procedure TFConsultaTEF.ECartaoRetorno(Retorno1, Retorno2: String);
begin
  CarregaTEF;
end;

{********************** exit do nro de transacao ( NSU ) ******************** }
procedure TFConsultaTEF.ENroTransacaoExit(Sender: TObject);
begin
  CarregaTEF;
end;

{***************** fecha a formulario **************************************** }
procedure TFConsultaTEF.BitBtn1Click(Sender: TObject);
begin
 self.close;
end;

{*************** efetua a alteracao de uma conta *************************** }
procedure TFConsultaTEF.BParcelasClick(Sender: TObject);
begin
  FAlteraParcelaCartao := TFAlteraParcelaCartao.CriarSDI(application, '', true);
  FAlteraParcelaCartao.CarregaAlterarcao( CadTEFI_LAN_REC.AsInteger);
  AtualizaTab;
end;

{*************** efetua o pagamento de uma parcela ************************* }
procedure TFConsultaTEF.BPagamentoClick(Sender: TObject);
begin
{  FEfetuarBaixaReceber := TFEfetuarBaixaReceber.CriarSDI(application,'',true); //verificar a permissão na versão original;
  if FEfetuarBaixaReceber.BaixaParcela( CadTEFI_LAN_REC.AsInteger, CadTefI_NRO_PAR.AsInteger, CadTefD_DAT_VEN.AsDateTime, CadTEFc_c) then
  begin
   FEfetuarBaixaReceber.ShowModal;
   AtualizaTab;
  end
  else
   FEfetuarBaixaReceber.close;}
end;

{****************** cancela um conta TEF ************************************}
procedure TFConsultaTEF.BCancelamentoClick(Sender: TObject);
var
  textoECF : TstringList;
  laco : integer;
  acao : Boolean;
begin
  if ECF.AbrePorta then   // verifica se existe impressora
  begin
    ECF.FecharPorta; // a porta ecf sera aberta na untef
    if not VerificaFormCriado('TFTEF') then
      FTEF := TFTEF.CriarSDI(application, '', true);
    if not VerificaFormCriado('TFMostraNroNSU') then
      FMostraNroNSU := TFMostraNroNSU.CriarSDI(application, '', true);
    FMostraNroNSU.AbreTela(CadTEFN_TRA_NSU.AsString, DeletaChars(CadTEFD_TRA_COM.AsString,'/'), DeletaChars(CadTEFH_TRA_COM.AsString,':'));

    if  FTEF.CancelamentoCartao( CadTEFI_SEQ_TEF.AsInteger ) then
    begin
      // salva a transacao
      TEF.SalvaTrancacao(  CadTEFI_SEQ_TEF.AsInteger, true );
      tef.ImprimeTextoECFComLeitura;
      AtualizaTab;
    end
    else
      Aviso(CT_CancelouCancelamento);
  end;

  if VerificaFormCriado('TFMostraNroNSU') then
    FMostraNroNSU.close;

end;


procedure TFConsultaTEF.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FConsultaTEF.HelpContext);
end;

Initialization
 RegisterClasses([TFConsultaTEF]);
end.
