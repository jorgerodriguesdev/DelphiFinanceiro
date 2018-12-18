unit ABaixaAcumuladaCR;
{    Autor: Jorge Eduardo Rodrigues
    Data Criação: 24 de setembro de 2001;
    Função: Baixar na Base parcelas que foram pagas em bloqueto
    Data Alteração:
    Alterado por:
    Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores, ToolWin,
  ImgList, numericos, UnContasAReceber, DBCGrids;

type
  TBaixa = class
   CodEmpFil : integer;
   CodLanrec : integer;
   NroParcela : integer;
   NroBloqueto : integer;
   ValorDesconto : Double;
   ValorAcrescimo : Double;
   Adicionais : Double;
   Valor : Double;
   NroDuplicata : string;
   ValorOri : Double;
end;

type
  TFBaixaAcumuladaCR = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    MovParcelas: TQuery;
    DataMovParcelas: TDataSource;
    tempo: TPainelTempo;
    PanelColor1: TPanelColor;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    Label14: TLabel;
    Label19: TLabel;
    SpeedButton6: TSpeedButton;
    Label28: TLabel;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    EditLocaliza4: TEditLocaliza;
    RPeriodo: TComboBoxColor;
    EdcFormaPgto: TEditLocaliza;
    Plista: TPanelColor;
    Label1: TLabel;
    ValorBaixa: Tnumerico;
    BSelecionaUm: TBitBtn;
    ListaBaixa: TListBoxColor;
    BSelTodos: TBitBtn;
    BExcluir: TBitBtn;
    BBaixar: TBitBtn;
    DescBan: Tnumerico;
    CredBan: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    Label11: TLabel;
    DataBaixa: TCalendario;
    Label4: TLabel;
    EformaPgto: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    LConta: TLabel;
    EConta: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Baixa: TQuery;
    BaixaI_EMP_FIL: TIntegerField;
    BaixaI_LAN_REC: TIntegerField;
    BaixaI_NRO_PAR: TIntegerField;
    BaixaD_DAT_VEN: TDateField;
    BaixaN_VLR_PAR: TFloatField;
    BaixaN_PER_MOR: TFloatField;
    BaixaN_PER_JUR: TFloatField;
    BaixaN_PER_MUL: TFloatField;
    BaixaC_NRO_DUP: TStringField;
    BaixaI_PAR_FIL: TIntegerField;
    BaixaI_PAR_MAE: TIntegerField;
    BaixaN_PER_ACR: TFloatField;
    BaixaN_PER_DES: TFloatField;
    BaixaI_LAN_BAC: TIntegerField;
    BaixaI_NRO_NOT: TIntegerField;
    BaixaC_CLA_PLA: TStringField;
    GridIndice1: TGridIndice;
    BaixaN_VLR_ADI: TFloatField;
    BaixaN_VLR_DES: TFloatField;
    BaixaN_VLR_ACR: TFloatField;
    BaixaN_DES_VEN: TFloatField;
    BaixaI_COD_MOE: TIntegerField;
    MovParcelasI_LAN_REC: TIntegerField;
    MovParcelasC_CLA_PLA: TStringField;
    MovParcelasL_OBS_REC: TMemoField;
    MovParcelasI_SEQ_NOT: TIntegerField;
    MovParcelasI_COD_CLI: TIntegerField;
    MovParcelasI_NRO_NOT: TIntegerField;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasI_COD_MAT: TIntegerField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_DES_VEN: TFloatField;
    MovParcelasD_DAT_EMI: TDateField;
    MovParcelasN_VLR_PAR: TFloatField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasC_NOM_MOE: TStringField;
    MovParcelasI_EMP_FIL: TIntegerField;
    MovParcelasC_NOM_CLI: TStringField;
    MovParcelasC_NOM_PLA: TStringField;
    MovParcelasD_DAT_MOV: TDateField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasC_NOM_FRM: TStringField;
    MovParcelasN_PER_MUL: TFloatField;
    MovParcelasN_PER_JUR: TFloatField;
    MovParcelasN_VLR_DES: TFloatField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasN_PER_MOR: TFloatField;
    MovParcelasN_VLR_ADI: TFloatField;
    Label27: TLabel;
    Label7: TLabel;
    numerico1: Tnumerico;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TipoDataParcelaChange(Sender: TObject);
    procedure DataParcela1Change(Sender: TObject);
    procedure SitParClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure EditLocaliza4Select(Sender: TObject);
    procedure EditLocaliza5Retorno(Retorno1, Retorno2: String);
    procedure BbCancelarClick(Sender: TObject);
    procedure BSelecionaUmClick(Sender: TObject);
    procedure BSelTodosClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure DescBanExit(Sender: TObject);
    procedure EformaPgtoRetorno(Retorno1, Retorno2: String);
    procedure BBaixarClick(Sender: TObject);
    procedure EformaPgtoSelect(Sender: TObject);
    procedure DataBaixaChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    Bloqueto,TipoFRMPagto : string;
    CR : TFuncoesContasAReceber;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: Tstrings);
    function MostraLista : Double;
    procedure BaixaConta;
  public
    { Public declarations }
  end;

