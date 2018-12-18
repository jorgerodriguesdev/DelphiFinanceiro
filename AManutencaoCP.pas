unit AManutencaoCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Localizacao, Db, DBTables, ComCtrls, Componentes1, ExtCtrls,
  PainelGradiente, Mask, UnContasAPagar, UnBancario, numericos;

type
  TFManutencaoCP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelPor: TPanelColor;
    SpeedButton1: TSpeedButton;
    EDuplicata: TEditLocaliza;
    MovContasAPagar: TQuery;
    DataMovContasapagar: TDataSource;
    Localiza: TConsultaPadrao;
    PanelFecha: TPanelColor;
    BFecha: TBitBtn;
    CadContaapagar: TQuery;
    DataCadContaapagar: TDataSource;
    BCancela: TBitBtn;
    BExclui: TBitBtn;
    Label5: TLabel;
    ENota: TEditLocaliza;
    Label18: TLabel;
    SpeedButton3: TSpeedButton;
    MovContasAPagarI_EMP_FIL: TIntegerField;
    MovContasAPagarI_LAN_APG: TIntegerField;
    MovContasAPagarI_NRO_PAR: TIntegerField;
    MovContasAPagarC_NRO_CON: TStringField;
    MovContasAPagarI_LAN_BAC: TIntegerField;
    MovContasAPagarC_NRO_DUP: TStringField;
    MovContasAPagarD_DAT_VEN: TDateField;
    MovContasAPagarN_VLR_DUP: TFloatField;
    MovContasAPagarD_DAT_PAG: TDateField;
    MovContasAPagarN_VLR_PAG: TFloatField;
    MovContasAPagarN_VLR_DES: TFloatField;
    MovContasAPagarN_PER_JUR: TFloatField;
    MovContasAPagarN_PER_MOR: TFloatField;
    MovContasAPagarN_PER_MUL: TFloatField;
    MovContasAPagarI_COD_USU: TIntegerField;
    MovContasAPagarN_VLR_ACR: TFloatField;
    MovContasAPagarN_PER_DES: TFloatField;
    MovContasAPagarC_NRO_DOC: TStringField;
    MovContasAPagarN_VLR_JUR: TFloatField;
    MovContasAPagarN_VLR_MOR: TFloatField;
    MovContasAPagarN_VLR_MUL: TFloatField;
    MovContasAPagarI_COD_FRM: TIntegerField;
    MovContasAPagarD_CHE_VEN: TDateField;
    MovContasAPagarC_BAI_BAN: TStringField;
    MovContasAPagarC_FLA_PAR: TStringField;
    MovContasAPagarL_OBS_APG: TMemoField;
    MovContasAPagarI_PAR_FIL: TIntegerField;
    MovContasAPagarC_DUP_CAN: TStringField;
    Aux: TQuery;
    BEstornar: TBitBtn;
    BExcuiTitulo: TBitBtn;
    Tempo: TPainelTempo;
    CadContaapagarI_LAN_APG: TIntegerField;
    CadContaapagarI_EMP_FIL: TIntegerField;
    CadContaapagarI_COD_CLI: TIntegerField;
    CadContaapagarI_NRO_NOT: TIntegerField;
    CadContaapagarI_COD_DES: TIntegerField;
    CadContaapagarD_DAT_MOV: TDateField;
    CadContaapagarD_DAT_EMI: TDateField;
    CadContaapagarN_VLR_TOT: TFloatField;
    CadContaapagarI_QTD_PAR: TIntegerField;
    CadContaapagarI_COD_USU: TIntegerField;
    CadContaapagarC_PAT_FOT: TStringField;
    CadContaapagarN_VLR_MOR: TFloatField;
    CadContaapagarN_VLR_JUR: TFloatField;
    CadContaapagarI_SEQ_NOT: TIntegerField;
    CadContaapagarC_CLA_PLA: TStringField;
    CadContaapagarI_COD_EMP: TIntegerField;
    CadContaapagarC_FLA_DES: TStringField;
    Label1: TLabel;
    EOrdem: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    BBAjuda: TBitBtn;
    MovContasAPagarC_FLA_CHE: TStringField;
    BPagamento: TBitBtn;
    CadContaapagarI_LAN_REC: TIntegerField;
    CadContaapagarI_PAR_REC: TIntegerField;
    CadContaapagarN_VLR_REC: TFloatField;
    Fundo: TPanelColor;
    PanelFiltro: TPanelColor;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    ECliente: TDBEditLocaliza;
    EPlano: TDBEditNumerico;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    GradeMov: TGridIndice;
    MObs: TDBMemoColor;
    PanelColor4: TPanelColor;
    MovContasAPagarD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDuplicataSelect(Sender: TObject);
    procedure EDuplicataRetorno(Retorno1, Retorno2: String);
    procedure BCancelaClick(Sender: TObject);
    procedure ENotaSelect(Sender: TObject);
    procedure ENotaRetorno(Retorno1, Retorno2: String);
    procedure BFechaClick(Sender: TObject);
    procedure BExcluiClick(Sender: TObject);
    procedure MovContasAPagarAfterPost(DataSet: TDataSet);
    procedure CadContaapagarAfterInsert(DataSet: TDataSet);
    procedure BEstornarClick(Sender: TObject);
    procedure BExcuiTituloClick(Sender: TObject);
    procedure MovContasAPagarAfterScroll(DataSet: TDataSet);
    procedure MovContasAPagarBeforeInsert(DataSet: TDataSet);
    procedure EOrdemSelect(Sender: TObject);
    procedure EOrdemRetorno(Retorno1, Retorno2: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure GradeMovExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CamposExit(Sender: TObject);
    procedure GradeMovEditButtonClick(Sender: TObject);
    procedure AlteraFormaPagto;
    procedure AbreTransacao;
    procedure CommitTransacao;
    procedure RollbackTransacao;
    procedure GradeMovKeyPress(Sender: TObject; var Key: Char);
    procedure EOrdemEnter(Sender: TObject);
    procedure EOrdemExit(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure MovContasAPagarBeforePost(DataSet: TDataSet);
  private
    VprBaixaBanco: Boolean;
    CP : TFuncoesContasAPagar;
  public
    procedure CarregaConta( lancamento : integer);
  end;

var
  FManutencaoCP: TFManutencaoCP;

implementation

{$R *.DFM}

uses
  Constantes, fundata, funstring, funsql, APrincipal, ConstMsg,
  APlanoConta, ABaixaContasPagar, funObjeto,
  AFormaPagtoCP;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoCP.FormCreate(Sender: TObject);
begin
  CP := TFuncoesContasAPagar.criar(self,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RollbackTransacao;
  CP.Destroy;
  CadContaapagar.close;
  MovContasAPagar.close;
  aux.close;
  Action := CaFree;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      processos dos  botoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********************** excluir conta *************************************** }
procedure TFManutencaoCP.BExcluiClick(Sender: TObject);
begin
  if (not MovContasAPagar.EOF) then
    if Confirmacao(CT_ExcluiConta) then
    begin
       AbreTransacao;
       if CP.ExcluiConta( CadContaAPagar.FieldByName('I_LAN_APG').AsInteger, varia.CodigoEmpFil, true, true ) then
       begin
          AtualizaSQLTabela(CadContaapagar);
          AtualizaSQLTabela(MovContasAPagar);
       end;
       CommitTransacao;
    end;
end;

{**************** excluir titulo ******************************************** }
procedure TFManutencaoCP.BExcuiTituloClick(Sender: TObject);
begin
  if Confirmacao(CT_ExcluiTitulos) then
  begin
     AbreTransacao;
     if CP.ExcluiTitulo(MovContasAPagar.fieldByName('i_lan_apg').AsInteger,MovContasAPagar.fieldByName('i_nro_par').AsInteger) then
      begin
        AtualizaSQLTabela(CadContaapagar);
        AtualizaSQLTabela(MovContasAPagar);
      end;
      CommitTransacao;
     end;
end;

{********************* baixar conta ****************************************** }
procedure TFManutencaoCP.BEstornarClick(Sender: TObject);
begin
  if Confirmacao(CT_EstornarTitulo) then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando Baixa ... ');
    CP.EstornaParcela( MovContasAPagarI_LAN_APG.AsInteger,MovContasAPagarI_LAN_BAC.AsInteger, MovContasAPagarI_NRO_PAR.AsInteger, MovContasAPagarI_PAR_FIL.AsInteger,
                       CadContaapagarI_COD_CLI.AsInteger,
                       MovContasAPagarD_DAT_VEN.AsDateTime, MovContasAPagarC_FLA_PAR.AsString, true);
    AtualizaSQLTabela(MovContasAPagar);
    Tempo.Fecha;
    CommitTransacao;
  end;
end;

{**************** cancela titulo ********************************************* }
procedure TFManutencaoCP.BCancelaClick(Sender: TObject);
begin
  if Confirmacao(CT_CancelarTitulo) then
  begin
     AbreTransacao;
    if CP.CancelaTitulo(MovContasAPagar.fieldByName('i_lan_apg').AsInteger,MovContasAPagar.fieldByName('i_nro_par').AsInteger) then
    begin
      AtualizaSQLTabela(CadContaapagar);
      AtualizaSQLTabela(MovContasAPagar);
    end;
    CommitTransacao;
  end;  
end;

{*************** pagamento de uma conta ************************************** }
procedure TFManutencaoCP.BPagamentoClick(Sender: TObject);
begin
  FEfetuarBaixaPagar := TFEfetuarBaixaPagar.CriarSDI(application,'',true); //verificar a permissão na versão original;
  if FEfetuarBaixaPagar.BaixaParcela(MovContasAPagarI_LAN_APG.AsInteger, MovContasAPagarI_NRO_PAR.AsInteger, MovContasAPagarD_DAT_VEN.AsDateTime) then
  begin
    FEfetuarBaixaPagar.ShowModal;
    AtualizaSQLTabela(CadContaapagar);
    AtualizaSQLTabela(MovContasAPagar);
  end
  else
    FEfetuarBaixaPagar.Close;
end;

{********************* fecha o formulario *********************************** }
procedure TFManutencaoCP.BFechaClick(Sender: TObject);
begin
  if CadContaapagar.State in [dsEdit, dsInsert ] then
    CadContaapagar.Post;
  if MovContasAPagar.State in [dsEdit, dsInsert ] then
    MovContasAPagar.Post;
  Close;
end;

{************************** help ******************************************** }
procedure TFManutencaoCP.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FManutencaoCP.HelpContext);
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      localiza conta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{***************** chamda externa para carregar uma conta ******************* }
procedure TFManutencaoCP.CarregaConta( lancamento : integer);
begin
  fundo.Visible := true;
  VerificaAtesGravar(CadContaapagar);
  VerificaAtesGravar(MovContasAPagar);
  CP.LocalizaContaCP(CadContaapagar, lancamento);
  CP.LocalizaParcelasComParciais(MovContasapagar, lancamento );
  EditarReg(CadContaapagar);
  ECliente.Atualiza;
  EPlanoExit(self);
end;

{********************* localiza duplicata ************************************ }
procedure TFManutencaoCP.EDuplicataSelect(Sender: TObject);
begin
  EDuplicata.ASelectLocaliza.Clear;
  EDuplicata.ASelectLocaliza.Add(' select * from MovContasaPagar as MCP key join CadContasaPagar as CCP, CadClientes as Cli where ' +
                                 ' MCP.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                                 ' and CCP.i_cod_cli = Cli.i_cod_cli ' +
                                 ' and  MCP.c_nro_dup like ''@%''');
  EDuplicata.ASelectValida.Clear;
  EDuplicata.ASelectValida.Add(' select * from MovContasaPagar as MCP key join CadContasaPagar as CCP, CadClientes as Cli where ' +
                               ' MCP.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                               ' and CCP.i_cod_cli = Cli.i_cod_cli ' +
                               ' and  MCP.c_nro_dup = ''@''');
end;

{*************** retorno da duplicata *************************************** }
procedure TFManutencaoCP.EDuplicataRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(StrToInt(retorno1));
end;

{********************* localiza nota **************************************** }
procedure TFManutencaoCP.ENotaSelect(Sender: TObject);
begin
  ENota.ASelectValida.Clear;
  ENota.ASelectValida.Add(' select C.c_nom_CLI, cp.I_LAN_APG from dba.CadContasaPagar  as CP, dba.CadClientes as C '+
                          ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                          ' and I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                          ' and CP.I_NRO_NOT = @');
  ENota.ASelectLocaliza.Clear;
  ENota.ASelectLocaliza.Add(' Select CP.I_LAN_APG, CP.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI from '+
                            ' CadContasaPagar as CP, CadClientes as C '+
                            ' where CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                            ' and CP.I_COD_CLI = C.I_COD_CLI and I_NRO_NOT like ''@%''' +
                            ' and not CP.I_NRO_NOT is null ');
end;

{*********************** retorno da nota ************************************* }
procedure TFManutencaoCP.ENotaRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(StrToInt(retorno1));
end;

{****************** localiza ordem ******************************************* }
procedure TFManutencaoCP.EOrdemSelect(Sender: TObject);
begin
  EOrdem.ASelectValida.Clear;
  EOrdem.ASelectValida.Add(' Select CP.I_EMP_FIL, CP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT ' +
                           ' from CadContasAPagar CP, CadClientes C ' +
                           ' where   ' +
                           ' CP.I_LAN_APG = @ ' +
                           ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                           ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                           ' ORDER BY I_LAN_APG ');
  EOrdem.ASelectLocaliza.Clear;
  EOrdem.ASelectLocaliza.Add(' Select CP.I_EMP_FIL,CP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT  ' +
                             ' from CadContasAPagar CP, CadClientes C ' +
                             ' where ' +
                             ' C.C_NOM_CLI like ''@%'''  +
                             ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                             ' and C.C_TIP_CAD <> ''C''' +
                             ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                             ' ORDER BY I_LAN_APG ');
end;

{******************* retorno do Ordem *************************************** }
procedure TFManutencaoCP.EOrdemRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(StrToInt(retorno1));
end;

procedure TFManutencaoCP.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  if not (CadContaapagar.State in [dsInsert, dsEdit]) then
    CadContaapagar.Edit;
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.Field.AsString := VpfCodigo;
  if (CadContaAPagar.State in [dsInsert, dsEdit]) then
    CadContaAPagar.Post;
end;

procedure TFManutencaoCP.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

procedure TFManutencaoCP.CamposExit(Sender: TObject);
begin
  if (CadContaAPagar.State in [dsInsert, dsEdit]) then
    CadContaAPagar.Post;
  if CadContaAPagar.Active then
    CadContaAPagar.Edit;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      acoes das tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFManutencaoCP.MovContasAPagarAfterPost(DataSet: TDataSet);
begin
  cp.AtualizaValorTotal(MovContasAPagar.fieldByName('i_lan_apg').AsInteger);
  AtualizaSQLTabela(CadContaapagar);
end;

procedure TFManutencaoCP.CadContaapagarAfterInsert(DataSet: TDataSet);
begin
  CadContaapagar.Cancel;
end;

procedure TFManutencaoCP.MovContasAPagarAfterScroll(DataSet: TDataSet);
begin
  BExclui.Enabled := (MovContasAPagarC_DUP_CAN.AsString <> 'S') and (MovContasAPagarN_VLR_PAG.AsFloat = 0 ) and (not MovContasAPagar.EOF);
  BExcuiTitulo.Enabled := (MovContasAPagarC_DUP_CAN.AsString <> 'S') and (MovContasAPagarN_VLR_PAG.AsFloat = 0 ) and (not MovContasAPagar.EOF);
  BEstornar.Enabled := (MovContasAPagarC_DUP_CAN.AsString <> 'S') and (MovContasAPagarN_VLR_PAG.AsFloat <> 0 ) and (not MovContasAPagar.EOF);
  BCancela.Enabled := (MovContasAPagarC_DUP_CAN.AsString <> 'S') and (MovContasAPagarN_VLR_PAG.AsFloat = 0 ) and  (not MovContasAPagar.EOF);
  BPagamento.Enabled := (MovContasAPagarC_DUP_CAN.AsString <> 'S') and (MovContasAPagarD_DAT_PAG.AsFloat = 0 ) and (not MovContasAPagar.EOF);
  GradeMov.ReadOnly := MovContasAPagarN_VLR_PAG.AsFloat <> 0;
end;

procedure TFManutencaoCP.MovContasAPagarBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFManutencaoCP.GradeMovExit(Sender: TObject);
begin
  if (MovContasAPagar.State = dsEdit) then
    MovContasAPagar.Post;
end;

procedure TFManutencaoCP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 115) and (CadContaapagar.Active) then // F4.
  begin
    if PossuiFoco(PanelPor) then
      ECliente.SetFocus
    else
      if PossuiFoco(PanelFiltro) then
        GradeMov.SetFocus
      else
        if PossuiFoco(GradeMov) then
          BExclui.SetFocus
        else
          EOrdem.SetFocus;
  end
  else
    if Key = 116 then // F5.
    begin
      ENota.Clear;
      EDuplicata.Clear;
      EOrdem.Clear;
      if CadContaaPagar.State in [ dsEdit, dsInsert ] then
        CadContaaPagar.post;
      if MovContasAPagar.State in [ dsEdit, dsInsert ] then
        MovContasAPagar.post;
      FechaTabela(CadContaapagar);
      FechaTabela(MovContasAPagar);
      case Varia.ConsultaPor of
        'O' : EOrdem.SetFocus;
        'D' : EDuplicata.SetFocus;
        'N' : ENota.SetFocus;
      end;
      Fundo.Visible := false;
    end
    else
      if Key = 117 then // F6.
        AlteraFormaPagto;
end;


procedure TFManutencaoCP.GradeMovEditButtonClick(Sender: TObject);
begin
  if GradeMov.SelectedIndex = 4 then
     AlteraFormaPagto;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        altera forma pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{**************** altera a forma de pagamento ****************************** }
procedure TFManutencaoCP.AlteraFormaPagto;
var
  FormaInicio, FormaFim : Integer;
  NroConta : string;
begin
  if not CadContaaPagar.eof then
    if CP.PermiteAlterarFormaPagto( MovContasAPagarI_LAN_BAC.AsInteger ) then
    begin
      if (MovContasAPagarn_vlr_pag.AsCurrency = 0) and (MovContasAPagarC_DUP_CAN.AsString <> 'S') then
      begin
        CP.EstornaCaixaFormaPagamento(MovContasAPagarI_COD_FRM.AsInteger,
                                      CadContaaPagarI_LAN_APG.AsInteger,
                                      MovContasAPagarI_NRO_PAR.AsInteger,
                                      CadContaaPagarI_cod_cli.asinteger,
                                      MovContasAPagarN_VLR_DUP.AsCurrency);
        FormaInicio := MovContasAPagarI_COD_FRM.AsInteger;
        NroConta := MovContasAPagarC_NRO_CON.AsString;  // guarda o nro da conta, para se cheque, poder cancelar
        FFormaPagtoCP := TFFormaPagtoCP.CriarSDI(application, '', true);
        FormaFim := FFormaPagtoCP.FormaPagamentoParcela( CadContaaPagarI_LAN_APG.AsInteger, MovContasAPagarI_NRO_PAR.AsInteger,
                                                        MovContasAPagarI_COD_FRM.AsInteger, MovContasApagarN_VLR_DUP.AsCurrency);
        cp.ConfiguraFormaPagto(FormaInicio, FormaFim, MovContasAPagarI_LAN_APG.AsInteger, MovContasAPagarI_NRO_PAR.AsInteger, NroConta);
        AtualizaSQLTabela(MovContasAPagar);
        CP.LancaItemCaixaFormaPagamento(MovContasAPagarI_COD_FRM.AsInteger,
                                        CadContaaPagarI_LAN_APG.AsInteger,
                                        MovContasAPagarI_NRO_PAR.AsInteger,
                                        CadContaaPagarI_cod_cli.asinteger,
                                        CadContaaPagarI_NRO_NOT.asinteger,
                                        CadContaaPagarD_DAT_EMI.asDatetime,
                                        MovContasAPagarN_VLR_DUP.AsCurrency);
      end
      else
        Aviso(CT_ContaPagaCancelada);
    end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            transacoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFManutencaoCP.AbreTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;

  if not FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.StartTransaction;
end;

procedure TFManutencaoCP.CommitTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Commit;
end;

procedure TFManutencaoCP.RollbackTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Rollback;
end;




procedure TFManutencaoCP.GradeMovKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    key := ',';
end;

procedure TFManutencaoCP.EOrdemEnter(Sender: TObject);
begin
  if CadContaapagar.State in [dsEdit, dsInsert ] then
    CadContaapagar.Post;
  if MovContasAPagar.State in [dsEdit, dsInsert ] then
    MovContasAPagar.Post;
  ENota.Clear;
  EDuplicata.Clear;
  EOrdem.Clear;
end;

procedure TFManutencaoCP.EOrdemExit(Sender: TObject);
begin
  MovContasAPagarAfterScroll(nil);
  if (EOrdem.Text <> '') or (EDuplicata.Text <> '' ) or (ENota.text <> '' ) then
    fundo.Visible := true;
end;

procedure TFManutencaoCP.SpeedButton5Click(Sender: TObject);
begin
  if not (CadContaapagar.State in [dsInsert, dsEdit]) then
    CadContaapagar.Edit;
  ECliente.AAbreLocalizacao;
  if (CadContaAPagar.State in [dsInsert, dsEdit]) then
    CadContaAPagar.Post;
end;

procedure TFManutencaoCP.MovContasAPagarBeforePost(DataSet: TDataSet);
begin
  MovContasAPagarD_ULT_ALT.AsDateTime := date;
end;

Initialization
  RegisterClasses([TFManutencaoCP]);
end.
