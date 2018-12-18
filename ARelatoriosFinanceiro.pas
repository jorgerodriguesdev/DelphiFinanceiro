unit ARelatoriosFinanceiro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  UCrpe32, StdCtrls, Buttons, Componentes1, ComCtrls, ExtCtrls,
  PainelGradiente, Localizacao, Mask, DBCtrls, Tabela, DBTables,
  Db, Grids, DBGrids, numericos;

type
  TFRelatoriosFinanceiro = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Rel: TCrpe;
    BBotao: TBitBtn;
    Localiza: TConsultaPadrao;
    BFechar: TBitBtn;
    ScrollBox1: TScrollBox;
    Fundo: TPanelColor;
    PFilial: TPanelColor;
    Label24: TLabel;
    SpeedButton1: TSpeedButton;
    LFilial: TLabel;
    EFIlial: TEditLocaliza;
    PPeriodo: TPanelColor;
    Label4: TLabel;
    Data1: TCalendario;
    Data2: TCalendario;
    PCodVendedor: TPanelColor;
    LbVendedores: TLabel;
    SpeedButton4: TSpeedButton;
    LVendedor: TLabel;
    EVendedor: TEditLocaliza;
    PCodClientes: TPanelColor;
    Label18: TLabel;
    SpeedButton2: TSpeedButton;
    LCliente: TLabel;
    Eclientes: TEditLocaliza;
    PignoraPeriodo: TPanelColor;
    IgnorarPeriodo: TCheckBox;
    PForcenecedor: TPanelColor;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Lfornecedor: TLabel;
    EFornecedor: TEditLocaliza;
    PBanco: TPanelColor;
    PTipoSituacaoCP: TPanelColor;
    PFormaPagto: TPanelColor;
    Label20: TLabel;
    EFormaPgto: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    LFormaPagto: TLabel;
    Label3: TLabel;
    TipoSituacaoCP: TComboBoxColor;
    LBanco: TLabel;
    EBanco: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Lbancos: TLabel;
    PSituacao: TPanelColor;
    POpebancaria: TPanelColor;
    PtipoBanco: TPanelColor;
    POrdemContas: TPanelColor;
    LOrdem: TLabel;
    OrdemContas: TComboBoxColor;
    Label5: TLabel;
    TipoBanco: TComboBoxColor;
    Label11: TLabel;
    EOpeBancos: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    LOpebancaria: TLabel;
    Label2: TLabel;
    ESituacao: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    LSituacao: TLabel;
    PConta: TPanelColor;
    LConta: TLabel;
    SpeedButton9: TSpeedButton;
    Econta: TEditLocaliza;
    Label6: TLabel;
    Aux2: TQuery;
    Aux2I_COD_CLI: TIntegerField;
    Aux2D_DAT_VEN: TDateField;
    Aux2D_DAT_EMI: TDateField;
    Aux2I_NRO_NOT: TIntegerField;
    Aux2I_TIP_CAD: TStringField;
    Aux2D_DAT_PAG: TDateTimeField;
    Aux2N_VLR_CCR: TFloatField;
    Aux2N_VLR_CCP: TFloatField;
    Aux2I_NRO_PAR: TIntegerField;
    Aux: TQuery;
    Aux3: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBotaoClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IgnorarPeriodoClick(Sender: TObject);
    procedure RelExecuteBegin(Sender: TObject; var Cancel: Boolean);
    procedure RelExecuteEnd(Sender: TObject);
    procedure EFIlialSelect(Sender: TObject);
  private
    Identificador : string;
    VetorMascara : array [1..6] of byte;
    function DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
    function SomaPainel : integer;
    procedure ConfiguraPainels( NomeParametro : string);
    function RetornaParametro( NomeParametro : string) : string;
    function TextoDosFiltros : string;
    function AdicionaRegCP_CR(TipoRel : integer) : double;
  public
    function CarregaConfig(NomeRel, TituloForm : string) : Boolean;
  end;

var
  FRelatoriosFinanceiro: TFRelatoriosFinanceiro;

implementation

uses funstring, fundata, constantes, funObjeto, APrincipal, constmsg,
  AInicio, funsql, unFluxo;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Formulario
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFRelatoriosFinanceiro.FormCreate(Sender: TObject);
begin
  EFIlial.APermitirVazio := Varia.FilialUsuario = '';
  data1.DateTime := PrimeiroDiaMes(date);
  data2.DateTime := UltimoDiaMes(date);
  DesmontaMascara(vetormascara, varia.MascaraPlanoConta);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRelatoriosFinanceiro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aux.close;
  aux2.close;
  Action := CaFree;
end;