var
  FBaixaAcumuladaCR: TFBaixaAcumuladaCR;

implementation

uses fundata, APrincipal, constmsg, ANovoContasaReceber, ABaixaContasReceber,
     AGraficosContasaReceber, AImprimeCR, AManutencaoCR, funsql,funobjeto,funnumeros,funstring, APlanoConta,
     AMovComissoes, AContasAReceber, UnBancario,
  ADepositoCheque ;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaAcumuladaCR.FormCreate(Sender: TObject);
begin
   CR := TFuncoesContasAReceber.criar(self, FPrincipal.BaseDados);
   if ConfigModulos.Academico then
   begin
     GridIndice1.Columns[2].FieldName := 'i_cod_mat';
     GridIndice1.Columns[2].Title.Caption := 'Matricula';
     GridIndice1.Columns[1].Title.Caption := 'Aluno';
   end;
//   LabelNome1.ANroNome := varia.TipoNome;
   RPeriodo.ItemIndex := 0;
   DataParcela1.Date := PrimeiroDiaMes(date);
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   DataParcela2.Date := UltimoDiaMes(date);
   DataParcela1.Date;
   DataParcela2.Date;
   DataBaixa.Date := (Date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaAcumuladaCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MovParcelas.close;
   CR.free;
   Action := CaFree;
end;

{********************Quando o formulario é mostrado****************************}
procedure TFBaixaAcumuladaCR.FormShow(Sender: TObject);
begin
  AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Atividades dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFBaixaAcumuladaCR.BitBtn1Click(Sender: TObject);
begin
 self.close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************** select do cliente em relacao ao clientes existente no CR *****}
procedure TFBaixaAcumuladaCR.EditLocaliza4Select(Sender: TObject);
begin
  EditLocaliza4.ASelectLocaliza.clear;
  EditLocaliza4.ASelectLocaliza.Add(' Select * from CadClientes where  c_tip_cad <> ''F'' and '+
                                    ' c_nom_cli like ''@%'' ');
  EditLocaliza4.ASelectValida.clear;
  EditLocaliza4.ASelectValida.Add(' select * from CadClientes where c_tip_cad <> ''F'' and ' +
                                  ' I_COD_CLI = @ ');
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da Movparcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFBaixaAcumuladaCR.AtualizaConsulta;
begin
  MovParcelas.Close;
  MovParcelas.SQL.Clear;
  MovParcelas.sql.Add(' select CR.I_LAN_REC, CR.C_CLA_PLA, MCR.L_OBS_REC, CR.I_SEQ_NOT,' +
                      ' CR.I_COD_CLI, CR.I_NRO_NOT, MCR.I_NRO_PAR, CR.I_COD_MAT, ' +
                      ' MCR.D_DAT_VEN, MCR.N_DES_VEN, CR.D_DAT_EMI,' +
                      ' (MCR.N_VLR_PAR * MOE.N_VLR_DIA) as N_VLR_PAR, MCR.D_DAT_PAG,' +
                      ' MCR.N_VLR_PAG, MOE.C_NOM_MOE, CR.I_EMP_FIL, ' +
                      ' C.C_NOM_CLI, P.C_NOM_PLA, CR.D_DAT_MOV, ' +
                      ' MCR.C_NRO_DUP,' +
                      ' FRM.C_NOM_FRM,' +
                      ' MCR.N_PER_MUL, MCR.N_PER_JUR, MCR.N_VLR_DES, ' +
                      ' MCR.N_VLR_ACR, MCR.N_PER_MOR, MCR.N_DES_VEN, MCR.N_VLR_ADI ' +
                      ' From ' +
                      ' MovContasaReceber as MCR, ' +
                      ' CadContasaReceber as CR, ' +
                      ' CadClientes as C, '+
                      ' CAD_PLANO_CONTA as P, ' +
                      ' CadFormasPagamento as FRM, ' +
                      ' CadMoedas as MOE ');
  AdicionaFiltros(MovParcelas.SQL);
  MovParcelas.SQL.Add(' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                      ' and CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                      ' and CR.I_COD_CLI = C.I_COD_CLI ' +
                      ' and CR.C_CLA_PLA = P.C_CLA_PLA ' +
                      ' and CR.I_COD_EMP = P.I_COD_EMP ' +
                      ' and MCR.I_COD_FRM *= FRM.I_COD_FRM ' +
                      ' and MCR.I_COD_MOE = MOE.I_COD_MOE ' +
                      ' and ISNULL(MCR.C_DUP_CAN, ''N'') <> ''S''');
  MovParcelas.Open;
