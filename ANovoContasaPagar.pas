unit ANovoContasaPagar;

{          Autor: Sergio Luiz Censi
    Data Criação: 12/04/1999;
          Função: Cadastrar uma nova conta a pagar

Motivo alteração: - Adicionada o campo I_cod_Moe (codigo moeda) e a atualizacao dos
                    campos valores - 12/04/1999 / Rafael Budag
                  - Adicionado em todos os campos valores o componente
                    TDBNumérico - 13/04/1999 / Rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Db, DBTables, Tabela, StdCtrls,
  DBCtrls, BotaoCadastro, Buttons, Localizacao,
  Grids, DBGrids, constantes, Mask, DBKeyViolation, LabelCorMove,
  Spin, EditorImagem, numericos, unContasaPagar;

type
  TFNovoContasAPagar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    EDataEmissao: TMaskEditColor;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EFilial: TEditColor;
    NroOrdem: TEditColor;
    Label8: TLabel;
    Localiza: TConsultaPadrao;
    Bevel2: TBevel;
    Label9: TLabel;
    VerificaCapaLote: TCheckBox;
    Label11: TLabel;
    BFoto: TBitBtn;
    Label16: TLabel;
    LFoto: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    EFornecedor: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Numerico1: TNumerico;
    Imagem: TEditorImagem;
    Label21: TLabel;
    EValorparcelas: Tnumerico;
    LParcelas: TLabel;
    SpinEdit1: TSpinEditColor;
    SpinEdit2: TSpinEditColor;
    EMoeda: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    Label6: TLabel;
    EParelas: TNumerico;
    EValorTotal: TNumerico;
    ValidaGravacao: TValidaGravacao;
    ENota: TNumerico;
    EdcFormaPgto: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label7: TLabel;
    BDespesaFixa: TBitBtn;
    Tempo: TPainelTempo;
    EPlano: TEditColor;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    LParcelaReceber: TLabel;
    BAdicional: TSpeedButton;
    EContaAReceber: TEditLocaliza;
    BaixaConta: TComboBoxColor;
    Label12: TLabel;
    Label4: TLabel;
    Aux: TQuery;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BotaoGravar1: TBitBtn;
    BNovo: TBitBtn;
    BotaoCancelar1: TBitBtn;
    BBAjuda: TBitBtn;
    BImprimir: TBitBtn;
    BVerifica: TBitBtn;
    Label17: TLabel;
    DataBaixa: TMaskEditColor;
    FrmPagamento: TQuery;
    FrmPagamentoI_COD_FRM: TIntegerField;
    FrmPagamentoC_BAI_CON: TStringField;
    FrmPagamentoC_FLA_TIP: TStringField;
    FrmPagamentoC_FLA_BCP: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEditColor2Exit(Sender: TObject);
    procedure DBEditButton4Exit(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure BVerificaClick(Sender: TObject);
    procedure EditColor4Change(Sender: TObject);
    procedure VerificaCapaLoteClick(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure EFornecedorCadastrar(Sender: TObject);
    procedure DBEditColor20Exit(Sender: TObject);
    procedure EValorparcelasExit(Sender: TObject);
    procedure EMoedaRetorno(Retorno1, Retorno2: String);
    procedure EFilialChange(Sender: TObject);
    procedure EdcFormaPgtoCadastrar(Sender: TObject);
    procedure BDespesaFixaClick(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EContaAReceberSelect(Sender: TObject);
    procedure EContaAReceberRetorno(Retorno1, Retorno2: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure EdcFormaPgtoRetorno(Retorno1, Retorno2: String);
    procedure SpinEdit1Exit(Sender: TObject);
    procedure BFotoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure EDataEmissaoExit(Sender: TObject);
    procedure BaixaContaChange(Sender: TObject);
    procedure DataBaixaExit(Sender: TObject);
  private
    TipoPrevisao : integer;
    CP : TFuncoesContasAPagar;
    TipoFormaPgto : string;
    AutoFechar : Boolean;
    CodDespesa, Lancamento : Integer;
    ContaVinculada, ParcelaVinculada : Integer;
    procedure LimpaCampos;
    procedure atualizaMascaraValor(Sigla : String);
    Function RetornaSiglaValor: String;
  public
    procedure CarregaComoAdicionalReceber;
    procedure CarregaPrevisao;
  end;

var
  FNovoContasAPagar: TFNovoContasAPagar;

implementation

uses ConstMsg,  FunData, APrincipal, funString,
  ANovoCliente, funObjeto, funsql, AFormasPagamento,
  ADespesas, APlanoConta,  UnClassesImprimir, UnDespesas;

{$R *.DFM}

{**************************Na criação do Formulário****************************}
procedure TFNovoContasAPagar.FormCreate(Sender: TObject);
begin
  TipoPrevisao := 0; // contas a pagar
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  VerificaCapaLote.Checked := Config.CapaLote;
  if not Config.BaixaCPCadastro then
  begin
    BaixaConta.Visible := false;
    Label12.Visible := false;
  end;
  AutoFechar := false;
  EDataEmissao.EditMask := FPrincipal.CorFoco.AMascaraData;
  DataBaixa.EditMask := FPrincipal.CorFoco.AMascaraData;
end;

{**********************Quando o formulario e fechado***************************}
procedure TFNovoContasAPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CurrencyString := varia.CifraoMoeda;
  aux.close;
  FrmPagamento.close;
  Action := CaFree;
end;

{****************** chamda externa como vinculada *************************** }
procedure TFNovoContasAPagar.CarregaComoAdicionalReceber;
begin
  LimpaCampos;
  BDespesaFixa.Visible := False;
  EContaAReceber.Visible := True;
  EContaAReceber.ACampoObrigatorio := True;
  BAdicional.Visible := True;
  LParcelaReceber.Visible := True;
  LParcelaReceber.Caption := '';
  EValorparcelas.Visible := False;
  EParelas.Enabled := False;
  Self.Caption := 'Cadastro de Conta a Pagar Vinculada como Adicional de Conta a Receber';
  LParcelas.Caption := 'Adicional da Conta : ';
  Self.ShowModal;
end;

procedure TFNovoContasAPagar.CarregaPrevisao;
begin
  self.Caption := 'Cadastro de previsões';
  PainelGradiente1.Caption := 'Cadastro de previsões a pagar';
  TipoPrevisao := 1;
  Self.ShowModal;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações de Inicialização
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*******************permite atualizar os campos relacionados*******************}
procedure TFNovoContasAPagar.LimpaCampos;
begin
  EMoeda.Text := IntTostr(Varia.MoedaBase);
  EMoeda.Atualiza;
  EFornecedor.text := '';
  EFornecedor.Atualiza;
  EdcFormaPgto.Text := '';
  EdcFormaPgto.Atualiza;
  EPlano.Text := '';
  LPlano.Caption := '';
  EParelas.AValor := 1; // Somente uma parcela.}
  EFilial.Text := IntTostr(Varia.CodigoEmpFil);  // adiciona o codigo da filial
  EDataEmissao.Text := dateTostr(date);      // valida campo data
  DataBaixa.Text := dateTostr(date);      // valida campo data
  EValorParcelas.AValor := 0;
  AtualizaMascaraValor(CurrencyString);
  EParelas.ReadOnly := False;
  BaixaConta.ItemIndex := 0;
  EValorparcelas.AValor := 0;
  EValorTotal.AValor := 0;
  ENota.AValor := 0;
  NroOrdem.text := '';
  //despesa fixa
  CodDespesa := 0;
  // conta vinculada
  EContaAReceber.Text := '';
  EContaAReceber.Atualiza;
  ContaVinculada := 0;
  ParcelaVinculada := 0;
  LParcelaReceber.Caption := '';
  AlterarEnabled([BNovo, BotaoGravar1, BotaoCancelar1, BFechar, BImprimir] );
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Chamadas para telas de Cadastros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Cadastro na Consulta do campo Fornecedores******************}
procedure TFNovoContasAPagar.EFornecedorCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.ShowModal;
  Localiza.AtualizaConsulta;
end;

{*****************Cadastra uma nova forma de Pagamento*************************}
procedure TFNovoContasAPagar.EdcFormaPgtoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.ShowModal;
  Localiza.AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Validação dos campos relacionados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************valida o numero da nota fiscal***********************}
procedure TFNovoContasAPagar.DBEditButton4Exit(Sender: TObject);
begin
   aux.close;
   if (ENota.Text <> '') and (Efornecedor.Text <> '' ) then  // verifica se exixte o nro da not, forn, e filial ja cadastrado no CP.
   begin
     AdicionaSQLAbreTabela(aux, 'select * from dba.CadContasaPagar where I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                                ' and I_NRO_NOT = ' + ENota.Text +
                                ' and I_COD_CLI = ' + EFornecedor.Text);
   end;
   if not (aux.EOF) then
     if confirmacao(' Já existe uma Nota Fiscal Cadastrada no Contas a Pagar com o Nº ' +  ENota.Text + ' do Fornecedor  ' +
                     Label16.Caption  + ' Continuar cadastro ? ' ) then
     begin
         BotaoGravar1.Enabled := false;
         BNovo.Enabled := true;
         BImprimir.Enabled := true;
     end
     else
       ENota.SetFocus;
   FechaTabela(aux);
end;

{ *******************  retorno da moeda *********************************** }
procedure TFNovoContasAPagar.EMoedaRetorno(Retorno1,
  Retorno2: String);
begin
   if Retorno1 <> '' then
   begin
      CurrencyString := Retorno1;
      Varia.MascaraMoeda := CurrencyString + ' ' + Varia.MascaraValor;
      Numerico1.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;
      EValorTotal.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;      
      EValorparcelas.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;
   end;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Validação dos campos Gerais
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****************valida o campo parcela no minimo 1 parcela*******************}
procedure TFNovoContasAPagar.DBEditColor2Exit(Sender: TObject);
begin
  if EParelas.AValor < 1 then
    EParelas.SetFocus
  else
    if EParelas.avalor > 1 then  // habilita o o componente para qdade de dias
    begin
      Label18.Enabled := true;
      SpinEdit1.Enabled := true;
      BDespesaFixa.Enabled := false;
    end
    else
      begin
          Label18.Enabled := false;
          SpinEdit1.Enabled := false;
          BDespesaFixa.Enabled := True;
      end;
end;

{*****************caso o valor total > 0 zera o valor das parcelas*************}
procedure TFNovoContasAPagar.DBEditColor20Exit(Sender: TObject);
begin
  if (EValorTotal.avalor > 0) then
    EValorParcelas.AValor := 0;
end;

{******************caso o valor da parcela > 0 zera o valor total**************}
procedure TFNovoContasAPagar.EValorparcelasExit(Sender: TObject);
begin
if (EValorParcelas.AValor > 0) then
   EValorTotal.AValor := 0;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              Botoes de Atividade, novo, alterar, parcelas, etc
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{****Qunado fechar o formulario verifica o capa de lote e o CadContasaPagar****}
procedure TFNovoContasAPagar.BFecharClick(Sender: TObject);
begin
  if numerico1.AValor <> 0 then
   Aviso(CT_VerificaCapaLote)
  else
     close;
end;

{***************************adiciona uma nova conta****************************}
procedure TFNovoContasAPagar.BNovoClick(Sender: TObject);
var
  Sequencial, Filial : integer;
  CP : TFuncoesContasAPagar;
begin
  if VerificaTransacao(6, Sequencial, Filial) then
  begin
     CP := TFuncoesContasAPagar.criar(self, fprincipal.BaseDados);
     CP.ExcluiConta(Sequencial, Filial, false,false);
     CP.free;
     DesmarcaTransacao(6);
  end;
  PanelColor1.Enabled := true;
  LimpaCampos;
  if Self.Visible then
    EFornecedor.SetFocus;
end;

{ ******* permite alterar e adicionar vinculos com as fotos ******** }
procedure TFNovoContasAPagar.BFotoClick(Sender: TObject);
begin
  if Imagem.execute(varia.DriveFoto) then
    LFoto.Caption := Imagem.PathImagem;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Capa de Lote
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******* Quando precionado o botao do capa de lote, zerando o mesmo ******* }
procedure TFNovoContasAPagar.BVerificaClick(Sender: TObject);
begin
  Numerico1.Avalor := 0;
  BVerifica.Kind := bkOk;
  BVerifica.Default := false;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := 'Ok';
  BVerifica.Cancel := false;
