unit ABaixaContasPagar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Mask, DBCtrls, Tabela, Componentes1,
  Db, DBTables, Buttons, Grids, DBGrids, Localizacao, numericos,
  UnContasaPagar, DBKeyViolation, UnImpressao;

type
  TFEfetuarBaixaPagar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Baixa: TQuery;
    DataBaixa: TDataSource;
    BaixaI_EMP_FIL: TIntegerField;
    BaixaI_LAN_APG: TIntegerField;
    BaixaI_NRO_PAR: TIntegerField;
    BaixaC_NRO_DUP: TStringField;
    BaixaD_DAT_VEN: TDateField;
    BaixaN_VLR_DUP: TFloatField;
    BaixaD_DAT_PAG: TDateField;
    BaixaN_PER_JUR: TFloatField;
    BaixaN_VLR_DES: TFloatField;
    BaixaN_VLR_PAG: TFloatField;
    BaixaI_COD_USU: TIntegerField;
    BaixaN_PER_MOR: TFloatField;
    BaixaN_PER_DES: TFloatField;
    BaixaN_VLR_ACR: TFloatField;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Painel: TPanelColor;
    Grade: TDBGridColor;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label2: TLabel;
    BVerifica: TBitBtn;
    VerificaCapaLote: TCheckBox;
    BOK: TBitBtn;
    BCancela: TBitBtn;
    Localiza: TConsultaPadrao;
    Numerico1: TNumerico;
    BaixaN_VLR_JUR: TFloatField;
    BaixaN_VLR_MOR: TFloatField;
    BaixaC_NRO_DOC: TStringField;
    BaixaN_PER_MUL: TFloatField;
    BaixaN_VLR_MUL: TFloatField;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    DBText8: TDBText;
    Label5: TLabel;
    DBText1: TDBText;
    Label3: TLabel;
    DBText2: TDBText;
    Label6: TLabel;
    DBText3: TDBText;
    Label7: TLabel;
    DBText4: TDBText;
    Label21: TLabel;
    DBText11: TDBText;
    Label9: TLabel;
    DBText6: TDBText;
    Label13: TLabel;
    DBText5: TDBText;
    Label24: TLabel;
    DBText12: TDBText;
    DBText13: TDBText;
    DBText10: TDBText;
    DBText9: TDBText;
    Label14: TLabel;
    DBText7: TDBText;
    PainelBaixa: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    EData: TMaskEditColor;
    Label15: TLabel;
    Label11: TLabel;
    BaixaI_COD_FRM: TIntegerField;
    BaixaC_NRO_CON: TStringField;
    BaixaD_CHE_VEN: TDateField;
    BaixaI_LAN_BAC: TIntegerField;
    BaixarPor: TRadioGroup;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    EditLocaliza2: TEditLocaliza;
    Label18: TLabel;
    EditLocaliza1: TEditLocaliza;
    Label30: TLabel;
    EditLocaliza3: TEditLocaliza;
    GGGGGG: TLabel;
    LFornecedores: TLabel;
    BaixaC_FLA_PAR: TStringField;
    BaixaL_OBS_APG: TMemoField;
    Label27: TLabel;
    LBanco: TLabel;
    Label23: TLabel;
    LDias: TLabel;
    Label33: TLabel;
    DBText14: TDBText;
    Label12: TLabel;
    Edesconto: Tnumerico;
    eacrescimo: Tnumerico;
    EValor: TNumerico;
    BaixaI_PAR_FIL: TIntegerField;
    MObservacao: TMemoColor;
    BaixaC_BAI_BAN: TStringField;
    BaixaC_DUP_CAN: TStringField;
    PTempo: TPainelTempo;
    ValidaGravacao: TValidaGravacao;
    BBAjuda: TBitBtn;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label19: TLabel;
    BaixaI_COD_MOE: TIntegerField;
    Label4: TLabel;
    CImprimirCheque: TComboBoxColor;
    Label20: TLabel;
    EformaPgto: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label28: TLabel;
    cadBaixa: TQuery;
    cadBaixaI_LAN_APG: TIntegerField;
    cadBaixaI_EMP_FIL: TIntegerField;
    cadBaixaI_COD_CLI: TIntegerField;
    cadBaixaC_CLA_PLA: TStringField;
    cadBaixaC_FLA_DES: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelaClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BVerificaClick(Sender: TObject);
    procedure VerificaCapaLoteClick(Sender: TObject);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEditColor9Exit(Sender: TObject);
    procedure EditLocaliza1Select(Sender: TObject);
    procedure EditLocaliza2Select(Sender: TObject);
    procedure Numerico1Change(Sender: TObject);
    procedure EditLocaliza3Select(Sender: TObject);
    procedure EDataExit(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditLocaliza2Retorno(Retorno1, Retorno2: String);
    procedure EditLocaliza1Retorno(Retorno1, Retorno2: String);
    procedure EditLocaliza3Retorno(Retorno1, Retorno2: String);
    procedure EditLocaliza1Enter(Sender: TObject);
    procedure EformaPgtoRetorno(Retorno1, Retorno2: String);
    procedure EValorChange(Sender: TObject);
    procedure EformaPgtoSelect(Sender: TObject);
  private
    CP : TFuncoesContasAPagar;
    DataAlteracao : TDateTime;
    FecharFormulario : Boolean;
    ValorParcela : Double;
    TipoFrmPagto : string;
    FlagFormaPagto : string;
    procedure InicializaBaixa;
    function CarregaBaixaParcela( numeroLancamento, numeroparcela : integer) : Boolean;
    procedure CalculaValores;
    procedure LimpaCampos;
    procedure PosicionaConsulta;
    procedure FocaCampo;
  public
    function BaixaParcela( numeroLancamento : integer; numeroParcela : integer; DataPagamento : TDateTime) : Boolean;
  end;

var
  FEfetuarBaixaPagar: TFEfetuarBaixaPagar;

implementation

uses constantes, APrincipal, constMsg, fundata,
  funstring, funsql, funNumeros, UnMoedas, UnClassesImprimir;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              Processos Geral
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFEfetuarBaixaPagar.FormCreate(Sender: TObject);
begin
  CP := TFuncoesContasAPagar.criar(self,fprincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  VerificaCapaLote.Checked := config.CapaLote;
  if not config.PermitirParcial then
    EValor.Enabled := false;
  FecharFormulario := false; // para fechar quando for chamada externa
  case Varia.ConsultaPor of
    'N' : BaixarPor.ItemIndex := 0;
    'O' : BaixarPor.ItemIndex := 1;
    'D' : BaixarPor.ItemIndex := 2;
  end;
  EformaPgtoSelect(EformaPgto);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEfetuarBaixaPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  cp.Destroy;
  FechaTabela(Baixa);
  cadBaixa.close;
  Action := CaFree;
end;

{ ******************** calcula o valor dos juros ***************************** }
procedure TFEfetuarBaixaPagar.CalculaValores;
var
  multa, mora, juro, desconto : double;
  uni : string;
  Moedas : TFuncoesMoedas;
begin
  ValorParcela := baixaN_VLR_DUP.AsCurrency;

  MObservacao.Lines.Clear;
  MObservacao.Lines.Add(BaixaL_OBS_APG.AsString);
  Edata.Text := DateToStr(date);
  EformaPgto.Text := BaixaI_COD_FRM.AsString;
  EformaPgto.Atualiza;

  // verifica moeda e converte para o pagamento
  if BaixaI_cod_moe.AsInteger <> varia.MoedaBase then
  begin
     Moedas := TFuncoesMoedas.criar(self, FPrincipal.BaseDados);
     ValorParcela := Moedas.ConverteValorParaMoedaBase(uni, BaixaI_COD_MOE.AsInteger, date, baixaN_VLR_DUP.AsCurrency);
     MObservacao.Lines.Text := MObservacao.Lines.Text +  '  - Valor original ' + uni + ' ' + FormatFloat(varia.MascaraValor, baixaN_VLR_DUP.AsCurrency);
     Moedas.Free;
  end;

  LDias.Caption := InTToStr(CP.CalculaJuros( multa,mora,juro,desconto,BaixaD_DAT_VEN.AsDateTime,date,BaixaI_LAN_APG.AsInteger,BaixaI_NRO_PAR.AsInteger));

  Eacrescimo.Avalor := multa + mora + juro;
  Edesconto.AValor := desconto;
  EValor.AValor := ValorParcela + multa + mora +  Juro - desconto;
end;

{******************** inicializa baixa ************************************** }
procedure TFEfetuarBaixaPagar.InicializaBaixa;
begin
  CalculaValores;
  FocaCampo;
  CImprimirCheque.ItemIndex := 1; // Não.
end;

{******************* carrega a baixa da parcela ***************************** }
function TFEfetuarBaixaPagar.CarregaBaixaParcela( numeroLancamento, numeroparcela : integer) : Boolean;
begin
  Result := true;

  if numeroparcela <> 0 then
    CP.LocalizaParcelaAberta(Baixa,numerolancamento, numeroparcela)
  else
    CP.LocalizaParcelasAbertas(Baixa,numerolancamento,'D_DAT_VEN');

  CP.LocalizaContaCP(cadBaixa, numeroLancamento);

  if not baixa.Eof then
  begin
    if ContaRegistro(baixa) > 1 then
    begin
      Painel.Visible := true;
      Grade.SetFocus;
    end
    else
      InicializaBaixa;
  end
  else
  begin
    aviso(CT_TodaParcelasPagas);
    result := false;
  end;
end;

{ *************** chamada externa para a baixa de parcelas ******************* }
function TFEfetuarBaixaPagar.BaixaParcela( numeroLancamento : integer; numeroParcela : integer; DataPagamento : TDateTime) : Boolean;
begin
  FecharFormulario := true;
  Result := true;
  CarregaBaixaParcela(numeroLancamento, numeroParcela)
end;

{ *********** posiciona o cursor de acordo com a consulta escolhida ********* }
procedure TFEfetuarBaixaPagar.PosicionaConsulta;
begin
  case BaixarPor.ItemIndex of
    0 : EditLocaliza1.SetFocus;
    1 : EditLocaliza2.SetFocus;
    2 : EditLocaliza3.SetFocus;
  end;
end;

{ ********************* limpa os campos do formulario *********************** }
procedure TFEfetuarBaixaPagar.LimpaCampos;
begin
  EditLocaliza1.Limpa;
  EditLocaliza2.Limpa;
  EditLocaliza3.Limpa;
  LDias.Caption := '';
  LBanco.Caption := '';
  LFornecedores.Caption := '';
  Edata.Text := DateToStr(date);
  Eacrescimo.AValor := 0;
  Edesconto.AValor := 0;
  EValor.AValor := 0;
  EformaPgto.Text := '';
  EformaPgto.Atualiza;
  MObservacao.clear;
  Baixa.close;
  BOk.Default := false;
  Bcancela.Cancel := false;
end;

{***************** Foca o componente para o usuario ************************** }
procedure TFEfetuarBaixaPagar.FocaCampo;
begin
  if self.Visible then
    Edesconto.SetFocus;
end;

{ ********* calcula o valor total a ser pago *********************************}
procedure TFEfetuarBaixaPagar.DBEditColor9Exit(Sender: TObject);
begin
 if (self.Visible) Then
   EValor.AValor := ValorParcela + Eacrescimo.AValor  - Edesconto.AValor;
end;

{ ******** verifica da da baixa se menor para, de acordo com as config gerais *}
procedure TFEfetuarBaixaPagar.EDataExit(Sender: TObject);
begin
{  if not ValidaDataRetroativa(StrToDate(Edata.Text)) then
    if Edata.Enabled then
      Edata.SetFocus;}
end;

{  ***************** reinicia consula *************************************** }
procedure TFEfetuarBaixaPagar.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then    // F5
    BitBtn4Click(Sender);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Chamadas das Localizas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******** localiza por notas ************************************************}
procedure TFEfetuarBaixaPagar.EditLocaliza1Select(Sender: TObject);
begin
  EditLocaliza1.ASelectValida.Clear;
  EditLocaliza1.ASelectValida.Add(' select C.c_nom_CLI, cp.I_LAN_APG from dba.CadContasaPagar  as CP key join MovContasAPagar as MCP, dba.CadClientes as C '+
                                  ' where ' +
                                  ' CP.I_NRO_NOT = @ ' +
                                  ' and MCP.D_DAT_PAG is null ' +
                                  ' and isnull(MCP.C_DUP_CAN, ''N'') = ''N'' ' +
                                  ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                                  ' and CP.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) );
  EditLocaliza1.ASelectLocaliza.Clear;
  EditLocaliza1.ASelectLocaliza.Add(' Select CP.I_LAN_APG, CP.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI from '+
                                    ' CadContasaPagar as CP key join MovContasAPagar as MCP, CadClientes as C '+
                                    ' where ' +
                                    ' c.c_nom_CLI like ''@%''' +
                                    ' and not CP.I_NRO_NOT is null ' +
                                    ' and MCP.D_DAT_PAG is null ' +
                                    ' and isnull(MCP.C_DUP_CAN, ''N'') = ''N'' ' +
                                    ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                    ' and CP.I_COD_CLI = C.I_COD_CLI ');
end;

{ *********************** localiza por lancamento *****************************}
procedure TFEfetuarBaixaPagar.EditLocaliza2Select(Sender: TObject);
begin
  Editlocaliza2.ASelectValida.Clear;
  EditLocaliza2.ASelectValida.Add(' Select CP.I_EMP_FIL,CP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT ' +
                                  ' from CadContasAPagar as CP key join MovContasAPagar as MCP, CadClientes as C' +
                                  ' where   ' +
                                  ' CP.I_LAN_APG = @ ' +
                                  ' and MCP.D_DAT_PAG is null ' +
                                  ' and isnull(MCP.C_DUP_CAN, ''N'') = ''N'' ' +
                                  ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                                  ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil)  );
  Editlocaliza2.ASelectLocaliza.Clear;
  EditLocaliza2.ASelectLocaliza.Add(' Select CP.I_EMP_FIL,CP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT  ' +
                                    ' from CadContasAPagar as CP key join MovContasAPagar as MCP, CadClientes as C' +
                                    ' where ' +
                                    ' C.C_NOM_CLI like ''@%'''  +
                                    ' and isnull(MCP.C_DUP_CAN, ''N'') = ''N'' ' +
                                    ' and MCP.D_DAT_PAG is null ' +
                                    ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                                    ' and C.C_TIP_CAD <> ''C''' +
                                    ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) );
