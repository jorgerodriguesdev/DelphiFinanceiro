unit AFormaPagtoCR1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Mask, Componentes1, StdCtrls, Buttons, DBCtrls, Tabela, Localizacao,
  ExtCtrls, PainelGradiente, DBKeyViolation, Db, DBTables, Grids, DBGrids, UnClassesImprimir,
  ComCtrls, numericos;

type
  TFFormaPagtoCR1 = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    BFechar: TBitBtn;
    Grade: TDBGridColor;
    Parcela: TQuery;
    DataParcela: TDataSource;
    ParcelaI_EMP_FIL: TIntegerField;
    ParcelaI_LAN_REC: TIntegerField;
    ParcelaI_NRO_PAR: TIntegerField;
    ParcelaI_COD_FRM: TIntegerField;
    ParcelaN_VLR_PAR: TFloatField;
    ParcelaC_NRO_DUP: TStringField;
    Label20: TLabel;
    ComboPagamento: TDBLookupComboBoxColor;
    CadFrmPag: TQuery;
    CadFrmPagI_COD_FRM: TIntegerField;
    CadFrmPagC_NOM_FRM: TStringField;
    CadFrmPagC_FLA_BCR: TStringField;
    CadFrmPagC_FLA_TIP: TStringField;
    DataCadFrmPag: TDataSource;
    LProxima: TLabel;
    BBAjuda: TBitBtn;
    BimprimeCheque: TBitBtn;
    Label3: TLabel;
    ParcelaI_COD_SIT: TIntegerField;
    Paginas: TPageControl;
    TCheque: TTabSheet;
    TVariasFormas: TTabSheet;
    TCobBanco: TTabSheet;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    EBancoCob: TDBEditLocaliza;
    SpeedButton4: TSpeedButton;
    EConta: TDBEditLocaliza;
    LVencimento: TLabel;
    EVencimento: TDBEditColor;
    ECheque: TDBEditColor;
    LCheque: TLabel;
    LvalorCheque: TLabel;
    EcontaCheque: TDBEditColor;
    LConta: TLabel;
    Lbanco: TLabel;
    EBanco: TDBEditLocaliza;
    SpeedButton2: TSpeedButton;
    EnroBoleto: TDBEditNumerico;
    EValorCheque: TDBEditNumerico;
    Label1: TLabel;
    Label2: TLabel;
    Aux: TQuery;
    Formas: TQuery;
    DataFormas: TDataSource;
    FormasI_EMP_FIL: TIntegerField;
    FormasI_NRO_LOT: TIntegerField;
    FormasI_COD_FRM: TIntegerField;
    FormasN_VLR_MOV: TFloatField;
    FormasC_NRO_CON: TStringField;
    FormasC_NRO_DOC: TStringField;
    FormasC_NOM_CHE: TStringField;
    FormasD_ULT_ALT: TDateField;
    FormasI_LAN_REC: TIntegerField;
    FormasI_NRO_PAR: TIntegerField;
    FormasD_CHE_VEN: TDateField;
    FormasI_COD_BAN: TIntegerField;
    Label7: TLabel;
    Label6: TLabel;
    DBEditColor1: TDBEditColor;
    ParcelaN_PER_MOR: TFloatField;
    ParcelaN_PER_JUR: TFloatField;
    ParcelaN_PER_MUL: TFloatField;
    ParcelaN_DES_VEN: TFloatField;
    GFormas: TDBGridColor;
    Elocbanco: TDBEditLocaliza;
    EdcFormaPgto: TDBEditLocaliza;
    ParcelaD_DAT_VEN: TDateField;
    ParcelaD_ULT_ALT: TDateField;
    FormasC_SIT_FRM: TStringField;
    ParcelaL_OBS_REC: TMemoField;
    Label8: TLabel;
    CadFrmPagI_COD_SIT: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboPagamentoClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EContaRetorno(Retorno1, Retorno2: String);
    procedure ParcelaAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EContaCadastrar(Sender: TObject);
    procedure EBancoCadastrar(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BBAjudaClick(Sender: TObject);
    procedure BimprimeChequeClick(Sender: TObject);
    procedure ParcelaBeforeScroll(DataSet: TDataSet);
    procedure ParcelaN_VLR_PARChange(Sender: TField);
    procedure ParcelaI_COD_FRMChange(Sender: TField);
    procedure EVencimentoChange(Sender: TObject);
    procedure GFormasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GFormasColExit(Sender: TObject);
    procedure GFormasKeyPress(Sender: TObject; var Key: Char);
    procedure FormasBeforePost(DataSet: TDataSet);
    procedure FormasAfterInsert(DataSet: TDataSet);
    procedure FormasAfterPost(DataSet: TDataSet);
    procedure FormasAfterScroll(DataSet: TDataSet);
    procedure FormasBeforeDelete(DataSet: TDataSet);
    procedure GFormasExit(Sender: TObject);
    procedure ParcelaBeforePost(DataSet: TDataSet);
    procedure EdcFormaPgtoSelect(Sender: TObject);
    procedure GFormasEnter(Sender: TObject);
  private
    Fechar : boolean;
    Conta : Boolean;
    procedure LimpaCamposBase( Flag : char);
    procedure AbreFormaPagamento( conta : Boolean );
    function ValidaAGravacao( Flag : char) : Boolean;
    procedure LocalizaFormas;
    procedure mostraTab;
    procedure AdicionaValores;
    function FlaFrm( codFrm : integer ) : char;
    function ValidaTotalVariasFormas : Boolean;
  public
    function FormaPagamentoParcela( lancamento, NroParcela, CodFormaPagto : Integer; ValorPago, ValorASerPago : Double ) : integer;
    function FormaPagamentoConta( lancamento : Integer ) : integer;
  end;

var
  FFormaPagtoCR1: TFFormaPagtoCR1;

implementation

uses APrincipal, funObjeto, funsql, constantes,  AContas,
     ABancos, AMostraCheque, fundata, funstring, constmsg, funnumeros, UnContasareceber;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         inicializa formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFFormaPagtoCR1.FormCreate(Sender: TObject);
begin
  Fechar := false;
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  BimprimeCheque.Visible := varia.ImpressoraCheque <> 0;
  Label3.Visible := varia.ImpressoraCheque <> 0;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormaPagtoCR1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// Parcela.close; nao deve fechar
// CadFrmPag.close;     nao deve fechar aqui
  aux.close;
  Action := CaFree;
end;

{******************* inicia as formas de pagamento *************************** }
procedure TFFormaPagtoCR1.AbreFormaPagamento( conta : Boolean );
begin
  LimpaSQLTabela(CadFrmPag);
  AdicionaSQLTabela( CadFrmPag, 'select * from dba.CadFormasPagamento ' +
                                ' where c_fla_bcr <> ''U'' ' +
                                ' and c_fla_tip <> ''T'' ' +
                                ' and c_fla_tip <> ''H'' ' +
                                ' and c_fla_tip <> ''E'' ' );
  if not conta then
      AdicionaSQLTabela( CadFrmPag, ' and c_fla_tip <> ''A'' ');
  AbreTabela(CadFrmPag);
end;

{************************* fecha o formulario ******************************}
procedure TFFormaPagtoCR1.BFecharClick(Sender: TObject);
var
  erro : boolean;
begin
  erro := true;
  ParcelaBeforeScroll(parcela);  // grava as tabelas
  parcela.First;
  while not parcela.eof do
  begin
    if not ValidaAGravacao(CadFrmPagC_FLA_TIP.AsString[1]) then
    begin
      erro := false;
      aviso('Falta dados para esta forma de pagamento...');
      exit;
    end;
    Parcela.next;
  end;
  if erro then
  begin
    Parcela.First;
    self.close;
    Fechar := true;
  end;
end;

{************************* verifica o fechamento do formulario **************}
procedure TFFormaPagtoCR1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (not BFechar.Enabled) and (not Fechar) then
    canClose := false;
end;

{************************** na abertura do formulario ************************}
procedure TFFormaPagtoCR1.FormShow(Sender: TObject);
begin
  if ComboPagamento.Enabled then
    ComboPagamento.SetFocus;
end;

{****************  no pressionar uma tecla no formulario *********************}
procedure TFFormaPagtoCR1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 116) then
  begin
    ParcelaBeforeScroll(nil);
    if not Parcela.eof then
      Parcela.Next
    else
      parcela.First;
  end;
  if ( key = 117 ) and (BimprimeCheque.Enabled) then
     BimprimeCheque.Click;
