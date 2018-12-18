unit AFormaPagtoCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Mask, Componentes1, StdCtrls, Buttons, DBCtrls, Tabela, Localizacao,
  ExtCtrls, PainelGradiente, DBKeyViolation, Db, DBTables, Grids, DBGrids;

type
  TFFormaPagtoCP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    LCheque: TLabel;
    ECheque: TDBEditColor;
    LConta: TLabel;
    EConta: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    LVencimento: TLabel;
    EVencimento: TDBEditColor;
    ValidaGravacao1: TValidaGravacao;
    BFechar: TBitBtn;
    Grade: TDBGridColor;
    Parcela: TQuery;
    DataParcela: TDataSource;
    ParcelaI_EMP_FIL: TIntegerField;
    ParcelaI_NRO_PAR: TIntegerField;
    ParcelaI_COD_FRM: TIntegerField;
    ParcelaC_NRO_CON: TStringField;
    ParcelaD_DAT_VEN: TDateField;
    ParcelaC_NRO_DOC: TStringField;
    ParcelaC_NRO_DUP: TStringField;
    Label20: TLabel;
    ComboPagamento: TDBLookupComboBoxColor;
    CadFrmPag: TQuery;
    CadFrmPagI_COD_FRM: TIntegerField;
    CadFrmPagC_NOM_FRM: TStringField;
    CadFrmPagC_FLA_BCR: TStringField;
    CadFrmPagC_FLA_TIP: TStringField;
    DataCadFrmPag: TDataSource;
    ParcelaD_CHE_VEN: TDateField;
    Label1: TLabel;
    ParcelaI_LAN_APG: TIntegerField;
    ParcelaN_VLR_DUP: TFloatField;
    ParcelaI_LAN_BAC: TIntegerField;
    LProxima: TLabel;
    LValorCheque: TLabel;
    EValorCheque: TDBEditNumerico;
    ParcelaN_VLR_CHE: TFloatField;
    BVarias: TBitBtn;
    BBAjuda: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboPagamentoClick(Sender: TObject);
    procedure EVencimentoChange(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure ParcelaBeforePost(DataSet: TDataSet);
    procedure ParcelaAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ParcelaAfterEdit(DataSet: TDataSet);
    procedure EContaCadastrar(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BBAjudaClick(Sender: TObject);
  private
    ValorTotal : Double;
    Conta, fechar : boolean;
    procedure ConfiguraComponentes( FlagTipo : char );
    procedure LimpaCamposBase;
    procedure AbreFormaPagamento( conta : Boolean );
    procedure ValidaAGravacao;
  public
    function FormaPagamentoParcela( lancamento, NroParcela, CodFrmPagto : Integer; valorTotal : Double ) : integer;
    function FormaPagamentoConta( lancamento, CodFrmPagto : Integer; valorTotal : Double ) : integer;
  end;

var
  FFormaPagtoCP: TFFormaPagtoCP;

implementation

uses APrincipal, funObjeto, funsql, constantes, AContas;

{$R *.DFM}

// D = Dinheiro
// C = Cheque
// T = Cartão crédito
// B = Cob. bancária
// R = Cheque terceiros
// A = Carteira
// E = Cheque Eletronico
// F = Diversas Formas

{ ****************** Na criação do Formulário ******************************** }
procedure TFFormaPagtoCP.FormCreate(Sender: TObject);
begin
  Fechar := false;
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormaPagtoCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
// CadFrmPag.close;  nao deve fechar aqui
// Parcela.close; nao deve fechar
end;

{************** evita fechar o formulario com dados vazios ***************** }
procedure TFFormaPagtoCP.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (not BFechar.Enabled) and (not Fechar) then
    canClose := false;
end;

{************** fecha o formulario *******************************************}
procedure TFFormaPagtoCP.BFecharClick(Sender: TObject);
begin
  if not Conta then
    LimpaCamposBase;
  if Parcela.State = DsEdit then
    parcela.post;
  self.close;
  fechar := true;
end;

{************************* quando inicializa o formualario ****************** }
procedure TFFormaPagtoCP.FormShow(Sender: TObject);
begin
  ComboPagamento.SetFocus;
end;

{********************* Configura Componentes ******************************** }
// D = Dinheiro
// C = Cheque
// T = Cartão crédito
// B = Cob. bancária
// R = Cheque terceiros
// A = Carteira
// E = Cheque Eletronico
// F = Diversas Formas

procedure TFFormaPagtoCP.ConfiguraComponentes( FlagTipo : char );
begin
  EConta.ACampoObrigatorio := False;
  ECheque.ACampoObrigatorio := False;
  EVencimento.ACampoObrigatorio := false;
  EValorCheque.ACampoObrigatorio := false;
  AlterarEnabledDet([ EValorCheque, EVencimento, ECheque, EConta, BVarias, LVencimento, LValorCheque, LCheque, LConta], true);
  case FlagTipo of
    'C', 'H'  : begin // Cheque;
            EVencimento.ACampoObrigatorio := true;
            ECheque.ACampoObrigatorio := True;
            EConta.ACampoObrigatorio := True;
            EValorCheque.ACampoObrigatorio := true;
            AlterarEnabledDet([ BVarias], false);
            if FlagTipo = 'H' then
            begin
              LVencimento.Caption := 'Data Boleto';
              LCheque.caption := 'Nº do Boleto';
              LValorCheque.caption := 'Valor do Boleto';
            end;
          end;
    'B','D','A' : // Lançamento Bancário, dinheiro, carteira
          begin
            AlterarEnabledDet([EValorCheque, EVencimento,ECheque, EConta, LCheque, LVencimento, LConta, LValorCheque, BVarias], false);
          end;
    'R' : Begin // cheques de terceiros
            AlterarEnabledDet([EValorCheque, EVencimento, ECheque, EConta, BVarias, LVencimento, LCheque, LValorCheque, LConta],false );
          end;
    'F' : Begin // Varias formas
            AlterarEnabledDet([EValorCheque, EVencimento, ECheque, EConta,  LVencimento, LCheque, LValorCheque, LConta],false );
          end;
    else
      AlterarEnabledDet([EValorCheque, EVencimento, ECheque, EConta, BVarias, LVencimento, LCheque, LValorCheque, LConta],false );
  end;
end;


{******************* limpa campos conforme forma de pagamento *************** }
// D = Dinheiro
// C = Cheque
// T = Cartão crédito
// B = Cob. bancária
// R = Cheque terceiros
// A = Carteira
// E = Cheque Eletronico
// F = Diversas Formas

procedure TFFormaPagtoCP.LimpaCamposBase;
begin
  case CadFrmPagC_FLA_TIP.AsString[1] of
    'B','R','A','D', 'F' :
          begin // Lançamento Bancário,cheques de terceiros, carteira, dinheiro, varias formas
            EVencimento.Field.clear;
            ECheque.Field.clear;
            EConta.Field.Clear;
            EValorCheque.Field.clear;
          end;
    'C', 'H' : begin end; // cheque
     else
     begin
        EVencimento.Field.Clear;
        ECheque.Field.Clear;
        EConta.Field.Clear;
        EValorCheque.Field.clear;
     end;
  end;
end;

{*********************** altera a forma de pagamento *********************** }
procedure TFFormaPagtoCP.ComboPagamentoClick(Sender: TObject);
begin
  ConfiguraComponentes(UpperCase(CadFrmPagC_FLA_TIP.AsString)[1]);
  ValidaAGravacao;
end;


{******************* valida a gravacao ************************************** }
procedure TFFormaPagtoCP.EVencimentoChange(Sender: TObject);
begin
  if Parcela.State = dsEdit then
    ValidaAGravacao;
end;

{****************** abre as formas pagamento ******************************** }
procedure TFFormaPagtoCP.AbreFormaPagamento( conta : Boolean );
begin
  LimpaSQLTabela(CadFrmPag);
  AdicionaSQLTabela( CadFrmPag, 'select * from CadFormasPagamento ' +
                                ' where C_FLA_BCP <> ''U'' ' );
  AdicionaSQLTabela( CadFrmPag, ' and c_fla_tip <> ''T'' ' +   // cartao
                                ' and c_fla_tip <> ''E'' '  ); // cheque eletronico
  AbreTabela(CadFrmPag);
end;

{****************** limpa os campos antes de gravar ************************ }
procedure TFFormaPagtoCP.ParcelaBeforePost(DataSet: TDataSet);
begin
  if conta then
    LimpaCamposBase;
end;

{************** valida a gravacao quando conta ****************************** }
procedure TFFormaPagtoCP.ParcelaAfterScroll(DataSet: TDataSet);
begin
  if conta then
  begin
    Parcela.edit;
    ConfiguraComponentes(CadFrmPagC_FLA_TIP.AsString[1]);
    ValidaGravacao1.execute;
  end;
  if not (Parcela.State in [ dsEdit ]) then
    Parcela.edit;
  if (CadFrmPagC_FLA_TIP.AsString = 'C') or (CadFrmPagC_FLA_TIP.AsString = 'H') then //cheque
  begin
    ParcelaD_CHE_VEN.AsDateTime := date;
    ParcelaN_VLR_CHE.AsCurrency := ParcelaN_VLR_DUP.AsCurrency;
  end;
end;

{*************** F5 para nova parcela caso conta *************************** }
procedure TFFormaPagtoCP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 116) and (LProxima.Enabled) then
  begin
    EConta.Atualiza;
    if Parcela.State = DsEdit then
      parcela.post;
    Parcela.Next;
   if not Parcela.Eof then
     parcela.edit;
  end;
end;

{************** valida a gravacao *******************************************}
procedure TFFormaPagtoCP.ValidaAGravacao;
begin
  ValidaGravacao1.execute;
  if Conta then
    LProxima.Enabled := BFechar.Enabled;
end;

{************* quando editar, se cheque adiociona valores ****************** }
procedure TFFormaPagtoCP.ParcelaAfterEdit(DataSet: TDataSet);
begin
 if conta then
   if (CadFrmPagC_FLA_TIP.AsString = 'C') or (CadFrmPagC_FLA_TIP.AsString = 'H') then
   begin
     EVencimento.Field.AsDateTime := date;
     EValorCheque.Field.AsCurrency := ParcelaN_VLR_DUP.AsCurrency;
   end;
end;

{************** permite cadastrar contas ************************************ }
procedure TFFormaPagtoCP.EContaCadastrar(Sender: TObject);
begin
  FContas := TFContas.CriarSDI(application, '', true);
  FContas.ShowModal;
  localiza.AtualizaConsulta;
end;


{################## chamada externas ######################################### }

{*************** Pagamento Parcelas ****************************************** }
function TFFormaPagtoCP.FormaPagamentoParcela( lancamento, NroParcela, CodFrmPagto : Integer; valorTotal : Double ) : integer;
begin
  AbreFormaPagamento(false);
  AdicionaSQLAbreTabela(Parcela,
    ' select * from MovContasaPagar ' +
    ' where I_LAN_APG = ' + IntToStr(Lancamento) +
    ' and I_NRO_PAR = ' + IntToStr(NroParcela) +
    ' and I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil));
  Conta := false;
  self.ValorTotal := valorTotal;
  parcela.edit;
  ParcelaI_COD_FRM.AsInteger := CodFrmPagto;
  ConfiguraComponentes(UpperCase(CadFrmPagC_FLA_TIP.AsString)[1]);
  grade.Enabled := false;
  ValidaAGravacao;
  EConta.Atualiza;
  self.ShowModal;
  result := ParcelaI_COD_FRM.AsInteger;
  CadFrmPag.close;
  Parcela.close;
end;

{*************** Pagamento Contas ******************************************** }
function TFFormaPagtoCP.FormaPagamentoConta( lancamento, CodFrmPagto : Integer; valorTotal : Double ) : integer;
begin
  AbreFormaPagamento(true);
  AdicionaSQLAbreTabela(Parcela,
    ' select * from MovContasaPagar ' +
    ' where I_LAN_APG = ' + IntToStr(Lancamento) +
    ' and I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil) +
    ' order by i_nro_par ' );
  Conta := true;
  self.ValorTotal := valorTotal;
  parcela.edit;
  ParcelaI_COD_FRM.AsInteger := CodFrmPagto;
  ConfiguraComponentes(UpperCase(CadFrmPagC_FLA_TIP.AsString)[1]);
  ValidaAGravacao;
  EConta.Atualiza;
  self.ShowModal;
  result := ParcelaI_COD_FRM.AsInteger;
  CadFrmPag.close;
  Parcela.close;  
end;


procedure TFFormaPagtoCP.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FFormaPagtoCP.HelpContext);
end;

Initialization
 RegisterClasses([TFFormaPagtoCP]);
end.