end;

{ ****** Quando adicionado algo a caixa capa de lote o mesmo muda de situacao **** }
procedure TFNovoContasAPagar.EditColor4Change(Sender: TObject);
begin
  BVerifica.Kind := bkNo;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := '&Verificar';
  BVerifica.Cancel := false;
end;

{****************CheckBox que habilita ou não o capa de lote*******************}
procedure TFNovoContasAPagar.VerificaCapaLoteClick(Sender: TObject);
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
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************Retorna a sigla da moeda****************************}
function TFNovoContasAPagar.retornaSiglaValor: String;
begin
  AdicionaSQLAbreTabela(aux,'Select * from cadMoedas Where I_cod_moe = ' + EMoeda.text);
  Result := AUX.fieldbyname('C_Cif_Moe').AsString;
  FechaTabela(aux);
end;

{*************************Atualiza a mascara do valor**************************}
procedure TFNovoContasAPagar.atualizaMascaraValor(Sigla : String);
begin
   CurrencyString := sigla;
   Numerico1.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;
   EValorparcelas.AMascara := CurrencyString + ' ' + Varia.MascaraValor + '; -'+ CurrencyString + ' ' + Varia.MascaraValor;
end;

{ ***************** valida a gravacao dos registros *********************** }
procedure TFNovoContasAPagar.EFilialChange(Sender: TObject);
begin
   ValidaGravacao.execute;
  if EdcFormaPgto.Text = '' then
    BotaoGravar1.Enabled := false;
  if (EParelas.Text <> '')  then
    BDespesaFixa.Enabled := (StrToInt(EParelas.Text) = 1);