end;

{************************* ajuda ********************************************}
procedure TFFormaPagtoCR1.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FFormaPagtoCR1.HelpContext);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Chamada externas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************** Pagamento Parcelas ****************************************** }
function TFFormaPagtoCR1.FormaPagamentoParcela( lancamento, NroParcela, CodFormaPagto : Integer; ValorPago, ValorASerPago : Double ) : integer;
begin
  conta := false;
  AbreFormaPagamento(false);
  AdicionaSQLAbreTabela(Parcela,
    ' select * from MovContasaReceber ' +
    ' where I_LAN_REC = ' + IntToStr(Lancamento) +
    ' and I_NRO_PAR = ' + IntToStr(NroParcela) +
    ' and I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil));
  parcela.edit;
  Formas.edit;
  ParcelaI_COD_FRM.AsInteger := CodFormaPagto;
  FormasI_COD_FRM.AsInteger := CodFormaPagto;
  if ArredondaDecimais(ValorAserPago,2) > ArredondaDecimais(ValorPago,2) then  // cria parcial
    ParcelaN_VLR_PAR.AsCurrency := ValorPago;  //  caso parcial
  ComboPagamentoClick(ComboPagamento);
  grade.Enabled := false;
  ValidaAGravacao(CadFrmPagC_FLA_TIP.AsString[1]);
  self.ShowModal;
  result := ParcelaI_COD_FRM.AsInteger;
  CadFrmPag.close;
  Parcela.close;
end;

{*************** Pagamento Contas ******************************************** }
function TFFormaPagtoCR1.FormaPagamentoConta( lancamento : Integer) : integer;
begin
  conta := true;
  AbreFormaPagamento(true);
  AdicionaSQLAbreTabela(Parcela,
    ' select * from MovContasaReceber ' +
    ' where I_LAN_REC = ' + IntToStr(Lancamento) +
    ' and I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil) +
    ' order by i_nro_par ' );
  parcela.edit;
  ValidaAGravacao(CadFrmPagC_FLA_TIP.AsString[1]);
  self.ShowModal;
  result := ParcelaI_COD_FRM.AsInteger;
  CadFrmPag.close;
  Parcela.close;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Valida as formas de pagamento
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************** mostra pagina da forma ************************* }
procedure TFFormaPagtoCR1.mostraTab;
begin
  TCheque.TabVisible := false;
  TVariasFormas.TabVisible := false;
  TCobBanco.TabVisible := false;
  BimprimeCheque.Enabled := false;
  Paginas.Visible := true;

  case CadFrmPagC_FLA_TIP.AsString[1] of
   'C' : begin                              // cheque
          TCheque.TabVisible := true;
          if BimprimeCheque.Visible then
            BimprimeCheque.Enabled := true;
         end;
   'V' : begin  TVariasFormas.Caption := 'Formas Variadas  |  del - excluir  |';
                TVariasFormas.TabVisible := true;   // varias formas
                if self.visible then
                  GFormas.SetFocus;
                GFormas.SelectedIndex := 0;
              end;
   'R' : begin TVariasFormas.Caption := 'Cheques de Terceiros | del - excluir  |';
               TVariasFormas.TabVisible := true;   // cheque terceiro
               if self.visible then
                 GFormas.SetFocus;
               GFormas.SelectedIndex := 0;
              end;
   'B' : TCobBanco.TabVisible := true;     // cobranca bancaria
   else Paginas.Visible := false;
  end;
  ValidaAGravacao(CadFrmPagC_FLA_TIP.AsString[1]);
  AdicionaValores;