end;

procedure TFEfetuarBaixaPagar.EditLocaliza3Select(Sender: TObject);
begin
  Editlocaliza3.ASelectValida.Clear;
  EditLocaliza3.ASelectValida.Add(' Select MCP.I_EMP_FIL,MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                                  ' from MovContasaPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                                  ' where ' +
                                  ' MCP.C_NRO_DUP = ''@''' +
                                  ' and MCP.D_DAT_PAG is null ' +
                                  ' and isnull(MCP.C_DUP_CAN, ''N'') = ''N'' ' +
                                  ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                                  ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil));
  Editlocaliza3.ASelectLocaliza.Clear;
  EditLocaliza3.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL,MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_DUP, MCP.I_NRO_PAR ' +
                                    ' from MovContasaPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                                    ' where ' +
                                    ' MCP.C_NRO_DUP like ''@%''' +
                                    ' and MCP.D_DAT_PAG is null ' +
                                    ' and isnull(MCP.C_DUP_CAN, ''N'') = ''N'' ' +
                                    ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                                    ' and C.C_TIP_CAD <> ''C''' +
                                    ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) );
end;

{****************** limpa campos da baixa ********************************** }
procedure TFEfetuarBaixaPagar.EditLocaliza1Enter(Sender: TObject);
begin
  LimpaCampos;