{****************** no show do formulario *********************************** }
procedure TFRelatoriosFinanceiro.FormShow(Sender: TObject);
begin
  EFIlial.Text := IntToStr(varia.CodigoEmpFil);
  EFIlial.Atualiza;
  TipoSituacaoCP.ItemIndex := 0;
  TipoBanco.ItemIndex := 0;
  OrdemContas.ItemIndex := 0;
end;

{****************** fecha o formulario ************************************** }
procedure TFRelatoriosFinanceiro.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{************* Gera Registro co contas a pagar e receber *********************}
function TFRelatoriosFinanceiro.AdicionaRegCP_CR(TipoRel : integer) : double;
var
  UnFlu : TFuncoesFluxo;
begin
   UnFlu := TFuncoesFluxo.criar(self,FPrincipal.BaseDados);
  // limpa temporaria bancos
   ExecutaComandoSql(aux2,' delete temporariabanco');
  // limpa temporaria contas
   ExecutaComandoSql(aux2,' delete temporariacpcr');

   LimpaSQLTabela(Aux);
   UnFlu.LocalizaDadosBancos(aux,date);
   AdicionaSQLAbreTabela(aux3,' Select * from temporariaBanco');
   result := 0;
   while not aux.Eof do
   begin
     aux3.insert;
     aux3.FieldByName('N_SAL_ATU').AsCurrency := aux.FieldByName('N_SAL_ATU').AsCurrency;
     aux3.FieldByName('C_NRO_CON').AsString := aux.FieldByName('C_NRO_CON').AsString;
     result := result + aux.FieldByName('N_SAL_ATU').AsCurrency;
     Aux3.post;
     aux.next;
   end;

   LimpaSQLTabela(Aux);
   AdicionaSQLTabela(aux,' select * from cadcontasareceber cad ' +
                         ' key join movcontasareceber mov ' );

   AdicionaSQLTabela(aux,' where cad.i_emp_fil = ' + EFIlial.text );
   case TipoRel of
     0 : AdicionaSQLTabela(aux,SQLTextoDataEntreAAAAMMDD('mov.d_dat_ven',data1.DateTime,data2.DateTime, true) );
     1 : AdicionaSQLTabela(aux,SQLTextoDataEntreAAAAMMDD('cad.d_dat_emi',data1.DateTime,data2.DateTime, true) );
     2 : AdicionaSQLTabela(aux,SQLTextoDataEntreAAAAMMDD('mov.d_dat_pag',data1.DateTime,data2.DateTime, true) );
   end;
   case TipoSituacaoCP.ItemIndex of
     0 : AdicionaSQLTabela(aux,' ');
     1 : AdicionaSQLTabela(aux,' and mov.d_dat_pag is not null ');
     2 : AdicionaSQLTabela(aux,' and mov.d_dat_pag is null ' );
   end;
   AdicionaSQLTabela(aux,' and mov.c_dup_can = ''N''' );
   AbreTabela(aux);

   AdicionaSQLAbreTabela(aux2,' Select * from temporariaCPCR');
   while not aux.eof do
   begin
     aux2.insert;
     Aux2I_COD_CLI.AsInteger := aux.fieldByName('i_cod_cli').AsInteger;
     Aux2D_DAT_VEN.AsDateTime := aux.fieldByName('d_dat_ven').AsDateTime;
     Aux2D_DAT_EMI.AsDateTime := aux.fieldByName('d_dat_emi').AsDateTime;
     Aux2N_VLR_CCP.AsFloat := 0;
     Aux2N_VLR_CCR.AsFloat := aux.fieldByName('N_vlr_par').AsFloat;
     Aux2I_NRO_NOT.AsInteger := aux.fieldByName('i_nro_not').AsInteger;
     Aux2I_NRO_PAR.AsInteger := aux.fieldByName('i_nro_par').AsInteger;
     Aux2I_TIP_CAD.AsString := 'R';
     Aux2.post;
     aux.next;
   end;

   LimpaSQLTabela(Aux);
   AdicionaSQLTabela(aux,' select * from cadcontasapagar cad ' +
                         ' key join movcontasapagar mov ' );

   AdicionaSQLTabela(aux,' where cad.i_emp_fil = ' + EFIlial.text );
   case TipoRel of
     0 : AdicionaSQLTabela(aux,SQLTextoDataEntreAAAAMMDD('mov.d_dat_ven',data1.DateTime,data2.DateTime, true) );
     1 : AdicionaSQLTabela(aux,SQLTextoDataEntreAAAAMMDD('cad.d_dat_emi',data1.DateTime,data2.DateTime, true) );
     2 : AdicionaSQLTabela(aux,SQLTextoDataEntreAAAAMMDD('mov.d_dat_pag',data1.DateTime,data2.DateTime, true) );
   end;
   case TipoSituacaoCP.ItemIndex of
     0 : AdicionaSQLTabela(aux,' ');
     1 : AdicionaSQLTabela(aux,' and mov.d_dat_pag is not null ');
     2 : AdicionaSQLTabela(aux,' and mov.d_dat_pag is null ' );
   end;
   AdicionaSQLTabela(aux,' and mov.c_dup_can = ''N''' );
   AbreTabela(aux);

   AdicionaSQLAbreTabela(aux2,' Select * from temporariaCPCR ');
   while not aux.eof do
   begin
     aux2.insert;
     Aux2I_COD_CLI.AsInteger := aux.fieldByName('i_cod_cli').AsInteger;
     Aux2D_DAT_VEN.AsDateTime := aux.fieldByName('d_dat_ven').AsDateTime;
     Aux2D_DAT_EMI.AsDateTime := aux.fieldByName('d_dat_emi').AsDateTime;
     Aux2N_VLR_CCP.AsFloat := aux.fieldByName('N_vlr_dup').AsFloat;
     Aux2N_VLR_CCR.AsFloat := 0;
     Aux2I_NRO_NOT.AsInteger := aux.fieldByName('i_nro_not').AsInteger;
     Aux2I_NRO_PAR.AsInteger := aux.fieldByName('i_nro_par').AsInteger;
     Aux2I_TIP_CAD.AsString := 'P';
     Aux2.post;
     aux.next;
   end;
   UnFlu.free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    funcoes de configuracao do relatorio
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******Desmonata a mascara pardão para a configuração das classificações*******}
function TFRelatoriosFinanceiro.DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
var x:byte;
    posicao:byte;