end;

{*************************** adiciona valores padrao ************************ }
procedure TFFormaPagtoCR1.AdicionaValores;
begin
  if not (formas.State in [dsedit, dsinsert]) then
    formas.edit;
  case CadFrmPagC_FLA_TIP.AsString[1] of
   'C' : begin
           if  FormasN_VLR_MOV.IsNull then
             FormasN_VLR_MOV.AsCurrency := ParcelaN_VLR_PAR.AsCurrency;  // cheque
           if  FormasD_CHE_VEN.IsNull then
              FormasD_CHE_VEN.AsDateTime := ParcelaD_DAT_VEN.AsDateTime;
         end;
//     'R' : TChequeTerceiro.TabVisible := true;   // cheque terceiro
   'B' : if  FormasN_VLR_MOV.IsNull then
           FormasN_VLR_MOV.AsCurrency := ParcelaN_VLR_PAR.AsCurrency;     // cobranca bancaria
   'V' : if FormasI_COD_FRM.AsInteger = ParcelaI_COD_FRM.AsInteger then
          FormasI_COD_FRM.AsInteger := Varia.FormaPagamentoPadrao;
  end;
  if CadFrmPagC_FLA_TIP.AsString[1] <> 'V' then
    FormasI_COD_FRM.AsInteger := ParcelaI_COD_FRM.AsInteger;