end;

{********************* retorno da ordem de recebimento ********************** }
procedure TFEfetuarBaixaPagar.EditLocaliza2Retorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
  begin
    EditLocaliza1.Clear;
    EditLocaliza3.Clear;
    CarregaBaixaParcela(StrToInt(Retorno1),0);
  end;
end;

{****************** retorno da nota **************************************** }
procedure TFEfetuarBaixaPagar.EditLocaliza1Retorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
  begin
    EditLocaliza2.Clear;
    EditLocaliza3.Clear;
    CarregaBaixaParcela(StrToInt(Retorno1), 0);
  end;
end;

{******************* retorno da duplicata *********************************** }
procedure TFEfetuarBaixaPagar.EditLocaliza3Retorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
  begin
    EditLocaliza1.Clear;
    EditLocaliza2.Clear;
    CarregaBaixaParcela(StrToInt(Retorno1), 0);
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Processos da grade
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** ok da grade de escolha de parcelas ************************ }
procedure TFEfetuarBaixaPagar.BitBtn4Click(Sender: TObject);
begin
  painel.Visible := false;
  FocaCampo;
  BOk.Default := true;
  BCancela.Cancel := true;
  InicializaBaixa;
end;

{****************** cancela da grade escolha ******************************** }
procedure TFEfetuarBaixaPagar.BitBtn3Click(Sender: TObject);
begin
  EditLocaliza2.Enabled := true;
  EDitLocaliza2.SetFocus;
  Painel.Visible := false;
  FechaTabela(Baixa);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
               chamadas dos Botoes formulario
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************* cancela a baixa **************************************** }
procedure TFEfetuarBaixaPagar.BCancelaClick(Sender: TObject);
begin
  Posicionaconsulta;