end;

{************************ Adiciona Filtros da Select **************************}
procedure TFBaixaAcumuladaCR.AdicionaFiltros(VpaSelect : TStrings);
begin
  VpaSelect.Add('  where CR.I_EMP_FIL  = ' + IntToStr(Varia.CodigoEmpFil));
  VpaSelect.add(SQLTextoDataEntreAAAAMMDD( 'd_dat_ven', DataParcela1.DateTime, dataParcela2.DateTime, true));


  if EditLocaliza4.Text <> '' then
    VpaSelect.Add(' and CR.I_COD_CLI = ' + EditLocaliza4.Text)
  else
    VpaSelect.add(' ');

  if EdcFormaPgto.Text <> '' then
    VpaSelect.Add(' and MCR.I_COD_FRM = ' + EdcFormaPgto.Text)
   else
    VpaSelect.Add(' ');

  if Bloqueto <> '' then
      VpaSelect.Add(' and MCR.I_LAN_REC not in  ( ' + Bloqueto + ')')
   else
    VpaSelect.Add(' ');

  VpaSelect.Add(' AND MCR.D_DAT_PAG is null' );

  if numerico1.AValor <> 0 then
    VpaSelect.Add(' AND CR.I_NRO_NOT = ' + Inttostr(trunc(numerico1.avalor)) );

  case RPeriodo.ItemIndex of

     // VENCIMENTO;
     0 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_VEN',
         DataParcela1.Date, DataParcela2.Date, true) + ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');

     // EMISSÃO.
     1 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',
         DataParcela1.Date, DataParcela2.Date, true) + ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');

     // PAGAMENTO.
     2 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_PAG',
         DataParcela1.Date, DataParcela2.Date, true) + ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');

    // CADASTRO.
     3 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CR.D_DAT_MOV',
         DataParcela1.Date, DataParcela2.Date, true) + ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');
  end;


{********************* Procedure que muda estado dos Componntes **************}
end;

{**********************  Lê os secionados e mostra na Lista Baixa *************}
function TFBaixaAcumuladaCR.MostraLista : Double;
var
  Laco : integer;
begin
  Result := 0;
  Bloqueto := '';
  for Laco := 0 to ListaBaixa.Items.Count - 1 do
  begin
    if Laco <> 0 then
      Bloqueto := Bloqueto + ',';
      Result := Result + TBaixa(ListaBaixa.Items.Objects[Laco]).Valor;
      Bloqueto := Bloqueto + Inttostr(TBaixa(ListaBaixa.Items.Objects[Laco]).NroBloqueto);
  end;
end;