end;

function  TFFormaPagtoCR1.FlaFrm( codFrm : integer ) : char;
begin
   AdicionaSQLAbreTabela(aux, ' select * from dba.CadFormasPagamento ' +
                              ' where i_cod_frm = ' + inttostr(codFrm) ) ;
   result := aux.fieldByName('c_fla_tip').asstring[1];
   aux.close;
end;

{************** na movimentacao na escolha da forma de pagamento *************}
procedure TFFormaPagtoCR1.ComboPagamentoClick(Sender: TObject);
begin
  if conta then
    if (CadFrmPagC_FLA_TIP.AsString = 'V') and (ParcelaI_NRO_PAR.AsInteger <> 1) then
    begin
      aviso('Esta forma de pagamento so poder utilizada no primeiro pagamento ');
      BFechar.Enabled := false;
      ParcelaI_COD_FRM.AsInteger := Varia.FormaPagamentoPadrao;
    end;
  mostraTab;
end;



function TFFormaPagtoCR1.ValidaAGravacao( Flag : char) : Boolean;
var
  Valida : Boolean;
begin
  valida := true;
  case flag of
    'C' : begin // Cheque, home banking;
             if FormasD_CHE_VEN.IsNull or FormasN_VLR_MOV.IsNull or FormasI_COD_BAN.IsNull or FormasC_NRO_DOC.IsNull  then
               valida := false;
          end;
    'B' : begin // Lançamento Bancário.
             if FormasN_VLR_MOV.IsNull or FormasI_COD_BAN.IsNull then
               valida := false;
          end;
  end;
  BFechar.Enabled := Valida;
  Result := valida;
end;