end;

{*************** confirma a baixa ******************************************** }
procedure TFEfetuarBaixaPagar.BOKClick(Sender: TObject);
var
  Dados : TDadosBaixaCP;
  uni : string;
  laco : integer;
begin
  try
    if not FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.StartTransaction;

      Dados := TDadosBaixaCP.Create;
      Dados.LancamentoCP := BaixaI_LAN_APG.AsInteger;
      Dados.NroParcela := BaixaI_NRO_PAR.AsInteger;
      Dados.CodUsuario := varia.CodigoUsuario;
      Dados.CodMoedaAtual := BaixaI_COD_MOE.AsInteger;
      Dados.DataPagamento := StrToDate(Edata.Text);
      Dados.ValorDesconto := Edesconto.AValor;
      Dados.valorAcrescimo := Eacrescimo.AValor;
      Dados.ValorPago := EValor.AValor;
      try       // limpa espacos em banco
        for laco := 0 to MObservacao.Lines.Count - 1 do
         if trim(MObservacao.Lines.Strings[laco]) = '' then
           MObservacao.Lines.Delete(laco);
      except
      end;
      Dados.Observacao := MObservacao.Lines.Text;
      Dados.VerificarCaixa := config.Baixa_CR_CP_Caixa;
      Dados.TipoFrmPagto := TipoFRMPagto;
      dados.CodFormaPAgamento := strToInt(EformaPgto.text);
      dados.VerficarFormaPagamento := true;
      dados.VerificaBanco := true;
      dados.TrocoCaixa := 0;
      dados.FlagDespesaFixa := cadBaixaC_FLA_DES.AsString;
      dados.PlanoConta := cadBaixaC_CLA_PLA.AsString;
      dados.ValorTotalAserPago := ValorParcela +  Dados.valorAcrescimo - Dados.ValorDesconto;

      if CP.BaixaContaAPagar( dados ) then
      begin
        if VerificaCapaLote.Checked then
          numerico1.AValor := numerico1.AValor + EValor.AValor;
        LimpaCampos;
        Dados.Free;
        if FPrincipal.BaseDados.InTransaction then
          FPrincipal.BaseDados.commit;
      end
      else
      begin
         if FPrincipal.BaseDados.InTransaction then
          FPrincipal.BaseDados.Rollback;
      end;
    except
      aviso(CT_BaixaInvalida);
      if FPrincipal.BaseDados.InTransaction then
        FPrincipal.BaseDados.Rollback;
    end;

    if FecharFormulario then  // caso chamada externa
      self.close