end;


procedure TFNovoContasAPagar.BDespesaFixaClick(Sender: TObject);
begin
  if (Trim(EPlano.Text) = '') then
    EPlano.SetFocus
  else
  begin
    if CodDespesa = 0 then
    begin
      FDespesas := TFDespesas.CriarSDI(Application,'', FPrincipal.VerificaPermisao('FDespesas'));
      if FDespesas.InsereLocalizaConta(EPlano.Text, LPlano.Caption, CodDespesa) then
      begin
        BDespesaFixa.Enabled:=False;
        EParelas.ReadOnly := True; // Não pode mudar o número de parcelas.
      end
      else Aviso('Despesa fixa não foi gerada.');
    end
    else Aviso('Já existe uma despesa vinculada a este título.');
  end;
end;

procedure TFNovoContasAPagar.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;


procedure TFNovoContasAPagar.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

procedure TFNovoContasAPagar.EContaAReceberSelect(Sender: TObject);
begin
  // Adicionar a uma conta que ainda não foi paga.
  EContaAReceber.ASelectValida.Clear;
  EContaAReceber.ASelectValida.Add(' Select MCR.D_DAT_PAG, MCR.I_NRO_PAR, MCR.C_NRO_DUP, CR.I_EMP_FIL, CR.I_LAN_REC, C.C_NOM_CLI, CR.I_NRO_NOT,' +
                                   ' CAST(MCR.C_NRO_DUP AS CHAR) + ''-'' + CAST(MCR.I_NRO_PAR AS CHAR) + ''    '' + CAST(CR.CR.I_NRO_NOT AS CHAR) COLUNA ' +
                                   ' from CadContasAReceber as CR, CadClientes as C, MovContasAReceber as MCR ' +
                                   ' where ' +
                                   ' MCR.D_DAT_PAG is null ' +
                                   ' and CR.I_LAN_REC = @ ' +
                                   ' and isnull(MCR.C_DUP_CAN, ''N'') = ''N'' ' +
                                   ' and CR.I_COD_CLI = C.I_COD_CLI ' +
                                   ' and CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                   ' and MCR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                   ' and CR.I_LAN_REC = MCR.I_LAN_REC ' );
  EContaAReceber.ASelectLocaliza.Clear;
  EContaAReceber.ASelectLocaliza.Add(' Select CR.I_EMP_FIL, MCR.I_NRO_PAR, CR.I_LAN_REC, C.C_NOM_CLI, CR.I_NRO_NOT, ' +
                                     ' CAST(MCR.C_NRO_DUP AS CHAR) + ''-'' + CAST(MCR.I_NRO_PAR AS CHAR) + ''    '' + CAST(CR.CR.I_NRO_NOT AS CHAR) COLUNA ' +
                                     ' from CadContasAReceber as CR, CadClientes as C, MovContasAReceber as MCR ' +
                                     ' where ' +
                                     ' MCR.D_DAT_PAG is null ' +
                                     ' and C.C_NOM_CLI like ''@%''' +
                                     ' and isnull(MCR.C_DUP_CAN, ''N'') = ''N'' '  +
                                     ' and CR.I_COD_CLI = C.I_COD_CLI ' +
                                     ' and CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                     ' and MCR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                     ' and CR.I_LAN_REC = MCR.I_LAN_REC '  );
