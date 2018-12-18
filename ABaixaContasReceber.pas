unit ABaixaContasReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Mask, DBCtrls, Tabela, Componentes1,
  Db, DBTables, Buttons, Grids, DBGrids, Localizacao, numericos, UncontasaReceber,
  UnBancario, DBKeyViolation;

type
  TFEfetuarBaixaReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Baixa: TQuery;
    DataBaixa: TDataSource;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    BVerifica: TBitBtn;
    VerificaCapaLote: TCheckBox;
    BOK: TBitBtn;
    BCancela: TBitBtn;
    Localiza: TConsultaPadrao;
    Numerico1: TNumerico;
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
    Label9: TLabel;
    DBText6: TDBText;
    Label13: TLabel;
    DBText5: TDBText;
    Label24: TLabel;
    DBText12: TDBText;
    PainelBaixa: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    Edata: TMaskEditColor;
    Label15: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    PanelColor3: TPanelColor;
    LClientes: TLabel;
    BaixaI_EMP_FIL: TIntegerField;
    BaixaI_LAN_REC: TIntegerField;
    BaixaI_NRO_PAR: TIntegerField;
    BaixaI_COD_FRM: TIntegerField;
    BaixaD_DAT_VEN: TDateField;
    BaixaD_DAT_PAG: TDateField;
    BaixaN_VLR_PAR: TFloatField;
    BaixaN_VLR_DES: TFloatField;
    BaixaN_VLR_ACR: TFloatField;
    BaixaN_VLR_PAG: TFloatField;
    BaixaN_PER_MOR: TFloatField;
    BaixaN_PER_JUR: TFloatField;
    BaixaN_PER_MUL: TFloatField;
    BaixaI_COD_USU: TIntegerField;
    BaixaC_NRO_DUP: TStringField;
    BaixaN_DES_VEN: TFloatField;
    Label23: TLabel;
    DBText7: TDBText;
    Label12: TLabel;
    BaixaL_OBS_REC: TMemoField;
    BaixaC_FLA_PAR: TStringField;
    Edesconto: Tnumerico;
    Eacrescimo: Tnumerico;
    EValor: TNumerico;
    BaixaI_PAR_FIL: TIntegerField;
    BaixaI_DIA_CAR: TIntegerField;
    BaixaI_PAR_MAE: TIntegerField;
    BaixaN_PER_ACR: TFloatField;
    BaixaN_PER_DES: TFloatField;
    BaixaC_DUP_CAN: TStringField;
    PTempo: TPainelTempo;
    Label31: TLabel;
    EAdicionais: TNumerico;
    BaixaN_VLR_ADI: TFloatField;
    BAdicionais: TSpeedButton;
    BBAjuda: TBitBtn;
    BaixaI_COD_SIT: TIntegerField;
    Label21: TLabel;
    EformaPgto: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label28: TLabel;
    BaixaI_COD_MOE: TIntegerField;
    ValidaGravacao: TValidaGravacao;
    MObservacao: TMemoColor;
    Label4: TLabel;
    Ldias: TLabel;
    PanelColor5: TPanelColor;
    PanelColor4: TPanelColor;
    Label1: TLabel;
    Label18: TLabel;
    Label30: TLabel;
    Label14: TLabel;
    DBGridColor1: TDBGridColor;
    EOrdRec: Tnumerico;
    Enota: Tnumerico;
    Edup: TEditColor;
    EBol: TEditColor;
    Consulta: TQuery;
    DataConsulta: TDataSource;
    ConsultaI_LAN_REC: TIntegerField;
    ConsultaI_EMP_FIL: TIntegerField;
    ConsultaI_COD_CLI: TIntegerField;
    ConsultaI_NRO_PAR: TIntegerField;
    ConsultaI_COD_FRM: TIntegerField;
    ConsultaD_DAT_VEN: TDateField;
    ConsultaN_VLR_PAR: TFloatField;
    ConsultaC_NOM_CLI: TStringField;
    ConsultaC_NRO_DUP: TStringField;
    ConsultaI_NRO_NOT: TIntegerField;
    PainelMat: TPanelColor;
    Label17: TLabel;
    Econtrato: Tnumerico;
    ConsultaC_CLA_PLA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOKClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BVerificaClick(Sender: TObject);
    procedure VerificaCapaLoteClick(Sender: TObject);
    procedure Numerico1Change(Sender: TObject);
    procedure EdataExit(Sender: TObject);
    procedure EdescontoExit(Sender: TObject);
    procedure BAdicionaisClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure EformaPgtoRetorno(Retorno1, Retorno2: String);
    procedure EformaPgtoChange(Sender: TObject);
    procedure EOrdRecExit(Sender: TObject);
    procedure ConsultaAfterScroll(DataSet: TDataSet);
    procedure BCancelaClick(Sender: TObject);
    procedure EformaPgtoSelect(Sender: TObject);
  private
    DataAlteracao : TDateTime;
    CR : TFuncoesContasAReceber;
    FecharFormulario : Boolean;
    ValorParcela : double;
    TipoFRMPagto, PlanoConta : string;
    procedure CarregaConsulta;
    procedure CarregaBaixaParcela( numeroLancamento, numeroparcela : integer);
    procedure CalculaValores;
    procedure LimpaCampos;
    procedure FocaCampo;
  public
    function BaixaParcela( numeroLancamento : integer; numeroParcela : integer; DataPagamento : TDateTime; PlanoConta : string) : Boolean;
  end;