{******************** limpa campos conforme tipo de forma de pgto ************}
procedure TFFormaPagtoCR1.LimpaCamposBase( Flag : char);
begin
  if not (Formas.State in [dsinsert, dsedit ]) then
    formas.edit;
  case flag of
    'C' : begin // Cheque, home banking;
                FormasC_NOM_CHE.Clear;
              end;
    'B' : begin // Lançamento Bancário.
            FormasC_NOM_CHE.Clear;
            FormasD_CHE_VEN.Clear;
          end;
     'V', 'R' : Begin end;
     else
     begin
        FormasC_NRO_CON.Clear;
        Formasc_nro_doc.Clear;
        FormasC_NOM_CHE.Clear;
        FormasD_CHE_VEN.Clear;
        FormasI_COD_BAN.Clear;
     end;
  end;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      funcoes dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFFormaPagtoCR1.EContaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    EBancoCob.Field.AsInteger :=  StrToInt(retorno2);
    EBancoCob.Atualiza;
  end;
end;

procedure TFFormaPagtoCR1.EContaCadastrar(Sender: TObject);
begin
  FContas := TFContas.CriarSDI(application, '', true);
  FContas.ShowModal;
  localiza.AtualizaConsulta;
end;

procedure TFFormaPagtoCR1.EBancoCadastrar(Sender: TObject);
begin
  FBancos := TFBancos.CriarSDI(application, '', true);
  FBancos.ShowModal;
  localiza.AtualizaConsulta;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       funcoes das tabelas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{**************** antes do scrol ********************************************}
procedure TFFormaPagtoCR1.ParcelaBeforeScroll(DataSet: TDataSet);
begin
  if Formas.State in [dsEdit, dsInsert] then
    Formas.post;
  if Parcela.State in [dsEdit, dsInsert] then
    parcela.post;
end;

{******************* depois do scroll ****************************************}
procedure TFFormaPagtoCR1.ParcelaAfterScroll(DataSet: TDataSet);
begin
  if not (Parcela.State in [ dsEdit ]) then
    Parcela.edit;
  LocalizaFormas;
  ComboPagamentoClick(ComboPagamento);
  AdicionaValores;
  if (FormasC_NRO_CON.AsString <> '') and (TCobBanco.TabVisible) then
    Econta.Atualiza;
  FormasAfterScroll(nil);
end;

{********************* posiciona o mov formas *********************************}
procedure  TFFormaPagtoCR1.LocalizaFormas;
begin
  AdicionaSQLAbreTabela(Formas, ' Select * from movforma where ' +
                                '      i_emp_fil = '  + ParcelaI_EMP_FIL.AsString +
                                '  and i_Lan_rec = ' + ParcelaI_LAN_REC.AsString +
                                '  and i_nro_par = ' + ParcelaI_NRO_PAR.AsString);
  Formas.edit;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Imprime cheque
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFFormaPagtoCR1.BimprimeChequeClick(Sender: TObject);
var
  dados : TDadosCheque;
begin
  dados := TDadosCheque.Create;
  dados.ValorCheque := FormasN_VLR_MOV.AsCurrency;
  AdicionaSQLAbreTabela(Aux, 'Select * from cadfiliais where i_emp_fil = ' + inttostr(varia.CodigoEmpFil));
  dados.DescNominal := Aux.fieldByname('c_nom_fil').AsString;
  dados.CidadeEmitido := Aux.fieldByname('c_cid_fil').AsString;
  FechaTabela(aux);
  dados.DiaDeposito := intTostr(dia(FormasD_CHE_VEN.AsDateTime));
  dados.MesDeposito :=  intTostr(mes(FormasD_CHE_VEN.AsDateTime));
  dados.AnodeDeposito :=  intTostr(ano(FormasD_CHE_VEN.AsDateTime));
  dados.Banco := AdicionaCharE('0', FormasI_COD_BAN.AsString, 3);
  dados.Conta := FormasC_NRO_CON.AsString;
  dados.Numero := FormasC_NRO_CON.AsString;
  FMostracheque := TFMostracheque.CriarSDI(application, '', true);
  FMostraCheque.MostraImprime(dados);
end;



procedure TFFormaPagtoCR1.ParcelaN_VLR_PARChange(Sender: TField);
begin
  if formas.State in [dsEdit, dsInsert] then
    FormasN_VLR_MOV.AsCurrency := ParcelaN_VLR_PAR.AsCurrency;