end;

procedure TFNovoContasAPagar.EContaAReceberRetorno(Retorno1,
  Retorno2: String);
begin
  if EContaAReceber.Visible then // É Conta Adicional.
    if (Retorno1 = '') then
    begin
        ContaVinculada := 0;
        ParcelaVinculada := 0;
        LParcelaReceber.Caption := '';
    end
    else
    begin
        LParcelaReceber.Caption := 'Parcela Viculdada: ' + Retorno1;
        ContaVinculada := StrToInt(Retorno2);
        ParcelaVinculada := StrToInt(Retorno1);
    end;
end;

procedure TFNovoContasAPagar.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FNovoContasAPagar.HelpContext);
end;


procedure TFNovoContasAPagar.EdcFormaPgtoRetorno(Retorno1,
  Retorno2: String);
begin
  BaixaConta.ItemIndex := 0;
  BaixaConta.Enabled := false;
  DataBaixa.Enabled := false;
  Label12.Enabled := false;
  Label17.Enabled := false;

  if retorno1 <> '' then
  begin
    AdicionaSQLAbreTabela(FrmPagamento, ' Select * from cadFormasPagamento ' +
                                       ' where i_cod_frm = ' + Retorno1);

    TipoFormaPgto := FrmPagamentoC_FLA_TIP.AsString;

    if (ConfigModulos.Caixa) and (not Config.PermiteBaixarCPsemCaixa) then
    begin
      if ((FrmPagamentoC_FLA_BCP.AsString = 'B') or (FrmPagamentoC_FLA_BCP.AsString = 'C')) and (FrmPagamentoC_BAI_CON.AsString = 'S') then
      begin
        BaixaConta.Enabled := true;
        Label12.Enabled := true;
        DataBaixa.Enabled := true;
        Label17.Enabled := true;
      end;
    end
    else
    begin
      if (FrmPagamentoC_BAI_CON.AsString = 'S') then
      begin
        BaixaConta.Enabled := true;
        Label12.Enabled := true;
        DataBaixa.Enabled := true;
        Label17.Enabled := true;
      end;
    end;
  end;