begin
  posicao:=0;
  x:=0;
  while Pos('.', mascara) > 0 do
  begin
    vetor[x]:=(Pos('.', mascara)-posicao)-1;
    inc(x);
    posicao:=Pos('.', mascara);
    mascara[Pos('.', mascara)] := '*';
  end;
  vetor[x]:=length(mascara)-posicao;
  vetor[x+1] := 1;
  DesmontaMascara:=x+1;
end;

{************************** Soma altura dos paineis ***************************}
function TFRelatoriosFinanceiro.SomaPainel : integer;
var
  laco : Integer;
begin
   result := 0;
   for laco := 0 to (Fundo.ControlCount -1) do
     if (Fundo.Controls[laco] is TPanelColor) then
       if (Fundo.Controls[laco] as TPanelColor).Visible then
         result := result + (Fundo.Controls[laco] as TPanelColor).Height;
end;

{*********************** Configura os paineis visiveis ***********************}
procedure TFRelatoriosFinanceiro.ConfiguraPainels( NomeParametro : string);
begin
  if UpperCase(NomeParametro) = 'FILIAL' then
    PFilial.Visible := true else
  if  UpperCase(NomeParametro) = 'DIAINICIO' then
  begin
    PPeriodo.Visible := true;
    Data1.Visible := true;
  end  else
  if  UpperCase(NomeParametro) = 'DIAFIM' then
  begin
    PPeriodo.Visible := true;
    Data2.Visible := true;
  end else
  if UpperCase(NomeParametro) = 'CODVENDEDOR' then
    PCodVendedor.Visible := true;
  if UpperCase(NomeParametro) = 'CODCLIENTE' then
    PCodClientes.Visible := true;
  if UpperCase(NomeParametro) = 'IGNORADATA' then
    PignoraPeriodo.Visible := true;
  if UpperCase(NomeParametro) = 'CODFORNECEDOR' then
    PForcenecedor.Visible := true;
  if UpperCase(NomeParametro) = 'CODFORMAPAGTO' then
    PFormaPagto.Visible := true;
  if UpperCase(NomeParametro) = 'TIPOSITUACAOCP' then
    PTipoSituacaoCP.Visible := true;
  if UpperCase(NomeParametro) = 'CODBANCO' then
    PBanco.Visible := true;
  if UpperCase(NomeParametro) = 'ORDEMCONTA' then
    POrdemContas.Visible := true;
  if UpperCase(NomeParametro) = 'TIPOBANCO' then
    PtipoBanco.Visible := true;
  if UpperCase(NomeParametro) = 'CODOPEBANCARIA' then
    POpebancaria.Visible := true;
  if UpperCase(NomeParametro) = 'CODSITUACAO' then
    PSituacao.Visible := true;
  if UpperCase(NomeParametro) = 'NROCONTA' then
    PConta.Visible := true;

