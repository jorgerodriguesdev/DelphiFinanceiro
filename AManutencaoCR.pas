unit AManutencaoCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Localizacao, Db, DBTables, ComCtrls, Componentes1, ExtCtrls,
  PainelGradiente, Mask, UnContasAReceber, UnBancario, numericos;

type
  TFManutencaoCR = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelPor: TPanelColor;
    SpeedButton1: TSpeedButton;
    EDuplicata: TEditLocaliza;
    MovContasAReceber: TQuery;
    DataMovContasaReceber: TDataSource;
    Localiza: TConsultaPadrao;
    PanelFecha: TPanelColor;
    BFecha: TBitBtn;
    CadContaaReceber: TQuery;
    DataCadContaaReceber: TDataSource;
    BCancela: TBitBtn;
    BExclui: TBitBtn;
    Label5: TLabel;
    ENota: TEditLocaliza;
    Label18: TLabel;
    SpeedButton3: TSpeedButton;
    BEstornaCancelamento: TBitBtn;
    MovContasAReceberI_EMP_FIL: TIntegerField;
    MovContasAReceberI_LAN_REC: TIntegerField;
    MovContasAReceberI_NRO_PAR: TIntegerField;
    MovContasAReceberI_COD_FRM: TIntegerField;
    MovContasAReceberD_DAT_VEN: TDateField;
    MovContasAReceberD_DAT_PAG: TDateField;
    MovContasAReceberN_VLR_PAR: TFloatField;
    MovContasAReceberN_VLR_DES: TFloatField;
    MovContasAReceberN_VLR_ACR: TFloatField;
    MovContasAReceberN_TOT_PAR: TFloatField;
    MovContasAReceberN_VLR_PAG: TFloatField;
    MovContasAReceberN_PER_MOR: TFloatField;
    MovContasAReceberN_PER_JUR: TFloatField;
    MovContasAReceberN_PER_MUL: TFloatField;
    MovContasAReceberN_PER_COR: TFloatField;
    MovContasAReceberI_COD_USU: TIntegerField;
    MovContasAReceberN_VLR_ENT: TFloatField;
    MovContasAReceberC_NRO_DUP: TStringField;
    MovContasAReceberN_DES_VEN: TFloatField;
    MovContasAReceberC_FLA_PAR: TStringField;
    MovContasAReceberL_OBS_REC: TMemoField;
    MovContasAReceberI_PAR_FIL: TIntegerField;
    MovContasAReceberI_PAR_MAE: TIntegerField;
    MovContasAReceberI_DIA_CAR: TIntegerField;
    MovContasAReceberN_PER_ACR: TFloatField;
    MovContasAReceberN_PER_DES: TFloatField;
    MovContasAReceberI_FIL_PAG: TIntegerField;
    MovContasAReceberC_DUP_CAN: TStringField;
    Aux: TQuery;
    BEstornar: TBitBtn;
    tempo: TPainelTempo;
    MovContasAReceberI_LAN_BAC: TIntegerField;
    BExcuiTitulo: TBitBtn;
    CadContaaReceberI_LAN_REC: TIntegerField;
    CadContaaReceberI_COD_PAG: TIntegerField;
    CadContaaReceberI_EMP_FIL: TIntegerField;
    CadContaaReceberI_COD_CLI: TIntegerField;
    CadContaaReceberD_DAT_MOV: TDateField;
    CadContaaReceberN_VLR_TOT: TFloatField;
    CadContaaReceberI_QTD_PAR: TIntegerField;
    CadContaaReceberI_NRO_NOT: TIntegerField;
    CadContaaReceberD_DAT_EMI: TDateField;
    CadContaaReceberI_COD_USU: TIntegerField;
    CadContaaReceberI_ULT_DUP: TIntegerField;
    CadContaaReceberI_SEQ_NOT: TIntegerField;
    CadContaaReceberC_CLA_PLA: TStringField;
    CadContaaReceberI_COD_EMP: TIntegerField;
    Label3: TLabel;
    EOrdem: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    MovContasAReceberN_VLR_ADI: TFloatField;
    BBAjuda: TBitBtn;
    MovContasAReceberC_FLA_CAR: TStringField;
    MovContasAReceberC_FLA_BOL: TStringField;
    MovContasAReceberC_FLA_DUP: TStringField;
    MovContasAReceberI_COD_SIT: TIntegerField;
    MovContasAReceberI_NUM_BOR: TIntegerField;
    BPagamento: TBitBtn;
    Fundo: TPanelColor;
    PanelFiltro: TPanelColor;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    ECliente: TDBEditLocaliza;
    EPlano: TDBEditNumerico;
    DBEditColor1: TDBEditColor;
    Emissao: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    GradeMov: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    PanelColor4: TPanelColor;
    ESerie: TEditColor;
    MovContasAReceberD_ULT_ALT: TDateField;
    BChequeDev: TBitBtn;
    PainelMat: TPanelColor;
    Label6: TLabel;
    SpeedButton4: TSpeedButton;
    EMatricula: TEditLocaliza;
    CadContaaReceberI_COD_MAT: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDuplicataSelect(Sender: TObject);
    procedure EDuplicataRetorno(Retorno1, Retorno2: String);
    procedure BCancelaClick(Sender: TObject);
    procedure ENotaSelect(Sender: TObject);
    procedure ENotaRetorno(Retorno1, Retorno2: String);
    procedure BFechaClick(Sender: TObject);
    procedure BEstornaCancelamentoClick(Sender: TObject);
    procedure BExcluiClick(Sender: TObject);
    procedure MovContasAReceberAfterPost(DataSet: TDataSet);
    procedure CadContaaReceberAfterInsert(DataSet: TDataSet);
    procedure MovContasAReceberAfterScroll(DataSet: TDataSet);
    procedure BEstornarClick(Sender: TObject);
    procedure MovContasAReceberBeforeInsert(DataSet: TDataSet);
    procedure BExcuiTituloClick(Sender: TObject);
    procedure EOrdemSelect(Sender: TObject);
    procedure EOrdemRetorno(Retorno1, Retorno2: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMovExit(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure CamposExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMovEditButtonClick(Sender: TObject);
    procedure MovContasAReceberAfterEdit(DataSet: TDataSet);
    procedure GradeMovKeyPress(Sender: TObject; var Key: Char);
    procedure EOrdemExit(Sender: TObject);
    procedure ENotaEnter(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ESerieExit(Sender: TObject);
    procedure MovContasAReceberBeforePost(DataSet: TDataSet);
    procedure BChequeDevClick(Sender: TObject);
    procedure EmissaoExit(Sender: TObject);
    procedure EMatriculaSelect(Sender: TObject);
  private
    VprBaixaBanco: Boolean;
    CR : TFuncoesContasAReceber;
    DataVencimentoInicio : TDateTime;
    procedure AbreTransacao;
    procedure CommitTransacao;
    procedure RollbackTransacao;
    procedure AlteraFormaPagto;
  public
    procedure CarregaConta(Lancamento: Integer);
  end;

var
  FManutencaoCR: TFManutencaoCR;

implementation

{$R *.DFM}

uses
     constantes, fundata, funstring, funsql, APrincipal, ConstMsg,
  APlanoConta, ABaixaContasReceber, FunObjeto,
  AFormaPagtoCR1, ANovaOperacaoFinanceira;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoCR.FormCreate(Sender: TObject);
begin
//   LabelNome1.ANroNome := varia.TipoNome;
   if ConfigModulos.Academico then
   begin
     PainelMat.Visible := true;
     EDuplicata.AInfo.CampoMostra3 := 'I_COD_MAT';
     EDuplicata.AInfo.Nome3 := 'CONTRATO';
     EOrdem.AInfo.CampoMostra3 := 'I_COD_MAT';
     EOrdem.AInfo.Nome3 := 'CONTRATO';
     ECliente.AInfo.TituloForm := ' Localiza Aluno ';
     DBEditColor1.DataField := 'I_COD_MAT';
     Label8.Caption := 'contrato';
   end;
  CR := TFuncoesContasAReceber.criar(self,FPrincipal.BaseDados);
  if varia.CodigoEmpFil <> varia.CodigoFilCadastro then
  begin
    BExclui.Visible := not config.PermiteAlterarCR;
    BExcuiTitulo.Visible := not config.PermiteAlterarCR;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadContaaReceber.close;
  MovContasAReceber.close;
  Aux.close;
  RollbackTransacao;
  CR.Destroy;
  Action := CaFree;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      processos dos  botoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ******************* exclui uma conta *************************************** }
procedure TFManutencaoCR.BExcluiClick(Sender: TObject);
begin
  if PodeExcluirReg(CadContaaReceberD_DAT_EMI.AsDateTime) then
  begin
    if (not MovContasAReceber.EOF) then
      if Confirmacao(CT_ExcluiConta) then
      begin
         AbreTransacao;
         if CR.ExcluiConta( CadContaaReceber.fieldByName('i_lan_rec').AsInteger, varia.CodigoEmpFil, true, true) then
          begin
             AtualizaSQLTabela(CadContaaReceber);
             AtualizaSQLTabela(MovContasAReceber);
          end;
         CommitTransacao;
      end;
    end;
end;

{ ******************* exclui um titulo *************************************** }
procedure TFManutencaoCR.BExcuiTituloClick(Sender: TObject);
begin
  if PodeExcluirReg(CadContaaReceberD_DAT_EMI.AsDateTime) then
  begin
    if Confirmacao(CT_ExcluiTitulos) then
    begin
        AbreTransacao;
        if CR.ExcluiTitulo(MovContasAReceber.fieldByName('I_LAN_REC').AsInteger, MovContasAReceber.fieldByName('I_NRO_PAR').AsInteger) then
        begin
          AtualizaSQLTabela(CadContaaReceber);
          AtualizaSQLTabela(MovContasAReceber);
        end;
        CommitTransacao;
     end;
   end;  
end;

{ ***************** estorna cancelamento da conta *************************** }
procedure TFManutencaoCR.BEstornaCancelamentoClick(Sender: TObject);
begin
  if Confirmacao(CT_EstornarCancelamento) then
  begin
    AbreTransacao;
    CR.EstornaCancelamentoTitulo(MovContasAReceber.fieldByName('i_lan_rec').AsInteger,MovContasAReceber.fieldByName('i_nro_par').AsInteger);
    AtualizaSQLTabela(CadContaaReceber);
    AtualizaSQLTabela(MovContasAReceber);
    CommitTransacao;
  end;
end;

{*************** estorna titulo pago ************************************** }
procedure TFManutencaoCR.BEstornarClick(Sender: TObject);
begin
  if Confirmacao(CT_EstornarTitulo) then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando Baixa ... ');
    CR.EstornaParcela( MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger,
                      MovContasAReceberI_LAN_BAC.AsInteger,
                      MovContasAReceberI_PAR_FIL.AsInteger,
                      CadContaaReceberI_COD_CLI.AsInteger,MovContasAReceberD_DAT_VEN.AsDateTime,
                      MovContasAReceberC_FLA_PAR.AsString, true);
    AtualizaSQLTabela(MovContasAReceber);
    Tempo.Fecha;
    CommitTransacao;
  end;
end;

{************** pagamento de um titulo ************************************** }
procedure TFManutencaoCR.BPagamentoClick(Sender: TObject);
begin
  FEfetuarBaixaReceber := TFEfetuarBaixaReceber.CriarSDI(application,'',true); //verificar a permissão na versão original;
  if FEfetuarBaixaReceber.BaixaParcela(MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger, MovContasAReceberD_DAT_VEN.AsDateTime, CadContaaReceberC_CLA_PLA.AsString) then
  begin
    FEfetuarBaixaReceber.ShowModal;
    AtualizaSQLTabela(CadContaaReceber);
    AtualizaSQLTabela(MovContasAreceber);
  end
  else
    FEfetuarBaixaReceber.close;
end;

{ ****************** cancela titulo ******************************************}
procedure TFManutencaoCR.BCancelaClick(Sender: TObject);
begin
  if Confirmacao(CT_CancelarTitulo) then
  begin
    AbreTransacao;
    if CR.CancelaTitulo(MovContasAReceber.fieldByName('i_lan_rec').AsInteger,MovContasAReceber.fieldByName('i_nro_par').AsInteger) then
    begin
      AtualizaSQLTabela(CadContaaReceber);
      AtualizaSQLTabela(MovContasAReceber);
    end;
    CommitTransacao;
  end;
end;

{******************* fecha formulario *************************************** }
procedure TFManutencaoCR.BFechaClick(Sender: TObject);
begin
  if CadContaaReceber.State in [dsEdit, dsInsert ] then
    CadContaaReceber.Post;
  if MovContasAReceber.State in [dsEdit, dsInsert ] then
    MovContasAReceber.Post;
  Close;
end;

{******************************** help ************************************** }
procedure TFManutencaoCR.BBAjudaClick(Sender: TObject);
begin
Application.HelpCommand(HELP_CONTEXT,FManutencaoCR.HelpContext);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      localiza conta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************* carrega uma nova conta ******************************** }
procedure TFManutencaoCR.CarregaConta( lancamento : integer);
begin
  Fundo.Visible := true;
  VerificaAtesGravar(CadContaaReceber);
  VerificaAtesGravar(MovContasAReceber);
  CR.LocalizaContaCR( CadContaaReceber, lancamento, varia.CodigoEmpFil);
  CR.LocalizaParcelasComParciais(MovContasaReceber, lancamento );
  EditarReg(CadContaAReceber);
  ECliente.Atualiza;
  EPlanoExit(self);
end;

procedure TFManutencaoCR.EDuplicataSelect(Sender: TObject);
begin
  EDuplicata.ASelectLocaliza.Clear;
  EDuplicata.ASelectLocaliza.Add('select * from MovContasaReceber as MCR key join CadContasaReceber as CCR, CadClientes as Cli where ' +
                                    ' MCR.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                                    ' and CCR.i_cod_cli = Cli.i_cod_cli ' +
                                    ' and  MCR.c_nro_dup like ''@%''');
  EDuplicata.ASelectValida.Clear;
  EDuplicata.ASelectValida.Add('select * from MovContasaReceber as MCR key join CadContasaReceber as CCR, CadClientes as Cli where ' +
                                  ' MCR.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                                  ' and CCR.i_cod_cli = Cli.i_cod_cli ' +
                                  ' and  MCR.c_nro_dup = ''@''');
end;

procedure TFManutencaoCR.EDuplicataRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(StrToInt(retorno1));
end;

procedure TFManutencaoCR.ENotaSelect(Sender: TObject);
begin
  ENota.ASelectValida.Clear;
  ENota.ASelectValida.Add(' select C.c_nom_CLI, CR.i_lan_rec from dba.CadContasaReceber  as CR,' +
                          ' dba.CadClientes as C, cadnotafiscais nf  '+
                          ' where CR.I_COD_CLI = C.I_COD_CLI ' +
                          ' and CR.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                          ' and CR.I_NRO_NOT = @ '  +
                          ' and CR.I_EMP_FIL = NF.I_EMP_FIL ' +
                          ' AND CR.I_SEQ_NOT = NF.I_SEQ_NOT ');
  if ESerie.text <> '' then
    ENota.ASelectValida.Add(' AND NF.C_SER_NOT = ''' + ESerie.text + '''');

  ENota.ASelectLocaliza.Clear;
  ENota.ASelectLocaliza.Add(' select CR.i_lan_rec, CR.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI from '+
                            ' CadContasaReceber as CR, CadClientes as C, cadnotafiscais nf  '+
                            ' where CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                            ' and CR.I_COD_CLI = C.I_COD_CLI and cr.I_NRO_NOT like ''@%''' +
                            ' and not CR.I_NRO_NOT is null ' +
                            ' and CR.I_EMP_FIL = NF.I_EMP_FIL ' +
                            ' AND CR.I_SEQ_NOT = NF.I_SEQ_NOT ');
  if ESerie.text <> '' then
    ENota.ASelectLocaliza.Add(' AND NF.C_SER_NOT = ''' + ESerie.text + '''');

end;


procedure TFManutencaoCR.ENotaRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(StrToInt(retorno1));
end;

procedure TFManutencaoCR.EOrdemSelect(Sender: TObject);
begin
  EOrdem.ASelectValida.Clear;
  EOrdem.ASelectValida.Add(' Select CR.I_EMP_FIL, CR.I_LAN_REC, C.C_NOM_CLI, CR.I_NRO_NOT, CR.I_COD_MAT ' +
                           ' from   CadContasAReceber CR, CadClientes C' +
                           ' where  CR.I_COD_CLI = C.I_COD_CLI ' +
                           ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                           ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                           ' and    CR.I_LAN_REC = @ ' +
                           ' ORDER BY I_LAN_REC ');
  EOrdem.ASelectLocaliza.Clear;
  EOrdem.ASelectLocaliza.Add(' Select CR.I_EMP_FIL, CR.I_LAN_REC, C.C_NOM_CLI, CR.I_NRO_NOT, CR.I_COD_MAT ' +
                             ' from   CadContasAReceber as CR, CadClientes  C ' +
                             ' where  CR.I_COD_CLI = C.I_COD_CLI ' +
                             ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                             ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                             ' and    C.C_NOM_CLI like ''@%'' ' +
                             ' ORDER BY I_LAN_REC ');

end;

procedure TFManutencaoCR.EOrdemRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(StrToInt(retorno1));
end;

procedure TFManutencaoCR.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  if not (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Edit;
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
  if (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Post;
end;

procedure TFManutencaoCR.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

procedure TFManutencaoCR.CamposExit(Sender: TObject);
begin
  if (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Post;
  if CadContaaReceber.Active then
  CadContaaReceber.Edit;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      acoes das tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFManutencaoCR.MovContasAReceberAfterEdit(DataSet: TDataSet);
begin
  DataVencimentoInicio := MovContasAReceberD_DAT_VEN.AsDateTime;
end;

procedure TFManutencaoCR.MovContasAReceberAfterPost(DataSet: TDataSet);
begin
  if DataVencimentoInicio <> MovContasAReceberD_DAT_VEN.AsDateTime then
     cr.atualizaVencimentoComissao(MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger, MovContasAReceberD_DAT_VEN.AsDateTime);
  cr.AtualizaValorTotal(MovContasAReceber.fieldByName('i_lan_rec').AsInteger);
  AtualizaSQLTabela(CadContaaReceber);
end;

procedure TFManutencaoCR.CadContaaReceberAfterInsert(DataSet: TDataSet);
begin
  CadContaaReceber.Cancel;
end;

procedure TFManutencaoCR.MovContasAReceberAfterScroll(DataSet: TDataSet);
begin
  BExclui.Enabled := (MovContasAReceberC_DUP_CAN.AsString <> 'S') and (MovContasAReceberN_VLR_PAG.AsFloat = 0 ) and (not MovContasAReceber.EOF);
  BExcuiTitulo.Enabled := (MovContasAReceberC_DUP_CAN.AsString <> 'S') and (MovContasAReceberN_VLR_PAG.AsFloat = 0 ) and (not MovContasAReceber.EOF);
  BEstornaCancelamento.Enabled := (MovContasAReceberC_DUP_CAN.AsString = 'S') and (not MovContasAReceber.EOF);
  BEstornar.Enabled := (MovContasAReceberC_DUP_CAN.AsString <> 'S') and (not MovContasAReceberN_VLR_PAG.isnull ) and (not MovContasAReceber.EOF);
  BChequeDev.Enabled := (MovContasAReceberC_DUP_CAN.AsString <> 'S') and (not MovContasAReceberN_VLR_PAG.isnull ) and (not MovContasAReceber.EOF);
  BCancela.Enabled := (MovContasAReceberC_DUP_CAN.AsString <> 'S') and (MovContasAReceberN_VLR_PAG.AsFloat = 0 ) and  (not MovContasAReceber.EOF);
  BPagamento.Enabled := (MovContasAReceberC_DUP_CAN.AsString <> 'S') and (MovContasAReceberD_DAT_PAG.AsFloat = 0 ) and (not MovContasAReceber.EOF);
  GradeMov.ReadOnly := MovContasAReceberN_VLR_PAG.AsFloat <> 0;
end;

procedure TFManutencaoCR.MovContasAReceberBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


procedure TFManutencaoCR.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 115) and (CadContaAReceber.Active) then // F4.
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
      if CadContaaReceber.State in [ dsEdit, dsInsert ] then
        CadContaaReceber.post;
      if MovContasAReceber.State in [ dsEdit, dsInsert ] then
        MovContasAReceber.post;
      FechaTabela(CadContaAReceber);
      FechaTabela(MovContasAReceber);
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

procedure TFManutencaoCR.GradeMovExit(Sender: TObject);
begin
  if (MovContasaReceber.State = dsEdit) then
     MovContasaReceber.Post;
end;

procedure TFManutencaoCR.GradeMovEditButtonClick(Sender: TObject);
begin
  if GradeMov.SelectedIndex = 3 then
    AlteraFormaPagto;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            transacoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFManutencaoCR.AbreTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;

  if not FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.StartTransaction;
end;

procedure TFManutencaoCR.CommitTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Commit;
end;

procedure TFManutencaoCR.RollbackTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Rollback;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        altera forma pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{**************** altera a forma de pagamento ****************************** }
procedure TFManutencaoCR.AlteraFormaPagto;
var
  formaPgto : integer;
begin
  if not CadContaaReceber.eof then
  begin
    if (MovContasARecebern_vlr_pag.AsCurrency = 0) and (MovContasAReceberC_DUP_CAN.AsString <> 'S') then
    begin
      Cr.EstornaCaixaFormaPagamento(MovContasAReceberI_COD_FRM.AsInteger,
                                    CadContaaReceberI_LAN_REC.AsInteger,
                                    MovContasAReceberI_NRO_PAR.AsInteger,
                                    CadContaaReceberI_cod_cli.asinteger,
                                    MovContasAReceberN_VLR_PAR.AsCurrency);
      FFormaPagtoCR1 := TFFormaPagtoCR1.CriarSDI(application, '', true);
      formaPgto := FFormaPagtoCR1.FormaPagamentoParcela( CadContaaReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger,
                                           MovContasAReceberI_COD_FRM.AsInteger,
                                           MovContasAReceberN_VLR_PAR.AsCurrency,
                                           MovContasAReceberN_VLR_PAR.AsCurrency);
      cr.LocalizaFormaPagamento(aux, formaPgto);
      if aux.fieldByName('C_FLA_BCR').AsString = 'C' then
        Cr.LancaItemCaixaFormaPagamento(formaPgto,
                                        CadContaaReceberI_LAN_REC.AsInteger,
                                        MovContasAReceberI_NRO_PAR.AsInteger,
                                        CadContaaReceberI_cod_cli.asinteger,
                                        CadContaaReceberI_NRO_NOT.asInteger,
                                        CadContaaReceberD_DAT_EMI.asDateTime,
                                        MovContasAReceberN_VLR_PAR.AsCurrency);
      AtualizaSQLTabela(MovContasAReceber);

    end
    else
      Aviso(CT_ContaPagaCancelada);
  end;
end;


procedure TFManutencaoCR.GradeMovKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    key := ',';
end;

procedure TFManutencaoCR.EOrdemExit(Sender: TObject);
begin
  MovContasAReceberAfterScroll(nil);
  if (EOrdem.Text <> '') or (EDuplicata.Text <> '' ) or (ENota.text <> '' ) then
    fundo.Visible := true;
end;

procedure TFManutencaoCR.ENotaEnter(Sender: TObject);
begin
  if CadContaaReceber.State in [dsEdit, dsInsert ] then
    CadContaaReceber.Post;
  if MovContasAReceber.State in [dsEdit, dsInsert ] then
    MovContasAReceber.Post;
  if PainelMat.Visible then
    EMatricula.Clear
  else
    ENota.Clear;
  EDuplicata.Clear;
  EOrdem.Clear;
end;

procedure TFManutencaoCR.SpeedButton5Click(Sender: TObject);
begin
  if not (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Edit;
  ECliente.AAbreLocalizacao;
  if (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Post;
end;

procedure TFManutencaoCR.ESerieExit(Sender: TObject);
begin
  ENota.Text :=  '';
  ENota.SetFocus;
end;

procedure TFManutencaoCR.MovContasAReceberBeforePost(DataSet: TDataSet);
begin
  MovContasAReceberD_ULT_ALT.AsDateTime := date;
  if (config.DataVencimentoMenor) and (MovContasAReceberD_DAT_VEN.AsDateTime <> DataVencimentoInicio) theN
    if (MovContasAReceberD_DAT_VEN.AsDateTime <  date) then
    begin
      Aviso(CT_DataMenorQueAtual);
      MovContasAReceberD_DAT_VEN.AsDateTime := DataVencimentoInicio;
      abort;
    end;
end;

procedure TFManutencaoCR.BChequeDevClick(Sender: TObject);
var
 estornou : Boolean;
begin
  if Confirmacao(CT_EstornarTitulo) then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando Baixa com cheque devolvido ... ');
    estornou := CR.EstornaParcelaChequeDev( MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger,
                      MovContasAReceberI_LAN_BAC.AsInteger,
                      MovContasAReceberI_PAR_FIL.AsInteger,
                      CadContaaReceberI_COD_CLI.AsInteger, MovContasAReceberD_DAT_VEN.AsDateTime,
                      MovContasAReceberC_FLA_PAR.AsString);
    AtualizaSQLTabela(MovContasAReceber);
    Tempo.Fecha;
    CommitTransacao;
    if (ConfigModulos.Bancario) and (estornou) then
    begin
      FNovaOperacaoFinanceira := TFNovaOperacaoFinanceira.CriarSDI(application, '', true);
      FNovaOperacaoFinanceira.Novo.click;
      FNovaOperacaoFinanceira.ShowModal;
    end;
  end;
end;

procedure TFManutencaoCR.EmissaoExit(Sender: TObject);
begin
  if not ValidaDataRetroativa(StrToDate(Emissao.Text)) then
  begin
    if Emissao.Enabled then
      Emissao.SetFocus;
  end
  else
  begin
    if (CadContaaReceber.State in [dsInsert, dsEdit]) then
      CadContaaReceber.Post;
    if CadContaaReceber.Active then
    CadContaaReceber.Edit;
  end;
end;

procedure TFManutencaoCR.EMatriculaSelect(Sender: TObject);
begin
  EMatricula.ASelectValida.Clear;
  EMatricula.ASelectValida.Add(' select C.c_nom_CLI, CR.i_lan_rec, CR.I_COD_MAT from dba.CadContasaReceber  as CR,' +
                          ' dba.CadClientes as C ' +
                          ' where CR.I_COD_CLI = C.I_COD_CLI ' +
                          ' and CR.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                          ' and CR.I_COD_MAT = @ '  );
  EMatricula.ASelectLocaliza.Clear;
  EMatricula.ASelectLocaliza.Add(' select CR.i_lan_rec, CR.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI, CR.I_COD_MAT from '+
                            ' CadContasaReceber as CR, CadClientes as C  '+
                            ' where CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                            ' and CR.I_COD_CLI = C.I_COD_CLI and cr.I_COD_MAT like ''@%''' +
                            ' and not CR.I_COD_MAT is null ');
end;

initialization
  RegisterClasses([TFManutencaoCR]);
end.