end;

procedure TFFormaPagtoCR1.ParcelaI_COD_FRMChange(Sender: TField);
begin
  if paginas.ActivePage <> TVariasFormas then
    if formas.State in [dsEdit, dsInsert] then
     FormasI_COD_FRM.AsInteger := ParcelaI_COD_FRM.AsInteger;
end;

procedure TFFormaPagtoCR1.EVencimentoChange(Sender: TObject);
begin
  ValidaAGravacao(CadFrmPagC_FLA_TIP.AsString[1]);
end;

procedure TFFormaPagtoCR1.GFormasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
  begin
    if not (formas.State in [dsInsert, dsEdit ]) then
      EditarReg(formas);
    case GFormas.SelectedIndex of
      2 : Elocbanco.AAbreLocalizacao;
      0 : EdcFormaPgto.AAbreLocalizacao;
    end;
  end;
  if key = 46 then
  begin
    if confirmacao('Deseja realmente excluir esta forma de pagamento ?') then
      formas.Delete;
  end;

end;

procedure TFFormaPagtoCR1.GFormasColExit(Sender: TObject);
begin
  if not (formas.State in [dsInsert, dsEdit ]) then
    EditarReg(formas);
  case GFormas.SelectedIndex of
    2 : Elocbanco.Atualiza;
    0 : EdcFormaPgto.Atualiza;
  end;
end;

procedure TFFormaPagtoCR1.GFormasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = '.' then
    key := ',';
end;

procedure TFFormaPagtoCR1.FormasBeforePost(DataSet: TDataSet);
var
   valida : boolean;
begin
 FormasD_ULT_ALT.AsDateTime := date;
 valida := true;
 if Paginas.ActivePage = TVariasFormas then
 begin
   if FormasN_VLR_MOV.IsNull or FormasI_COD_FRM.IsNull  then
     valida := false
   else
      if not ValidaAGravacao(FlaFrm(FormasI_COD_FRM.AsInteger)) then
        valida := false;

    if not valida then
     begin
       erro('Conforme forma de pagamento escolhida, alguns dos valores não podem estar nulos !');
       GFormas.setfocus;
       abort;
     end
     else
       LimpaCamposBase(FlaFrm(FormasI_COD_FRM.AsInteger));
  end
  else
     LimpaCamposBase(CadFrmPagC_FLA_TIP.AsString[1]);
end;

procedure TFFormaPagtoCR1.FormasAfterInsert(DataSet: TDataSet);
begin
  FormasI_EMP_FIL.AsInteger := ParcelaI_EMP_FIL.AsInteger;
  FormasI_NRO_LOT.AsInteger := ProximoCodigoFilial('MovForma','i_nro_lot','i_emp_fil', ParcelaI_EMP_FIL.AsInteger, FPrincipal.BaseDados);
  FormasD_ULT_ALT.AsDateTime := date;
  FormasI_LAN_REC.AsInteger := ParcelaI_LAN_REC.AsInteger;
  FormasI_NRO_PAR.AsInteger := ParcelaI_NRO_PAR.AsInteger;
  FormasC_SIT_FRM.AsString := 'C';
end;

procedure TFFormaPagtoCR1.FormasAfterPost(DataSet: TDataSet);
begin
  if Paginas.ActivePage = TVariasFormas then
  begin
    AtualizaSQLTabela(Formas);
    Formas.last;
  end;
end;

procedure TFFormaPagtoCR1.FormasAfterScroll(DataSet: TDataSet);
begin
  if Paginas.ActivePage = TVariasFormas then
  begin
    Label20.Enabled := (Formas.RecordCount = 1) and (Formas.state <> dsInsert);
    ComboPagamento.Enabled  := (Formas.RecordCount = 1) and (Formas.state <> dsInsert);
  end;
end;