{******************Chama a rotina para atualizar a consulta********************}
procedure TFBaixaAcumuladaCR.TipoDataParcelaChange(Sender: TObject);
begin
   AtualizaConsulta;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFBaixaAcumuladaCR.DataParcela1Change(Sender: TObject);
begin
    AtualizaConsulta;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFBaixaAcumuladaCR.SitParClick(Sender: TObject);
begin
     AtualizaConsulta;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFBaixaAcumuladaCR.BitBtn9Click(Sender: TObject);
begin
   AtualizaConsulta;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}



{****************** Retorno do Edit que localiza Filial *********************}
procedure TFBaixaAcumuladaCR.EditLocaliza5Retorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;


{************************ Açao do Botao apos Cancelar ***********************}
procedure TFBaixaAcumuladaCR.BbCancelarClick(Sender: TObject);
begin
 Bloqueto := '';
 ValorBaixa.Text := '0,00';
 DescBan.Text := '0,00';
 CredBan.Text := '0,00';
 ListaBaixa.Items.Clear;
 AtualizaConsulta;
end;

{****************** Seleciona Item e joga o mesmo para Lista ******************}
procedure TFBaixaAcumuladaCR.BSelecionaUmClick(Sender: TObject);
var
  Dados : TBaixa;
  multa, mora, juro, desconto, TotalAcrescimo, TotalDescontos : double;
begin
  // verifica se pode baixar esta parcela
  if cr.ValidaParcelaPagamento(MovParcelasI_LAN_REC.AsInteger,MovParcelasD_DAT_VEN.AsDateTime) then
  begin

    multa := MovParcelasN_PER_MUL.AsCurrency;
    mora := MovParcelasN_PER_MOR.AsCurrency;
    juro := MovParcelasN_PER_JUR.AsCurrency;
    desconto := MovParcelasN_DES_VEN.AsCurrency;

    InTToStr(CR.CalculaJuros( multa, mora, juro, desconto,
                              MovParcelasD_DAT_VEN.AsDateTime, date,
                              MovParcelasN_VLR_PAR.AsCurrency ));
    TotalAcrescimo := multa + mora + juro + BaixaN_VLR_ACR.AsCurrency;
    if TotalAcrescimo <> 0 then
      if not confirmacao('Esta parcela possui ' + FormatFloat(varia.MascaraMoeda,TotalAcrescimo) + ' de acréscimo, você deseja manter ? ') then
        TotalAcrescimo := 0;

    TotalDescontos := desconto + MovParcelasN_VLR_DES.AsCurrency;
    if TotalDescontos <> 0 then
      if not confirmacao('Esta parcela possui ' + FormatFloat(varia.MascaraMoeda,TotalDescontos) + ' de desconto, você deseja manter ? ') then
        TotalDescontos := 0;

//    Total := MovParcelasN_VLR_PAR.AsCurrency + MovParcelasN_VLR_ADI.AsCurrency + TotalAcrescimo - TotalDescontos;

    if not MovParcelas.IsEmpty then     // Se Tabela ñ estiver vazia
    begin
      Dados := TBaixa.create; // herda classe
      Dados.CodEmpFil := MovParcelasI_EMP_FIL.AsInteger;
      Dados.CodLanrec := MovParcelasI_LAN_REC.AsInteger;
      Dados.NroParcela := MovParcelasI_NRO_PAR.AsInteger;
      Dados.NroBloqueto := MovParcelasI_LAN_REC.AsInteger;
      Dados.NroDuplicata := MovParcelasC_NRO_DUP.AsString;
      Dados.ValorDesconto := TotalDescontos;
      Dados.ValorAcrescimo := TotalAcrescimo;
      Dados.Adicionais := MovParcelasN_VLR_ADI.AsCurrency;
      Dados.ValorOri := MovParcelasN_VLR_PAR.AsCurrency;
      Dados.Valor := Dados.ValorOri + Dados.Adicionais + Dados.ValorAcrescimo - Dados.ValorDesconto;

      ListaBaixa.Items.AddObject('Parcela : ' + AdicionaBrancoDE(MovParcelasC_NRO_DUP.AsString,15) +  ' : ' +
                               FormatFloat(Varia.MascaraMoeda, Dados.Valor),
                               dados); // Lê e mostra o texto na Lista
      ValorBaixa.AValor := MostraLista; // valor total
      CredBan.AValor := (ValorBaixa.AValor) - (DescBan.AValor) ;//Recebe o Valor das Baixas menos deconto do banco
      if BSelecionaUm.Focused then
        AtualizaConsulta;
    end;
  end;