end;

procedure TFNovoContasAPagar.SpinEdit1Exit(Sender: TObject);
begin
  BotaoGravar1.SetFocus;
end;

procedure TFNovoContasAPagar.BFotoExit(Sender: TObject);
begin
  if BotaoGravar1.Enabled then
    BotaoGravar1.SetFocus;
end;

procedure TFNovoContasAPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if BNovo.Enabled then
   if key = 116 then
     BNovo.Click;
end;


procedure TFNovoContasAPagar.FormShow(Sender: TObject);
begin
  if EMoeda.Enabled then
    EMoeda.SetFocus
  else
    if EFornecedor.Enabled then
      EFornecedor.SetFocus
    else
      if ENota.Enabled then
        ENota.SetFocus
      else
        if EPlano.Enabled then
          EPlano.SetFocus;

end;


procedure TFNovoContasAPagar.BotaoGravar1Click(Sender: TObject);
var
  Dado : TDadosNovaContaCP;
  Despesa : TFuncoesDespesas;
  ValorFinal, Valorpago : Double;
  FormaPAgto : Integer;
begin
  if EValorTotal.avalor = 0 then
    EValorTotal.AValor := EValorParcelas.AValor * EParelas.AValor;
  if EValorTotal.AValor = 0 then
  begin
    Aviso('Informe um valor para este título.');
    EValorTotal.SetFocus;
    Abort;
  end;


    Tempo.execute('Criando as Parcelas...');
    Dado := TDadosNovaContaCP.Create;
    Dado.CodEmpFil := Varia.CodigoEmpFil;
    Dado.NroNota := trunc(ENota.avalor);
    Dado.SeqNota := 0;
    Dado.CodFornecedor := StrToInt(EFornecedor.text);
    Dado.CodFrmPagto :=  StrToInt(EdcFormaPgto.Text);
    Dado.CodMoeda := StrToInt(EMoeda.text);
    Dado.CodUsuario := varia.CodigoUsuario;
    Dado.DataMovto := date;
    Dado.DataBaixa := strtodate(DataBaixa.Text);
    Dado.DataEmissao := StrToDate(EDataEmissao.Text);
    Dado.PlanoConta := EPlano.text;
    Dado.PathFoto := LFoto.Caption;
    Dado.NumeroParcela := Round(EParelas.Avalor);
    if EValorparcelas.AValor = 0 then
      Dado.ValorParcela := EValorTotal.AValor / EParelas.AValor
    else
      Dado.ValorParcela := EValorparcelas.AValor;
    Dado.QtdDiasPriVen := SpinEdit2.Value;
    Dado.QtdDiasDemaisVen := SpinEdit1.Value;
    Dado.PercentualDescAcr := 0;
    Dado.VerificarCaixa := config.Baixa_CR_CP_Caixa;
    Dado.BaixarConta := BaixaConta.ItemIndex = 1;
    Dado.MostrarParcelas :=  true;
    Dado.TipoFrmPAgto := TipoFormaPgto;
    Dado.CodDespesaFixa := CodDespesa;
    Dado.ContaVinculada := ContaVinculada;
    Dado.ParcelaVinculada := ParcelaVinculada;
