unit ADepositoCheque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ComCtrls, Componentes1, StdCtrls, Localizacao, Buttons, ExtCtrls,
  PainelGradiente, Db, DBTables, Mask, numericos, DBKeyViolation, Uncaixa ;

type
  TFDepositoCheque = class(TFormularioPermissao)
    Localiza: TConsultaPadrao;
    Aux: TQuery;
    PainelGradiente1: TPainelGradiente;
    PBancos: TPanelColor;
    Label32: TLabel;
    Label28: TLabel;
    BConta: TSpeedButton;
    Label26: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    LPlano: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Label5: TLabel;
    BTransfereBanco: TBitBtn;
    EConta: TEditLocaliza;
    ENumeroDocumento: TEditColor;
    EData: TCalendario;
    BitBtn2: TBitBtn;
    EOBancaria: TEditLocaliza;
    EPlano: TEditColor;
    Label1: TLabel;
    ETipoOperacao: TEditLocaliza;
    BTipoOpera: TSpeedButton;
    LTipoOpera: TLabel;
    Label29: TLabel;
    EFormaPagtoSangriaSuprimento: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label27: TLabel;
    Evalor: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    Eoutros: Tnumerico;
    Label7: TLabel;
    Edeposito: Tnumerico;
    ValidaGravacao1: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure BTransfereBancoClick(Sender: TObject);
    procedure EContaChange(Sender: TObject);
    procedure EoutrosChange(Sender: TObject);
  private
    UnCaixa : TFuncoesCaixa;
    acao : Boolean;
    LanBanco : integer;
  public
    function AbreTransferencia(valor : double; Var LanBancario : Integer) : Boolean;
    Function Cobranca(valor : double; Var LanBancario : Integer; NroConta : string) : Boolean;
  end;

var
  FDepositoCheque: TFDepositoCheque;

implementation

uses APlanoConta, APrincipal, UnBancario, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDepositoCheque.FormCreate(Sender: TObject);
begin
  UnCaixa := TFuncoesCaixa.criar(self, FPrincipal.BaseDados);
  EData.DateTime := date;
  acao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDepositoCheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnCaixa.free;
  Action := CaFree;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFDepositoCheque.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo( VpfCodigo, 'C', LPlano, false,(Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;

procedure TFDepositoCheque.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 114 then
    EPlanoExit(SpeedButton2);
end;

procedure TFDepositoCheque.BitBtn2Click(Sender: TObject);
begin
  acao := false;
  Self.close;
end;

procedure TFDepositoCheque.BTransfereBancoClick(Sender: TObject);
var
  UnBanco : TFuncoesBancario;
  Dados : TDadosBaixaMovBan;
begin
  //banco
  UnBanco := TFuncoesBancario.criar(self, FPrincipal.BaseDados);
  Dados := TDadosBaixaMovBan.Create;
  Dados.NumeroConta := EConta.text;
  Dados.DataComp := EData.DateTime;
  Dados.NroDocumento := ENumeroDocumento.text;
  Dados.OperacaoBancaria := EOBancaria.Text;
  Dados.CodigoPlano := EPlano.text;
  Dados.ValorEntrada := Edeposito.AValor;
  Dados.ValorSaida := 0;
  LanBanco := UnBanco.AdicionaMovbancario(Dados, 0, False, true);
  Dados.Free;
  UnBanco.free;

  if ETipoOperacao.Visible then
    if ConfigModulos.Caixa then
    begin
      UnCaixa.LancaItemCaixa( 'D','', date,StrtoInt(ETipoOperacao.text), strToInt(EFormaPagtoSangriaSuprimento.text),
                              0,0,UnCaixa.SequencialGeralAberto(varia.CaixaPadrao),
                                  UnCaixa.SequencialParcialAberto(varia.CaixaPadrao),
                              Edeposito.AValor,0,Edeposito.AValor,LanBanco,'N');
    end;
  acao := true;
  self.close;
end;

function TFDepositoCheque.AbreTransferencia(valor : double; Var LanBancario : Integer) : Boolean;
begin
  result := false;
  Evalor.AValor := valor;
  Edeposito.AValor := valor;
  if ConfigModulos.Caixa then
  begin
    if UnCaixa.CaixaAtivo(varia.CaixaPadrao) then
    begin
      self.ShowModal;
      LanBancario := LanBanco;
      result := acao;
    end
    else
      self.close;
  end
  else
  begin
    label1.Enabled := false;
    Label29.Enabled := false;
    ETipoOperacao.ACampoObrigatorio := false;
    EFormaPagtoSangriaSuprimento.ACampoObrigatorio := false;
    ETipoOperacao.Enabled := false;
    EFormaPagtoSangriaSuprimento.Enabled := false;
    BTipoOpera.Enabled := false;
    SpeedButton4.Enabled := false;
    self.ShowModal;
    LanBancario := LanBanco;
    result := acao;
  end;
end;

procedure TFDepositoCheque.EContaChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

procedure TFDepositoCheque.EoutrosChange(Sender: TObject);
begin
  Edeposito.AValor := Evalor.AValor + Eoutros.AValor;
end;


Function TFDepositoCheque.Cobranca(valor : double; Var LanBancario : Integer; NroConta : string) : Boolean;
begin
  label2.Caption := 'Valor da Cobrança :';
  label3.Enabled := false;
  Eoutros.Enabled := false;
  Label1.Visible := false;
  label29.Visible := false;
  BTipoOpera.Visible := false;
  SpeedButton4.Visible := false;
  ETipoOperacao.ACampoObrigatorio := false;
  EFormaPagtoSangriaSuprimento.ACampoObrigatorio := false;
  ETipoOperacao.Visible := false;
  EFormaPagtoSangriaSuprimento.Visible := false;
  EConta.Text := nroConta;
  EConta.Enabled := false;
  BConta.Enabled := false;
  label28.Enabled := false;
  BTransfereBanco.Caption := 'Lançar no Banco';
  Evalor.AValor := valor;
  EDeposito.AValor := valor;
  self.ShowModal;
  LanBancario := LanBanco;
  result := acao;
end;


Initialization
 RegisterClasses([TFDepositoCheque]);
end.