end;

{**************** quando fecha a formulario ******************************** }
procedure TFEfetuarBaixaPagar.BitBtn1Click(Sender: TObject);
begin
  if Numerico1.AValor <> 0  then
   Aviso(CT_VerificaCapaLote)
  else
   FEfetuarBaixaPagar.Close;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Capa de Lote
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********** verifica a capa de lote *************************************** }
procedure TFEfetuarBaixaPagar.BVerificaClick(Sender: TObject);
begin
  numerico1.AValor := 0;
  BVerifica.Kind := bkOk;
  BVerifica.Default := false;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := 'Ok';
end;

{************** aciona a verificacao do capa de lote ************************ }
procedure TFEfetuarBaixaPagar.VerificaCapaLoteClick(Sender: TObject);
begin
  if VerificaCapaLote.Checked then
  begin
    BVerifica.Enabled := true;
    label2.Enabled := true;
    Numerico1.Enabled := true;
  end
  else
  begin
    BVerifica.Enabled := false;
    label2.Enabled := false;
    Numerico1.Enabled := false;
  end;
  if self.Visible then
    BCancela.Click;
end;

{************** quando alterar o valor do capa de lote *********************** }
procedure TFEfetuarBaixaPagar.Numerico1Change(Sender: TObject);
begin
  BVerifica.Kind := bkNo;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := '&Verificar';