end;

{******************** retorna o valor do parametro ***************************}
function  TFRelatoriosFinanceiro.RetornaParametro( NomeParametro : string) : string;
begin
  result := '@ERRO@';
  if UpperCase(NomeParametro) = 'TITULO' then result := 'Relatório de ' + trim(PainelGradiente1.Caption) else
  if UpperCase(NomeParametro) = 'NOMEEMPRESA' then result := Varia.NomeEmpresa + '               ' + CT_NomeEmpresa else
  if UpperCase(NomeParametro) = 'EMPRESA' then result := inttostr(varia.CodigoEmpresa) else
  if UpperCase(NomeParametro) = 'FILIAL' then result := EFilial.text else
  if UpperCase(NomeParametro) = 'DIAINICIO' then result := inttostr(dia(Data1.DateTime)) else
  if UpperCase(NomeParametro) = 'MESINICIO' then result := inttostr(mes(Data1.DateTime)) else
  if UpperCase(NomeParametro) = 'ANOINICIO' then result := inttostr(ano(Data1.DateTime)) else
  if UpperCase(NomeParametro) = 'DIAFIM' then result := inttostr(dia(Data2.DateTime)) else
  if UpperCase(NomeParametro) = 'MESFIM' then result := inttostr(mes(Data2.DateTime)) else
  if UpperCase(NomeParametro) = 'ANOFIM' then result := inttostr(ano(Data2.DateTime)) else
  if UpperCase(NomeParametro) = 'CODVENDEDOR' then result := EVendedor.Text else
  if UpperCase(NomeParametro) = 'CODCLIENTE' then result := EClientes.Text else
  if UpperCase(NomeParametro) = 'IGNORADATA' then
      begin if IgnorarPeriodo.Checked then result := '0' else result := '1' end else
  if UpperCase(NomeParametro) = 'CODFORNECEDOR' then result := EFornecedor.Text else
  if UpperCase(NomeParametro) = 'CODFORMAPAGTO' then result := EFormaPgto.Text else
  if UpperCase(NomeParametro) = 'TIPOSITUACAOCP' then result := inttostr(TipoSituacaoCP.ItemIndex) else
  if UpperCase(NomeParametro) = 'CODBANCO' then result := EBanco.Text else
  if UpperCase(NomeParametro) = 'ORDEMCONTA' then result := inttostr(OrdemContas.ItemIndex) else
  if UpperCase(NomeParametro) = 'TIPOBANCO' then result := inttostr(TipoBanco.ItemIndex) else
  if UpperCase(NomeParametro) = 'CODOPEBANCARIA' then result := EOpeBancos.Text else
  if UpperCase(NomeParametro) = 'NROCONTA' then result := Econta.Text else
  if UpperCase(NomeParametro) = 'CODSITUACAO' then result := ESituacao.Text else
  if UpperCase(NomeParametro) = 'NIVEL1' then result := inttostr(vetormascara[1]) else
  if UpperCase(NomeParametro) = 'NIVEL2' then result := inttostr(vetormascara[2]) else
  if UpperCase(NomeParametro) = 'NIVEL3' then result := inttostr(vetormascara[3]) else
  if UpperCase(NomeParametro) = 'NIVEL4' then result := inttostr(vetormascara[4]) else
  if UpperCase(NomeParametro) = 'NIVEL5' then result := inttostr(vetormascara[5]) else
  if UpperCase(NomeParametro) = 'CP_CR_VENCIMENTO' then  begin result := SubstituiStr(FloatToStr(AdicionaRegCP_CR(0)),',','.'); end else
  if UpperCase(NomeParametro) = 'CP_CR_EMISSAO' then  begin result := SubstituiStr(FloatToStr(AdicionaRegCP_CR(1)),',','.'); end else
  if UpperCase(NomeParametro) = 'CP_CR_PAGAMENTO' then  begin result := SubstituiStr(FloatToStr(AdicionaRegCP_CR(2)),',','.'); end else

    aviso('Parametro não configurado ' + NomeParametro);
end;