procedure TFFormaPagtoCR1.FormasBeforeDelete(DataSet: TDataSet);
begin
  if Formas.RecordCount = 1 then
    abort;
end;


{*************** quando clica no ok do formulario **************************** }
function TFFormaPagtoCR1.ValidaTotalVariasFormas : Boolean;
var
   ValorTotal : Double;
begin
  result := true;
  if Formas.State in [ dsInsert, dsEdit ] then
    GravaReg(Formas);
  ValorTotal := 0;
  formas.First;
  while not formas.Eof do
  begin
    ValorTotal := valorTotal + formasN_VLR_mov.AsFloat;
    formas.Next;
  end;

  if ArredondaDecimais(ParcelaN_VLR_PAR.AsCurrency,2) <> ArredondaDecimais(ValorTotal,2) then
    if Confirmacao(' O Valor da parcela é igual a ' + FormatFloat(Varia.MascaraMoeda,ParcelaN_VLR_PAR.AsCurrency) +
                   ' -> valor digitado  = ' + FormatFloat(varia.MascaraMoeda,ValorTotal) + ',  você deseja corrigir ?' ) then
       result := false;
end;


procedure TFFormaPagtoCR1.GFormasExit(Sender: TObject);
begin
  if not ValidaTotalVariasFormas then
    GFormas.SetFocus;
end;

procedure TFFormaPagtoCR1.ParcelaBeforePost(DataSet: TDataSet);
begin
  ParcelaD_ULT_ALT.AsDateTime := date;
  if CadFrmPagI_COD_SIT.AsInteger <> 0 then
    ParcelaI_COD_SIT.AsInteger := CadFrmPagI_COD_SIT.AsInteger;
end;

procedure TFFormaPagtoCR1.EdcFormaPgtoSelect(Sender: TObject);
begin
  EdcFormaPgto.ASelectLocaliza.clear;
  EdcFormaPgto.ASelectLocaliza.Add(' Select * from dba.CadFormasPagamento ' +
                                   ' Where C_nom_Frm like ''@%'' ' +
                                   ' and c_fla_bcr <> ''U'' and c_fla_tip <> ''T'' ' +
                                   ' and c_fla_tip <> ''H'' and c_fla_tip <> ''E'' ' +
                                   ' and c_fla_tip <> ''A'' and c_fla_tip <> ''S'' ' +
                                   ' and c_fla_tip <> ''V'' and c_fla_tip <> ''B'' ' );
  EdcFormaPgto.ASelectValida.clear;
  EdcFormaPgto.ASelectValida.Add(' Select * from dba.CadFormasPagamento ' +
                                   ' Where I_Cod_Frm = @ ' +
                                   ' and c_fla_bcr <> ''U'' and c_fla_tip <> ''T'' ' +
                                   ' and c_fla_tip <> ''H'' and c_fla_tip <> ''E'' ' +
                                   ' and c_fla_tip <> ''A'' and c_fla_tip <> ''S'' ' +
                                   ' and c_fla_tip <> ''V'' and c_fla_tip <> ''B'' ' );

    if (ConfigModulos.Caixa) then
    begin
      EdcFormaPgto.ASelectLocaliza.add(' and C_FLA_BCR = ''C'' ' );
      EdcFormaPgto.ASelectValida.add(' and C_FLA_BCR = ''C'' ');
    end;

    if CadFrmPagC_FLA_TIP.AsString[1] = 'R' then // cheques terceiros
    begin
      EdcFormaPgto.ASelectLocaliza.add(' and C_FLA_TIP = ''R'' ' );
      EdcFormaPgto.ASelectValida.add(' and C_FLA_TIP = ''R'' ');
    end;

end;

procedure TFFormaPagtoCR1.GFormasEnter(Sender: TObject);
begin
  EdcFormaPgtoSelect(nil);
end;


Initialization
 RegisterClasses([TFFormaPagtoCR1]);
end.