//    Dado.TipoPRevisao := Tempo self.TipoPrevisao;

    CP := TFuncoesContasAPagar.Criar(self,FPrincipal.BaseDados);
    Lancamento := CP.CriaContaPagar( dado,  ValorFinal, Valorpago, FormaPAgto, true );
    cp.free;

    NroOrdem.text := IntTostr(Lancamento);
    if IntToStr(FormaPAgto) <> EdcFormaPgto.Text then
    begin
      EdcFormaPgto.Text := IntToStr(FormaPAgto);
      EdcFormaPgto.Atualiza;
    end;
    Tempo.Fecha;
    AtualizaMascaraValor(RetornaSiglaValor);

   // caso seja uma despesa fixa
   if CodDespesa <> 0 then
   begin
     Tempo.execute('Gerando despesas...');
     Despesa := TFuncoesDespesas.Criar(self, FPrincipal.BaseDados);
     if (not Despesa.GeraDespesasFixas(Lancamento)) then
       Aviso('Despesas fixas geradas Incorretamente.');
     despesa.free;
     Tempo.Fecha;
   end;

  if AutoFechar then
    self.close;

  // atualiza o capa de lote
  if VerificaCapaLote.Checked then
    Numerico1.AValor := Numerico1.AValor + Dado.ValorParcela;


 AlterarEnabledDet([ BotaoGravar1, BotaoCancelar1 ], false);
 AlterarEnabledDet([ BNovo, BFechar, BImprimir ], true);
 PanelColor1.Enabled := false;
end;

procedure TFNovoContasAPagar.BotaoCancelar1Click(Sender: TObject);
begin
  limpaCampos;
  BotaoGravar1.Enabled := false;
  BNovo.Enabled := true;
  BImprimir.Enabled := true;
  PanelColor1.Enabled := false;
end;

procedure TFNovoContasAPagar.BImprimirClick(Sender: TObject);
begin
  CP := TFuncoesContasAPagar.Criar(self,FPrincipal.BaseDados);
  CP.ImprimeFichaLancamento(lancamento);
  CP.free;
end;

procedure TFNovoContasAPagar.EDataEmissaoExit(Sender: TObject);
begin
  if (sender is TMaskEditColor) then
//   if not ValidaTextoData ((sender as TMaskEditColor).Text) then
     (sender as TMaskEditColor).SetFocus;

{  if not ValidaDataRetroativa(StrToDate(EDataemissao.Text)) then
    if EDataemissao.Enabled then
      EDataemissao.SetFocus;}
end;

procedure TFNovoContasAPagar.BaixaContaChange(Sender: TObject);
begin
  DataBaixa.Enabled := BaixaConta.ItemIndex = 1;
  label17.Enabled := BaixaConta.ItemIndex = 1;
end;

procedure TFNovoContasAPagar.DataBaixaExit(Sender: TObject);
begin
  if (sender is TMaskEditColor) then
//   if not ValidaTextoData((sender as TMaskEditColor).Text) then
     (sender as TMaskEditColor).SetFocus;

{  if (config.DataBaixaMenor) then  //RETROATIVO DIA
    if strToDate(DataBaixa.text) < date then
    begin
      aviso(CT_DataMenorBAixa);
      if DataBaixa.Enabled then
        DataBaixa.SetFocus;
    end;

  if not ValidaDataRetroativa(StrToDate(DataBaixa.Text)) then // RETRATIVO MES
    if DataBaixa.Enabled then
      DataBaixa.SetFocus;}
end;

Initialization
 RegisterClasses([TFNovoContasAPagar]);
end.