end;

{***************** Seleciona Todos os Items da ListaBaixa ******************}
procedure TFBaixaAcumuladaCR.BSelTodosClick(Sender: TObject);
begin
  MovParcelas.First;
  while not MovParcelas.Eof do //Se tebela ñ estiver no final //EOF-end of file
  begin
    BSelecionaUmClick(nil);
    MovParcelas.next; // ler o proximo
  end;
  AtualizaConsulta;
end;

{**************************** Excluir Item da ListaBaixa *******************}
procedure TFBaixaAcumuladaCR.BExcluirClick(Sender: TObject);
begin
  if (ListaBaixa.Items.Count <> 0) and (ListaBaixa.ItemIndex <> -1) then
  begin
    ListaBaixa.Items.Delete(ListaBaixa.ItemIndex);
    ValorBaixa.AValor := MostraLista;
    CredBan.AValor := MostraLista;
    AtualizaConsulta;
  end;
end;

{************** Recebe o Valor das Baixas menos deconto do banco *************}
procedure TFBaixaAcumuladaCR.DescBanExit(Sender: TObject);
begin
  CredBan.AValor := (ValorBaixa.AValor) - (DescBan.AValor) ;
end;

procedure TFBaixaAcumuladaCR.EformaPgtoRetorno(Retorno1, Retorno2: String);
begin
  lconta.Enabled := retorno1 = 'B';
  econta.Enabled := retorno1 = 'B';
  SpeedButton2.Enabled := retorno1 = 'B';
  label6.Enabled := retorno1 = 'B';
  TipoFRMPagto := retorno2;
end;


{*************** confirma a baixa ******************************************** }
procedure TFBaixaAcumuladaCR.BaixaConta;
var
  Dados : TDadosBaixaCR;
  laco,LancamentoBancario : integer;
  baixar : Boolean;
begin
  baixar := true;
  if (ConfigModulos.Bancario) and (econta.Enabled) then
  begin
    FDepositoCheque := TFDepositoCheque.CriarSDI(application, '', FPrincipal.VerificaPermisao('FDepositoCheque'));
    baixar := FDepositoCheque.cobranca(Credban.AValor, LancamentoBancario, EConta.Text);
  end;

  if baixar then
  begin
    for laco := 0 to ListaBaixa.Items.Count - 1 do
    begin

      // localiza contas a receber
      cr.LocalizaJoinContaNroParcelas(baixa,TBaixa(ListaBaixa.Items.Objects[Laco]).CodLanrec,
                                            TBaixa(ListaBaixa.Items.Objects[Laco]).NroParcela);

      // atualiza nroconta e banco
      CR.AtualizaMovFormaNroConta( BaixaI_EMP_FIL.AsInteger, BaixaI_LAN_REC.AsInteger,
                                   BaixaI_NRO_PAR.AsInteger,EConta.Text);

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
          Dados.DataPagamento := dataBaixa.DateTime;
          Dados.ValorAdicionais := BaixaN_VLR_ADI.ascurrency;
          Dados.ValorDesconto := TBaixa(ListaBaixa.Items.Objects[Laco]).ValorDesconto;
          Dados.valorAcrescimo := TBaixa(ListaBaixa.Items.Objects[Laco]).ValorAcrescimo;
          Dados.ValorPago := TBaixa(ListaBaixa.Items.Objects[Laco]).Valor;
          Dados.VerificarCaixa := config.Baixa_CR_CP_Caixa;
          Dados.TipoFrmPagto := TipoFRMPagto;
          Dados.LancarBanco := false;
          dados.planoConta := BaixaC_CLA_PLA.AsString;
          dados.CodFormaPAgamento := strToInt(EformaPgto.text);
          dados.VerficarFormaPagamento := true;
          dados.ValorTotalAserPago := TBaixa(ListaBaixa.Items.Objects[Laco]).Valor;
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
            cr.AtualizaLancamentobancarioCR(BaixaI_LAN_REC.AsInteger,BaixaI_NRO_PAR.AsInteger,inttostr(LancamentoBancario));
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
      end;
    end;
    ListaBaixa.clear;
    Bloqueto := '';
    AtualizaConsulta;
  end;
