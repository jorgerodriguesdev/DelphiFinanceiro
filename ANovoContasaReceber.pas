unit ANovoContasaReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Db, DBTables, DBCtrls, Buttons, Localizacao,
  Grids, DBGrids,  constantes, Spin, UnContasAReceber, DBKeyViolation,
  StdCtrls, Mask, numericos, BotaoCadastro;

type
  TFNovoContasAReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label3: TLabel;
    Label5: TLabel;
    Emissao: TMaskEditColor;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EFilial: TEditColor;
    ENumeroRecebimento: TEditColor;
    Evalor: TNumerico;
    Label8: TLabel;
    Localiza: TConsultaPadrao;
    Bevel2: TBevel;
    Tempo: TPainelTempo;
    Label9: TLabel;
    VerificaCapaLote: TCheckBox;
    Label11: TLabel;
    Label16: TLabel;
    ECliente: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Numerico1: TNumerico;
    Label21: TLabel;
    EPagamento: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label22: TLabel;
    Label18: TLabel;
    ValorCalcular: Tnumerico;
    EMoedas: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    Label6: TLabel;
    EQuantidadeParcelas: TNumerico;
    ENota: TNumerico;
    ValidaGravacao1: TValidaGravacao;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    EPlano: TEditColor;
    GeraComissao: TComboBoxColor;
    Label23: TLabel;
    BaixaConta: TComboBoxColor;
    Label24: TLabel;
    PComissao: TCorPainelGra;
    PSituacao1: TPanelColor;
    BitBtn7: TBitBtn;
    Label7: TLabel;
    EVendedor: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    EValorCalcularComissao: Tnumerico;
    EPercComissaoVen: Tnumerico;
    Label25: TLabel;
    Label26: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    Label27: TLabel;
    EdcFormaPgto: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label28: TLabel;
    Aux: TQuery;
    Panel1: TPanelColor;
    BotaoGravar1: TBitBtn;
    BotaoCancelar1: TBitBtn;
    BFechar: TBitBtn;
    BNovo: TBitBtn;
    BBAjuda: TBitBtn;
    BImprimir: TBitBtn;
    BVerifica: TBitBtn;
    Label17: TLabel;
    DataBaixa: TMaskEditColor;
    maisvendedores: TBitBtn;
    FrmPagamento: TQuery;
    FrmPagamentoI_COD_FRM: TIntegerField;
    FrmPagamentoC_BAI_CON: TStringField;
    FrmPagamentoC_FLA_BCR: TStringField;
    FrmPagamentoC_FLA_TIP: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure BVerificaClick(Sender: TObject);
    procedure EditColor4Change(Sender: TObject);
    procedure VerificaCapaLoteClick(Sender: TObject);
    procedure EClienteCadastrar(Sender: TObject);
    procedure EPagamentoSelect(Sender: TObject);
    procedure EMoedasRetorno(Retorno1, Retorno2: String);
    procedure EPagamentoRetorno(Retorno1, Retorno2: String);
    procedure EFilialChange(Sender: TObject);
    procedure EPagamentoCadastrar(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure GeraComissaoChange(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
    procedure EVendedorRetorno(Retorno1, Retorno2: String);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure EdcFormaPgtoRetorno(Retorno1, Retorno2: String);
    procedure ENotaExit(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure EmissaoExit(Sender: TObject);
    procedure BaixaContaChange(Sender: TObject);
    procedure DataBaixaExit(Sender: TObject);
    procedure maisvendedoresClick(Sender: TObject);
  private
    capaLote : Double;
    fecharform : boolean;
    CR : TFuncoesContasAReceber;
    UltimoLancamento: Integer;
    TipoFrmPagamento : String;
    LancamentoCR : integer;
    DescontoDoCliente : double; // caso o cliente tenha desconto no seu cadastro, desconto do boleto
    Vendedores : TStringList;
    ValorPro : TstringList;
    PercPro : TstringList;
    ValorSer : TstringList;
    PercSer : TstringList;
    ValorComissaoPro : TStringList;
    ValorComissaoSer : TStringList;
    procedure LimpaCampos;
    function CriaParcelasReceber( var ValorTotal : Double ) : Integer;
  public
    procedure atualizaMascaraValor(Sigla : String);
  end;

var
  FNovoContasAReceber: TFNovoContasAReceber;
implementation

uses ABancos,  ConstMsg,  FunData,   APrincipal, funString, ANovoCliente,
     AMostraParReceber,  funsql, APlanoConta, FunObjeto, ACondicoesPgtos,
  AIncluiMaisVendedores;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Inicializacao do Formulario e destruição
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoContasAReceber.FormCreate(Sender: TObject);
begin
//  LabelNome1.ANroNome := varia.TipoNome;
  if ConfigModulos.Academico then
    ECliente.AInfo.TituloForm := ' Localiza Aluno ';
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  capaLote := 0;
  FecharForm := false;
  VerificaCapaLote.Checked := config.CapaLote;
  if not ConfigModulos.Comissao then // caso naum use comissao
  begin
    EVendedor.ACampoObrigatorio := false;
    label23.Visible := false;
    GeraComissao.Visible := false;
    Label7.Visible := false;
    EVendedor.Visible := false;
    SpeedButton5.Visible := false;
    label12.Visible := false;
  end;
  if not Config.BaixaCRCadastro then
  begin
    BaixaConta.Visible := false;
    Label24.Visible := false;
  end;
  Emissao.EditMask := FPrincipal.CorFoco.AMascaraData;
  DataBaixa.EditMask := FPrincipal.CorFoco.AMascaraData;

  if varia.MaisVendedores then
     maisvendedores.Visible := true
  else
     maisvendedores.Visible := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoContasAReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Aux.close;
  CurrencyString := varia.CifraoMoeda;
  if FIncluiMaisVendedores <> nil then
    FIncluiMaisVendedores.free;
  Action := CaFree;
end;

{******************* na inicializacao do formulario ************************* }
procedure TFNovoContasAReceber.FormShow(Sender: TObject);
begin
    if EMoedas.Enabled then
    EMoedas.SetFocus
  else
    if ECliente.Enabled then
      ECliente.SetFocus
    else
      if ENota.Enabled then
        ENota.SetFocus
      else
        if EPlano.Enabled then
          EPlano.SetFocus;
end;

{*******************permite atualizar os campos relacionados*******************}
procedure TFNovoContasAReceber.LimpaCampos;
begin
  ECliente.Text := '';
  ECliente.Atualiza;
  EPagamento.Text := '';
  EPagamento.Atualiza;
  EMoedas.Text := '';
  ENota.Text := '';
  EQuantidadeParcelas.text := '';
  emoedas.Atualiza;
  EdcFormaPgto.Text := '';
  EdcFormaPgto.Atualiza;
  EPlano.Text := '';
  LPlano.Caption := '';
  ENumeroRecebimento.Text := '';
  ValorCalcular.AValor := 0;
  GeraComissao.ItemIndex := 0;
  EVendedor.Clear;
  EPercComissaoVen.AValor := 0;
  atualizaMascaraValor(varia.CifraoMoeda);
  BaixaConta.ItemIndex := 0;
  DataBaixa.Text := dateTostr(date);      // valida campo data
  AlterarEnabled([BNovo, BotaoGravar1, BotaoCancelar1, BFechar, BImprimir] );
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Validação dos campos relacionados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************* verifica campos obrigatorios ********************************** }
procedure TFNovoContasAReceber.EFilialChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
  if (EdcFormaPgto.Text = '') or (EMoedas.Text = '') or (ECliente.text = '') or
     (EPlano.text = '') or (EPagamento.text = '') then
     BotaoGravar1.Enabled := false;
  if GeraComissao.ItemIndex = 1 then
    if EVendedor.Text = '' then
      BotaoGravar1.Enabled := false;
end;

{******************Cadastro na Consulta do campo Fornecedores******************}
procedure TFNovoContasAReceber.EClienteCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.ShowModal;
  Localiza.AtualizaConsulta;
end;

{*************************** Campos de dados da comissao ******************* }
procedure TFNovoContasAReceber.GeraComissaoChange(Sender: TObject);
begin
  EPercComissaoVen.Enabled := Config.PermiteAlterarPercComissao;
  if GeraComissao.ItemIndex = 1 then // Sim.
  begin
    EVendedor.ACampoObrigatorio := True;
    EVendedor.Enabled  := True;
    EValorCalcularComissao.AValor := ValorCalcular.AValor;
    PComissao.Visible := true;
    EValorCalcularComissao.SetFocus;
  end
  else
  begin
    EVendedor.ACampoObrigatorio := False;
    EVendedor.Enabled := False;
    EVendedor.Clear;
    PComissao.Visible := false;
  end;
  EFilialChange(Sender);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              Botoes de Atividade, novo, alterar, parcelas, etc
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***Quando fechar o formulario verifica o capa de lote e o CadContasaReceber***}
procedure TFNovoContasAReceber.BFecharClick(Sender: TObject);
begin
  if numerico1.AValor <> 0 then
    Aviso(CT_VerificaCapaLote)
  else
    Close;
end;

{**************************adiciona uma nova conta*****************************}
procedure TFNovoContasAReceber.BNovoClick(Sender: TObject);
var
  Sequencial, Filial : integer;
  CR : TFuncoesContasAReceber;
begin
  if VerificaTransacao(7, Sequencial, Filial) then
  begin
     CR := TFuncoesContasAReceber.criar(self, fprincipal.BaseDados);
     CR.ExcluiConta(Sequencial, Filial, false,false);
     CR.free;
     DesmarcaTransacao(7);
  end;

  PanelColor1.Enabled := true;
  LimpaCampos;
  EFilial.Text := IntToStr(varia.CodigoEmpFil);
  EMoedas.Text := IntToStr(varia.MoedaBase);
  EMoedas.Atualiza;
  Emissao.Text := DateToStr(date);
  if self.Visible then
    ENota.SetFocus;
end;

{**********************Cria as parcelas do contas a receber********************}
function TFNovoContasAReceber.CriaParcelasReceber( var ValorTotal : Double ): Integer;
var
  Dado : TDadosNovaContaCR;
  CodFrmPagto : Integer;
  TotalPago : Double;
begin
  Dado := TDadosNovaContaCR.Create;
  Dado.CodEmpFil := Varia.CodigoEmpFil;
  Dado.NroNota := Trunc(ENota.Avalor);
  Dado.SeqNota := 0;
  Dado.CodCondicaoPgto := StrToInt(EPagamento.text);
  Dado.CodCliente := StrToInt(ECliente.text);
  Dado.CodFrmPagto := StrToInt(EdcFormaPgto.text);
  Dado.CodMoeda :=  StrToInt(EMoedas.text);
  Dado.CodUsuario := varia.CodigoUsuario;
  Dado.DataMov := date;
  Dado.DataEmissao := StrToDate(Emissao.Text);
  Dado.PlanoConta := EPlano.text;
  Dado.ValorTotal := ValorCalcular.AValor;
  Dado.PercentualDescAcr := 0;
  Dado.VerificarCaixa := config.Baixa_CR_CP_Caixa;
  Dado.BaixarConta := BaixaConta.ItemIndex = 1;
  Dado.DataBaixa := strtodate(DataBaixa.Text);
  dado.DataInicio := StrToDate(Emissao.Text);
  Dado.MostrarParcelas := true;
  Dado.MostrarTelaCaixa := false;
  Dado.TipoFrmPAgto :=  TipoFrmPagamento;
  Dado.GerarComissao := true;
  Dado.ValorPro :=  nil;
  Dado.PercPro :=  nil;
  Dado.PerDescontoDoCliente := Self.DescontoDoCliente;
  if EVendedor.text <> '' then
    dado.CodVendedor := strtoint(EVendedor.text);

  if EVendedor.Text <> '' then
  begin
     // comissao
     Vendedores := TStringList.create;
     ValorPro := TstringList.create;
     PercPro := TstringList.create;
     ValorSer := TstringList.create;
     PercSer := TstringList.create;
     ValorComissaoPro := TStringList.Create;
     ValorComissaoSer := TStringList.Create;
     Case varia.ComissaoPadrao of
       0 : begin  //percentual do produto e servico
             //NF.ListaDeValorPercProduto(ValorPro, PercPro, ValorSer, PercSer, ValorComissaoPro, ValorComissaoSer, cadNotasFiscais.FieldByName('I_SEQ_NOT').AsInteger );
             Dado.Vendedor := nil;//FIncluiMaisVendedores.ListaVendedores;
             Dado.ValorPro := nil;//ValorPro;
             Dado.PercPro := nil;//PercPro;
             Dado.ValorSer := nil;//ValorSer;
             Dado.PercSer := nil;//PercSer;
           end;
       1 : begin  // valor do produto e servico
             //NF.ListaDeValorPercProduto(ValorPro, PercPro, ValorSer, PercSer, ValorComissaoPro, ValorComissaoSer, cadNotasFiscais.FieldByName('I_SEQ_NOT').AsInteger );
             Dado.Vendedor := nil;//FIncluiMaisVendedores.ListaVendedores;
             Dado.ValorPro := nil;//ValorComissaoPro;
             Dado.PercPro := nil;
             Dado.ValorSer := nil;//ValorComissaoSer;
             Dado.PercSer := nil;
           end;
       2 : begin // comissao do vendedor
             Dado.Vendedor := FIncluiMaisVendedores.ListaVendedores;
             Dado.Vendedor.Add(evendedor.text);
             Dado.ValorPro := FIncluiMaisVendedores.ListaValorPro;
             Dado.ValorPro.Add(floattostr(EValorCalcularComissao.avalor));
             Dado.PercPro := FIncluiMaisVendedores.ListaPercentualPro;
             Dado.PercPro.Add(floattostr(EPercComissaoVen.avalor));
             Dado.ValorSer := FIncluiMaisVendedores.ListaValorSer;
             Dado.ValorSer.Add(inttostr(0));
             Dado.PercSer := FIncluiMaisVendedores.ListaPercentualSer;
             Dado.PercSer.Add(inttostr(0));
           end;
       3 : begin // sem comissao
             if varia.usarmeta <> 2 then
              begin
                Dado.Vendedor := FIncluiMaisVendedores.ListaVendedores;
                Dado.Vendedor.Add(evendedor.text);
                Dado.ValorPro := FIncluiMaisVendedores.ListaValorPro;
                Dado.ValorPro.Add(floattostr(EValorCalcularComissao.avalor));
                Dado.ValorSer := FIncluiMaisVendedores.ListaValorSer;
                Dado.ValorSer.Add(inttostr(0));
              end
              else
              begin
                Dado.Vendedor := nil;
                Dado.ValorPro :=  nil;
                Dado.PercPro :=  nil;
                Dado.ValorSer := nil;
                Dado.PercSer := nil;
              end;
           end;
     end;
     Vendedores.Clear;
     ValorPro.clear;
     PercPro.Clear;
     ValorSer.clear;
     PercSer.Clear;
     ValorComissaoPro.Clear;
     ValorComissaoSer.Clear;
     FIncluiMaisVendedores.LimpaListas;
  end;

  CR := TFuncoesContasAReceber.criar(Self, FPrincipal.BaseDados);
  Result := CR.CriaContaReceber( dado, ValorTotal, TotalPago, CodFrmPagto , true);
  CR.Free;

  if IntToStr(CodFrmPagto) <> EdcFormaPgto.Text then
  begin
    EdcFormaPgto.Text := IntToStr(CodFrmPagto);
    EdcFormaPgto.Atualiza;
  end;
  Dado.Destroy;
end;

{******************* gravar registro **************************************** }
procedure TFNovoContasAReceber.BotaoGravar1Click(Sender: TObject);
var
  ValorTotal : Double;
begin
  if ValorCalcular.AValor = 0 then
  begin
    Aviso('Informe um valor para este título.');
    ValorCalcular.SetFocus;
    Abort;
  end;

  Tempo.Execute('Criando as Parcelas...');
  try
    // cria a conta, parcela, comissao
    LancamentoCR := CriaParcelasReceber( ValorTotal );
    ENumeroRecebimento.Text := IntTostr(LancamentoCR);

    tempo.fecha;
    AlterarEnabled([BNovo, BotaoGravar1, BotaoCancelar1, BFechar,  BImprimir] );
    // capa de lote
    if VerificaCapaLote.Checked then
      Numerico1.AValor := Numerico1.AValor +  ValorTotal;

    PanelColor1.Enabled := false;
  except
    aviso('Erro Criando as Parcelas');
    tempo.fecha;
  end;
end;

{***************** cancelar regisdtro **************************************** }
procedure TFNovoContasAReceber.BotaoCancelar1Click(Sender: TObject);
begin
  LimpaCampos;
  BotaoGravar1.Enabled := false;
  PanelColor1.Enabled := false;
end;

{************************ Help *********************************************** }
procedure TFNovoContasAReceber.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FNovoContasAReceber.HelpContext);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Capa de Lote
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********Quando precionado o botao do capa de lote, zerando o mesmo*********}
procedure TFNovoContasAReceber.BVerificaClick(Sender: TObject);
begin
  CapaLote := 0;
  Numerico1.Avalor := CapaLote;
  BVerifica.Kind := bkOk;
  BVerifica.Default := false;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := 'Ok';
  BVerifica.Cancel := false;