function TFRelatoriosFinanceiro.TextoDosFiltros : string;
begin
  result := Identificador;
  if PPeriodo.Visible then
  begin
    result := result + '-Período de ';
    if (Data1.Enabled) then result := result + datetostr(data1.date) else result := 'Todo';
    if (Data2.visible) then result := result + ' à ' + datetostr(data2.date);
  end;

  if PFilial.Visible then
  begin
    result := result + '-Filial: ';
    if EFIlial.Text <> '' then result := result + LFilial.caption else result := result + 'Todas';
  end;

  if PCodVendedor.Visible then
  begin
    result := result + '-Vendedor: ';
    if EVendedor.Text <> '' then result := result + LVendedor.caption else result := result + 'Todos';
  end;

  if PForcenecedor.Visible then
  begin
    result := result + '-Fornecedor: ';
    if EFornecedor.Text <> '' then result := result + Lfornecedor.caption else result := result + 'Todos';
  end;

  if PFormaPagto.Visible then
  begin
    result := result + '-Forma Pagto: ';
    if EFormaPgto.Text <> '' then result := result + LFormaPagto.caption else result := result + 'Todos';
  end;

  if PBanco.Visible then
  begin
    result := result + '-Banco: ';
    if EBanco.Text <> '' then result := result + LBancos.caption else result := result + 'Todos';
  end;

  if POpebancaria.Visible then
  begin
    result := result + '-Ope. Bancaria: ';
    if EOpeBancos.Text <> '' then result := result + LOpebancaria.caption else result := result + 'Todos';
  end;

  if PSituacao.Visible then
  begin
    result := result + '-Situação: ';
    if ESituacao.Text <> '' then result := result + LSituacao.Caption else result := result + 'Todos';
  end;

  if PConta.Visible then
  begin
    result := result + '-Conta : ';
    if Econta.Text <> '' then result := result + Econta.text else result := result + 'Todas';
  end;

end;

{******************** Carrega Configuracoes da tela **************************}
function TFRelatoriosFinanceiro.CarregaConfig(NomeRel, TituloForm : string) : Boolean;
var
  laco : integer;
begin
   result := false;
   PainelGradiente1.Caption := '   ' + copy(TituloForm,6,length(tituloForm)) + '   ';
   Identificador := DeletaChars(copy(TituloForm,1,5),'&');
   if FileExists(varia.PathRel + NomeRel) then
   begin
     rel.ReportName := varia.PathRel + NomeRel;

     rel.Connect.Retrieve;
     rel.Connect.DatabaseName := varia.AliasBAseDados;
     rel.Connect.ServerName := varia.AliasRelatorio;

     rel.ParamFields.Retrieve;
     for laco := 0 to rel.ParamFields.Count -1 do
       ConfiguraPainels(Rel.ParamFields[laco].Name);
     self.ClientHeight := SomaPainel + 95;
     result := true;
     fundo.Align := alClient;
   end
   else
     Aviso('Relatório não encontrado "' + varia.PathRel + NomeRel + '"');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Gera relatorio
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************  Gera o relatorio ****************************************** }
procedure TFRelatoriosFinanceiro.BBotaoClick(Sender: TObject);
var
  laco : integer;
  Parametro : string;
begin
  for laco := 0 to rel.ParamFields.Count -1 do
  begin
    Parametro := RetornaParametro(Rel.ParamFields[laco].Name);
    if Parametro = '@ERRO@' then
     abort;
    if Parametro <> '' then
      rel.ParamFields[laco].value :=  Parametro
    else
      rel.ParamFields[laco].value :=  '0';
  end;
  rel.ReportTitle := TextoDosFiltros;
  rel.Execute;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Filtros
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFRelatoriosFinanceiro.EFIlialSelect(Sender: TObject);
begin
   EFIlial.ASelectLocaliza.Text := ' Select * from CadFiliais as fil ' +
                                         ' where c_nom_fan like ''@%'' ' +
                                         ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   EFIlial.ASelectValida.Text := ' Select * from CadFiliais where I_EMP_FIL = @% ' +
                                       ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   if Varia.FilialUsuario <> '' then
   begin
     EFIlial.ASelectValida.add(' and i_emp_fil not in ( ' + Varia.FilialUsuario + ')');
     EFIlial.ASelectLocaliza.add(' and i_emp_fil not in ( ' + Varia.FilialUsuario + ')');
   end;
end;

procedure TFRelatoriosFinanceiro.IgnorarPeriodoClick(Sender: TObject);
begin
  Label4.Enabled := not IgnorarPeriodo.Checked;
  data1.Enabled := not IgnorarPeriodo.Checked;
  data2.Enabled := not IgnorarPeriodo.Checked;
end;

procedure TFRelatoriosFinanceiro.RelExecuteBegin(Sender: TObject;
  var Cancel: Boolean);
begin
  FInicio := TFInicio.Create(SELF);
  finicio.MudaTexto('Gerando Relatório...');
  FInicio.show;
  FInicio.Refresh;
end;

procedure TFRelatoriosFinanceiro.RelExecuteEnd(Sender: TObject);
begin
  Finicio.close;
end;


Initialization
 RegisterClasses([TFRelatoriosFinanceiro]);

end.