end;


procedure TFBaixaAcumuladaCR.BBaixarClick(Sender: TObject);
begin
  if cr.VerificaCaixaAtivo(true) then
  begin
    if ListaBaixa.Items.Count > 0 then
    begin
      if EformaPgto.Text <> '' then
        if (EConta.enabled) and (EConta.text = '') then
          aviso('Informe a conta ')
         else
          BaixaConta
      else
        aviso('Informe a forma de pagamento!');
     end
     else
       aviso('Não existe nenhuma conta selecionada para baixar !');
  end;
end;

procedure TFBaixaAcumuladaCR.EformaPgtoSelect(Sender: TObject);
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

procedure TFBaixaAcumuladaCR.DataBaixaChange(Sender: TObject);
begin
  if (config.DataBaixaMenor) then  //RETROATIVO DIA
    if DataBaixa.DateTime < date then
    begin
      aviso(CT_DataMenorBAixa);
      if DataBaixa.Enabled then
        DataBaixa.SetFocus;
    end;

  if not ValidaDataRetroativa(DataBaixa.DateTime) then // RETRATIVO MES
    if DataBaixa.Enabled then
      DataBaixa.SetFocus;
end;

procedure TFBaixaAcumuladaCR.BitBtn2Click(Sender: TObject);
var
  Acrescimo : string;
begin
  if (ListaBaixa.ItemIndex <> -1) and (ListaBaixa.Items.Count <> 0 ) then
  begin
     Acrescimo := floattostr(TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorAcrescimo);
     if EntradaNumero('Acréscimo', 'Valor do Acréscimo',Acrescimo,false,
                       FPrincipal.CorFoco.AFundoComponentes,FPrincipal.CorForm.ACorPainel,
                       true) then
     begin
        TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorAcrescimo := strtofloat(Acrescimo);
        TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).Valor :=
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorOri +
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).Adicionais +
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorAcrescimo -
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorDesconto;
        ListaBaixa.Items.Strings[ListaBaixa.itemindex] := ('Parcela : ' + AdicionaBrancoDE(TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).NroDuplicata,15) +  ' : ' +
                                                           FormatFloat(Varia.MascaraMoeda, TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).Valor));
        ValorBaixa.AValor := MostraLista; // valor total
        CredBan.AValor := (ValorBaixa.AValor) - (DescBan.AValor) ;//Recebe o Valor das Baixas menos deconto do banco
     end;
   end;
end;

procedure TFBaixaAcumuladaCR.BitBtn3Click(Sender: TObject);
var
  Desconto : string;
begin
  if (ListaBaixa.ItemIndex <> -1) and (ListaBaixa.Items.Count <> 0 ) then
  begin
     desconto := floattostr(TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorDesconto);
     if EntradaNumero( 'Desconto', 'Valor do Desconto',desconto,false,
                       FPrincipal.CorFoco.AFundoComponentes, FPrincipal.CorForm.ACorPainel,
                       true) then
     begin
        TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorDesconto := strToFloat(Desconto);
        TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).Valor :=
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorOri +
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).Adicionais +
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorAcrescimo -
              TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).ValorDesconto;
        ListaBaixa.Items.Strings[ListaBaixa.itemindex] := ('Parcela : ' + AdicionaBrancoDE(TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).NroDuplicata,15) +  ' : ' +
                                                           FormatFloat(Varia.MascaraMoeda, TBaixa(ListaBaixa.Items.Objects[ListaBaixa.itemindex]).Valor));
        ValorBaixa.AValor := MostraLista; // valor total
        CredBan.AValor := (ValorBaixa.AValor) - (DescBan.AValor) ;//Recebe o Valor das Baixas menos deconto do banco
     end;
   end;  
end;

Initialization
  RegisterClasses([TFBaixaAcumuladaCR]);
end.