var
  FEfetuarBaixaReceber: TFEfetuarBaixaReceber;

implementation

uses constantes, APrincipal, constMsg, fundata, funNumeros,
     funstring, funsql, AAdicionais, UnMoedas;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  formulario
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFEfetuarBaixaReceber.FormCreate(Sender: TObject);
begin
  if ConfigModulos.Academico then
  begin
     PainelMat.Visible := true;
     DBGridColor1.Columns[3].FieldName := 'i_cod_mat';
     DBGridColor1.Columns[3].Title.Caption := 'Contrato';
     DBGridColor1.Columns[2].Title.Caption := 'Aluno';
  end;
//  ESerie.text := varia.SerieNota;
  Edata.EditMask := FPrincipal.CorFoco.AMascaraData;
  CR := TFuncoesContasAReceber.criar(self, FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  VerificaCapaLote.Checked := config.CapaLote;
  if not config.PermitirParcial then
    EValor.Enabled := false;
  FecharFormulario := false; // para fechar quando for chamada externa
  EformaPgtoSelect(EformaPgto);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEfetuarBaixaReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  CR.Destroy;
  FechaTabela(Baixa);
  Action := CaFree;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Consulta da Baixa
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************** gera consulta das baixas **********************}
procedure TFEfetuarBaixaReceber.CarregaConsulta;
begin
  if DBGridColor1.Enabled and DBGridColor1.Visible then
    DBGridColor1.SetFocus;

  LimpaSQLTabela(consulta);
  AdicionaSQLTabela(consulta, ' Select * from CadContasaReceber cad, movcontasareceber mov ' +
                              ' ,cadclientes cli, movforma frm, cadformaspagamento pag ' +
                              ' where cad.i_emp_fil =  ' + inttostr(varia.CodigoEmpFil) +
                              ' and mov.n_vlr_pag is null ' );
  if EOrdRec.AValor <> 0 then
    AdicionaSQLTabela(consulta, ' and cad.i_lan_rec = ' + EOrdRec.text );

  if Enota.AValor <> 0 then
    AdicionaSQLTabela(consulta, ' and cad.i_nro_not = ' + ENota.text );

  if Edup.Text <> '' then
    AdicionaSQLTabela(consulta, ' and mov.c_nro_dup = ''' + Edup.text + '''' );

  if EBol.Text <> '' then
    AdicionaSQLTabela(consulta, ' and pag.c_fla_tip = ''B'' and frm.c_nro_doc = ''' + EBol.text + '''');

 if Econtrato.AValor <> 0 then
    AdicionaSQLTabela(consulta, ' and cad.i_cod_mat = ' + Econtrato.text );

  AdicionaSQLTabela(consulta, ' and cad.i_emp_fil = mov.i_emp_fil ' +
                              ' and cad.i_lan_rec = mov.i_lan_rec ' +
                              ' and cad.i_cod_cli = cli.i_cod_cli ' +
                              ' and mov.i_emp_fil = frm.i_emp_fil ' +
                              ' and mov.i_lan_rec = frm.i_lan_rec ' +
                              ' and mov.i_nro_par = frm.i_nro_par ' +
                              ' and frm.i_cod_frm = pag.i_cod_frm ' +
                              ' order by mov.i_nro_par ');
  if (EBol.Text <> '')  or (Edup.Text <> '') or (Enota.AValor <> 0) or (EOrdRec.AValor <> 0) or (Econtrato.AValor <> 0) then
    consulta.open;
  PlanoConta := ConsultaC_CLA_PLA.AsString;
end;


procedure TFEfetuarBaixaReceber.EOrdRecExit(Sender: TObject);
begin
  CarregaConsulta;
end;


procedure TFEfetuarBaixaReceber.ConsultaAfterScroll(DataSet: TDataSet);
begin
  if DBGridColor1.Focused then
    CarregaBaixaParcela(ConsultaI_LAN_REC.AsInteger, ConsultaI_NRO_PAR.AsInteger);
end;


{ *************** chamada externa para a baixa de parcelas ******************* }
function TFEfetuarBaixaReceber.BaixaParcela( numeroLancamento : integer; numeroParcela : integer;
                                             DataPagamento : TDateTime; PlanoConta : string ) : Boolean;
begin
  FecharFormulario := true;
  PanelColor3.Visible := false;
  Self.WindowState := wsNormal;
  self.Height := Self.Height - PanelColor3.Height;
  self.Width := 790;
  Result := true;
  self.PlanoConta := PlanoConta;
  if CR.ValidaParcelaPagamento(Numerolancamento, datapagamento) then
    CarregaBaixaParcela(numeroLancamento, numeroParcela)
  else
    result := false;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Montagem da Baixa
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************* carrega a baixa da parcela ***************************** }
procedure TFEfetuarBaixaReceber.CarregaBaixaParcela( numeroLancamento, numeroparcela : integer);
begin
  if numeroparcela <> 0 then
  begin
     CR.LocalizaParcelaAberta(Baixa,numerolancamento, numeroparcela);
     CR.IgualarValoresAdicionais(BaixaI_LAN_REC.AsInteger, BaixaI_NRO_PAR.AsInteger);
     CalculaValores;
  end;
end;

{ ******************** calcula o valor dos juros ***************************** }
procedure TFEfetuarBaixaReceber.CalculaValores;
var
  multa, mora, juro, desconto : double;
  Moedas : TFuncoesMoedas;
  uni : string;
begin
  ValorParcela := baixaN_VLR_PAR.AsCurrency;

  MObservacao.Lines.Clear;
  MObservacao.Lines.Add(BaixaL_OBS_REC.AsString);
  Edata.Text := DateToStr(date);
  EformaPgto.Text := BaixaI_COD_FRM.AsString;
  EformaPgto.Atualiza;

  // verifica moeda e converte para o pagamento
  if BaixaI_cod_moe.AsInteger <> varia.MoedaBase then
  begin
     Moedas := TFuncoesMoedas.criar(self, FPrincipal.BaseDados);
     ValorParcela := Moedas.ConverteValorParaMoedaBase(uni, BaixaI_COD_MOE.AsInteger, date, baixaN_VLR_PAR.AsCurrency);
     MObservacao.Lines.Text := MObservacao.Lines.Text +  '  - Valor original ' + uni + ' ' + FormatFloat(varia.MascaraValor, baixaN_VLR_PAR.AsCurrency);
     Moedas.Free;
  end;

  multa := BaixaN_PER_MUL.AsCurrency;
  mora := BaixaN_PER_MOR.AsCurrency;
  juro := BaixaN_PER_JUR.AsCurrency;
  desconto := BaixaN_DES_VEN.AsCurrency;

  LDias.Caption := InTToStr(CR.CalculaJuros( multa, mora, juro, desconto,
                                             BaixaD_DAT_VEN.AsDateTime, date,
                                             ValorParcela ));
  EAdicionais.AValor := BaixaN_VLR_ADI.AsCurrency;
  Eacrescimo.Avalor := multa + mora + juro + BaixaN_VLR_ACR.AsCurrency;
  Edesconto.AValor := desconto + BaixaN_VLR_DES.AsCurrency;
  EValor.AValor := ValorParcela + BaixaN_VLR_ADI.AsCurrency + Eacrescimo.Avalor - Edesconto.AValor;
end;

{**************** calcula adicionais **************************************** }
procedure TFEfetuarBaixaReceber.BAdicionaisClick(Sender: TObject);
begin
  FAdicionais := TFAdicionais.CriarSDI(self,'', FPrincipal.VerificaPermisao('FAdicionais'));
  if FAdicionais.CarregaAdicional( BaixaI_LAN_REC.AsInteger, BaixaI_NRO_PAR.AsInteger) > 0 then // Soma os valores novamente, pois provavelmente foram alterados.
    EAdicionais.AValor := CR.SomaValorReceber( BaixaI_LAN_REC.AsInteger, BaixaI_NRO_PAR.AsInteger)
  else
    EAdicionais.AValor := 0;
end;

{ ********************* limpa os campos do formulario *********************** }
procedure TFEfetuarBaixaReceber.LimpaCampos;
begin
  BAdicionais.Enabled := False;
  LDias.Caption := '';
  LClientes.Caption := '';
  Edata.Text := DateToStr(date);
  EAdicionais.AValor := 0;
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
procedure TFEfetuarBaixaReceber.FocaCampo;
begin
  if self.Visible then
    Edesconto.SetFocus;
end;

{ ********* calcula o valor total a ser pago *********************************}
procedure TFEfetuarBaixaReceber.EdescontoExit(Sender: TObject);
begin
 if (self.Visible) Then
   EValor.AValor := ValorParcela + Eacrescimo.AValor + EAdicionais.AValor - Edesconto.AValor;
end;

{ ******** verifica da da baixa se menor para, de acordo com as config gerais *}
procedure TFEfetuarBaixaReceber.EdataExit(Sender: TObject);
begin
  if (config.DataBaixaMenor) then
  begin
    if StrToDate(Edata.Text) < date then
    begin
      aviso(CT_DataMenorBAixa);
      if edata.Enabled then
        Edata.SetFocus;
    end;
  end;

  if not ValidaDataRetroativa(StrToDate(Edata.Text)) then
    if edata.Enabled then
      Edata.SetFocus;
end;

{*************** confirma a baixa ******************************************** }
procedure TFEfetuarBaixaReceber.BOKClick(Sender: TObject);
var
  Dados : TDadosBaixaCR;
  laco : integer;
begin
  if CR.ValidaParcelaPagamento(BaixaI_LAN_REC.AsInteger, BaixaD_DAT_VEN.AsDateTime) then
  begin
    try
      if not FPrincipal.BaseDados.InTransaction then
        FPrincipal.BaseDados.StartTransaction;

      Dados := TDadosBaixaCR.Create;
      Dados.LancamentoCR := BaixaI_LAN_REC.AsInteger;
      Dados.NroParcela := BaixaI_NRO_PAR.AsInteger;
      Dados.CodUsuario := varia.CodigoUsuario;
      Dados.NroParcelaMae := BaixaI_PAR_MAE.AsInteger;
      Dados.CodMoedaAtual := BaixaI_COD_MOE.AsInteger;
      Dados.DataPagamento := StrToDate(Edata.Text);
      Dados.ValorAdicionais := EAdicionais.AValor;
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
      Dados.LancarBanco := true;
      dados.planoConta := PlanoConta;
      dados.CodFormaPAgamento := strToInt(EformaPgto.text);
      dados.VerficarFormaPagamento := true;
      dados.ValorTotalAserPago := ValorParcela +  Dados.valorAcrescimo - Dados.ValorDesconto + Dados.ValorAdicionais;
      dados.TrocoCaixa := 0;
      if config.JurosMultaDoDia then
      begin
         Dados.Mora := varia.Mora;
         Dados.Juro := varia.Juro;
         Dados.Multa := varia.Multa;
      end
      else
      begin
         Dados.multa := BaixaN_PER_MUL.AsCurrency;
         Dados.mora := BaixaN_PER_MOR.AsCurrency;
         Dados.juro := BaixaN_PER_JUR.AsCurrency;
      end;


      if CR.BaixaContaAReceber( dados ) then
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
    else
      CarregaConsulta;
  end;

end;

{**************** quando fecha a formulario ******************************** }
procedure TFEfetuarBaixaReceber.BitBtn1Click(Sender: TObject);
begin
  if Numerico1.AValor <> 0 then
    Aviso(CT_VerificaCapaLote)
  else
    self.Close;
end;

{*************************** guarda o tipo de forma de pagamento ************ }
procedure TFEfetuarBaixaReceber.EformaPgtoRetorno(Retorno1, Retorno2: String);
begin
  if (retorno1 <> '') then
    TipoFrmPagto := retorno2;
end;

{*************** quando digita a forma de pagamento ************************** }
procedure TFEfetuarBaixaReceber.EformaPgtoChange(Sender: TObject);
begin
  ValidaGravacao.execute;
  if EformaPgto.Text = '' then
    BOK.Enabled := false;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Capa de Lote
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{********** verifica a capa de lote *************************************** }
procedure TFEfetuarBaixaReceber.BVerificaClick(Sender: TObject);
begin
  numerico1.AValor := 0;
  BVerifica.Kind := bkOk;
  BVerifica.Default := false;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := 'Ok';
end;

{************** aciona a verificacao do capa de lote ************************ }
procedure TFEfetuarBaixaReceber.VerificaCapaLoteClick(Sender: TObject);
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
procedure TFEfetuarBaixaReceber.Numerico1Change(Sender: TObject);
begin
  BVerifica.Kind := bkNo;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := '&Verificar';
end;

{************************* help ********************************************* }
procedure TFEfetuarBaixaReceber.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FEfetuarBaixaReceber.HelpContext);
end;


procedure TFEfetuarBaixaReceber.BCancelaClick(Sender: TObject);
begin
  baixa.Cancel;
  self.close;
end;

procedure TFEfetuarBaixaReceber.EformaPgtoSelect(Sender: TObject);
begin
  EformaPgto.ASelectLocaliza.Clear;
  EformaPgto.ASelectLocaliza.Add(' Select * from dba.CadFormasPagamento ' +
                                 ' Where C_nom_Frm like ''@%'' '  +
                                 ' and C_FLA_BCR <> ''U'' ');


  EformaPgto.ASelectValida.Clear;
  EformaPgto.ASelectValida.Add(' Select * from dba.CadFormasPagamento ' +
                               ' Where I_Cod_Frm = @  ' +
                               ' and C_FLA_BCR <> ''U'' ');

  if (ConfigModulos.Caixa) and (not Config.PermiteBaixarCRsemCaixa) then
  begin
    EformaPgto.ASelectLocaliza.Add(' and (C_FLA_BCR = ''B'' or C_FLA_BCR = ''C'') ');
    EformaPgto.ASelectValida.Add(' and (C_FLA_BCR = ''B'' or C_FLA_BCR = ''C'') ');
  end;
end;

initialization
  RegisterClasses([TFEfetuarBaixaReceber]);
end.