end;

{************************* help ********************************************* }
procedure TFEfetuarBaixaPagar.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FEfetuarBaixaPagar.HelpContext);
end;

{**************** reinicializa a baixa ************************************* }
procedure TFEfetuarBaixaPagar.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = 116 then // F5.
  begin
    LimpaCampos;
    PosicionaConsulta;
  end;
end;


procedure TFEfetuarBaixaPagar.EformaPgtoRetorno(Retorno1,
  Retorno2: String);
begin
  if (retorno1 <> '') then
  begin
    FlagFormaPagto := retorno1;
    TipoFrmPagto := retorno2;
  end;
end;

procedure TFEfetuarBaixaPagar.EValorChange(Sender: TObject);
begin
  ValidaGravacao.execute;
  if EformaPgto.Text = '' then
    BOK.Enabled := false;
end;

procedure TFEfetuarBaixaPagar.EformaPgtoSelect(Sender: TObject);
begin
  EformaPgto.ASelectLocaliza.Clear;
  EformaPgto.ASelectLocaliza.Add(' Select * from dba.CadFormasPagamento ' +
                                 ' Where C_nom_Frm like ''@%'' '  +
                                 ' and C_FLA_BCP <> ''U'' ');


  EformaPgto.ASelectValida.Clear;
  EformaPgto.ASelectValida.Add(' Select * from dba.CadFormasPagamento ' +
                               ' Where I_Cod_Frm = @  ' +
                               ' and C_FLA_BCP <> ''U'' ');

  if (ConfigModulos.Caixa) and (not Config.PermiteBaixarCPsemCaixa) then
  begin
    EformaPgto.ASelectLocaliza.Add(' and (C_FLA_BCP = ''B'' or C_FLA_BCP = ''C'') ');
    EformaPgto.ASelectValida.Add(' and (C_FLA_BCP = ''B'' or C_FLA_BCP = ''C'') ');
  end;
end;

initialization
  RegisterClasses([TFEfetuarBaixaPagar]);
end.