end;

{*****quando adicionado algo a caixa capa de lote o mesmo muda de situacao*****}
procedure TFNovoContasAReceber.EditColor4Change(Sender: TObject);
begin
  BVerifica.Kind := bkNo;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := '&Verificar';
  BVerifica.Cancel := false;
end;

{******************CheckBox que habilita ou não o capa de lote*****************}
procedure TFNovoContasAReceber.VerificaCapaLoteClick(Sender: TObject);
begin
  if VerificaCapaLote.Checked then
  begin
    BVerifica.Enabled := true;
    label9.Enabled := true;
    Numerico1.Enabled := true;
  end
  else
  begin
    BVerifica.Enabled := false;
    label9.Enabled := false;
    Numerico1.Enabled := false;
  end;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************Carrega a select das condicoes de pagamento*******************}
procedure TFNovoContasAReceber.EPagamentoSelect(Sender: TObject);
begin
   EPagamento.ASelectValida.Add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From dba.CadCondicoesPagto ' +
                                ' where I_Cod_Pag = @ and D_VAL_CON > ''' + DataToStrFormato(AAAAMMDD,date,'/') + '''' );

   EPagamento.ASelectLocaliza.add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From dba.CadCondicoesPagto ' +
                                  ' where c_Nom_Pag like ''@%'' and D_VAL_CON > ''' +
                                  DataToStrFormato(AAAAMMDD,date,'/') + '''' +
                                  ' order by c_Nom_Pag asc');
end;

{********************* retorno da moeda ************************************ }
procedure TFNovoContasAReceber.EMoedasRetorno(Retorno1,
  Retorno2: String);
begin
   if Retorno1 <> '' then
   begin
      atualizaMascaraValor(retorno1);
   end;
end;

{ ************* retorno da condicao de pagamento **************************** }
procedure TFNovoContasAReceber.EPagamentoRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
    EQuantidadeParcelas.AValor := StrToInt(retorno1);
end;

{********************* rcadastrar Pagamentos ********************************* }
procedure TFNovoContasAReceber.EPagamentoCadastrar(Sender: TObject);
begin
  FCondicoesPagamentos := TFCondicoesPagamentos.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCondicoesPagamentos'));
  FCondicoesPagamentos.BotaoCadastrar1.Click;
  FCondicoesPagamentos.ShowModal;
  Localiza.AtualizaConsulta;
end;

{**************** Plano de Contas ******************************************* }
procedure TFNovoContasAReceber.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;

{****************** botao do plano de contas ******************************** }
procedure TFNovoContasAReceber.EPlanoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

{************** retorno do vendedor ****************************************** }
procedure TFNovoContasAReceber.EVendedorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    begin
      EPercComissaoVen.AValor := StrToFloat(Retorno1);
      maisvendedores.Enabled :=true;
    end
  else
    maisvendedores.Enabled := false;    
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Atualiza a mascara dos valores*************************}
procedure TFNovoContasAReceber.atualizaMascaraValor(Sigla : String);
begin
  CurrencyString := sigla;
  Varia.MascaraMoeda := CurrencyString + ' ' + Varia.MascaraValor;
  Numerico1.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;
  ValorCalcular.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;
  Evalor.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;
end;

{******************* Ok do painel do vendedor ******************************** }
procedure TFNovoContasAReceber.BitBtn7Click(Sender: TObject);
begin
 PComissao.Visible := false;
end;

{************************ F5 para cadastrar ********************************* }
procedure TFNovoContasAReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if BNovo.Enabled then
   if key = 116 then
     BNovo.Click;
end;


procedure TFNovoContasAReceber.EdcFormaPgtoRetorno(Retorno1,
  Retorno2: String);
begin
  BaixaConta.ItemIndex := 0;
  BaixaConta.Enabled := false;
  DataBaixa.Enabled := false;
  Label24.Enabled := false;
  Label17.Enabled := false;

  if retorno1 <> '' then
  begin
    AdicionaSQLAbreTabela(FrmPagamento, ' Select * from cadFormasPagamento ' +
                                       ' where i_cod_frm = ' + Retorno1);



    TipoFrmPagamento := FrmPagamentoC_FLA_TIP.AsString;

    if (ConfigModulos.Caixa) and (not Config.PermiteBaixarCRsemCaixa) then
    begin
      if ((FrmPagamentoC_FLA_BCR.AsString = 'B') or (FrmPagamentoC_FLA_BCR.AsString = 'C')) and (FrmPagamentoC_BAI_CON.AsString = 'S') then
      begin
        BaixaConta.Enabled := true;
        Label24.Enabled := true;
        DataBaixa.Enabled := true;
        Label17.Enabled := true;
      end;
    end
    else
    begin
      if (FrmPagamentoC_BAI_CON.AsString = 'S') then
      begin
        BaixaConta.Enabled := true;
        Label24.Enabled := true;
        DataBaixa.Enabled := true;
        Label17.Enabled := true;
      end;
    end
  end;
end;

procedure TFNovoContasAReceber.ENotaExit(Sender: TObject);
begin
   aux.close;
   if (ENota.Text <> '') then  // verifica se exixte o nro da not, forn, e filial ja cadastrado no CP.
   begin
     AdicionaSQLAbreTabela(aux, 'select * from CadContasaReceber where I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                                ' and I_NRO_NOT = ' + ENota.Text  );
   end;
   if not (aux.EOF) then
     if not confirmacao(' Já existe uma Nota Fiscal Cadastrada no Contas a Recber com o Nº ' +  ENota.Text +
                        ' Continuar cadastro ? ' ) then
     begin
         BotaoGravar1.Enabled := false;
         BNovo.Enabled := true;
         BImprimir.Enabled := true;
         BotaoCancelar1.Enabled := false;
         PanelColor1.Enabled := false;
     end;
   FechaTabela(aux);
end;

procedure TFNovoContasAReceber.BImprimirClick(Sender: TObject);
begin
  CR := TFuncoesContasAReceber.criar(Self, FPrincipal.BaseDados);
  CR.ImprimeFichaLancamento(LancamentoCR);
  CR.Free;
end;

procedure TFNovoContasAReceber.EClienteRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    AdicionaSQLAbreTabela(aux, 'Select * from cadClientes where i_cod_cli = ' + Retorno1);

    if aux.FieldByName('i_cod_pag').AsInteger <> 0 then
      EdcFormaPgto.Text := aux.FieldByName('i_cod_pag').AsString;
    if aux.FieldByName('i_cod_frm').AsInteger <> 0 then
      EPagamento.Text := aux.FieldByName('i_cod_frm').AsString;
    DescontoDoCliente := aux.FieldByName('n_des_bol').AsCurrency;
    EPagamentoSelect(EPagamento);
    EPagamento.Atualiza;
    EdcFormaPgto.Atualiza;
    aux.close;
  end;
end;

procedure TFNovoContasAReceber.EmissaoExit(Sender: TObject);
begin
  if not ValidaDataRetroativa(StrToDate(Emissao.Text)) then
    if Emissao.Enabled then
      Emissao.SetFocus;
end;

procedure TFNovoContasAReceber.BaixaContaChange(Sender: TObject);
begin
  DataBaixa.Enabled := BaixaConta.ItemIndex = 1;
  label17.Enabled := BaixaConta.ItemIndex = 1;
end;

procedure TFNovoContasAReceber.DataBaixaExit(Sender: TObject);
begin
  if (sender is TMaskEditColor) then
//   if not ValidaTextoData((sender as TMaskEditColor).Text) then
     (sender as TMaskEditColor).SetFocus;

  if (config.DataBaixaMenor) then  //RETROATIVO DIA
    if strToDate(DataBaixa.text) < date then
    begin
      aviso(CT_DataMenorBAixa);
      if DataBaixa.Enabled then
        DataBaixa.SetFocus;
    end;

  if not ValidaDataRetroativa(StrToDate(DataBaixa.Text)) then // RETRATIVO MES
    if DataBaixa.Enabled then
      DataBaixa.SetFocus;
end;

procedure TFNovoContasAReceber.maisvendedoresClick(Sender: TObject);
begin
  FIncluiMaisVendedores := TFIncluiMaisVendedores.CriarSDI(Application,'',true);
  FIncluiMaisVendedores.configuratela(false);
  FIncluiMaisVendedores.CarregaCampos(Evendedor.text,'Valor Total', 'Perc.Comissão',
                                      'Valor Total', 'Perc.Comissao',
                                      EValorCalcularComissao.avalor,0,
                                      EPercComissaoVen.avalor, 0);
  FIncluiMaisVendedores.showModal;
  MaisVendedores.Enabled := false;
end;

Initialization
  RegisterClasses([TFNovoContasAReceber]);
end.
 