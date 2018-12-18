unit ATransferenciaBancaria;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ComCtrls, Componentes1, Localizacao, ExtCtrls,
  PainelGradiente, DBKeyViolation, Mask, numericos;

type
  TFTransferenciaBancaria = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BTransfereBanco: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label28: TLabel;
    EContaPara: TEditLocaliza;
    BConta: TSpeedButton;
    Label26: TLabel;
    DocPara: TEditColor;
    Label32: TLabel;
    DataPara: TCalendario;
    Label4: TLabel;
    EOBancaria: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    EPlano: TEditColor;
    LPlano: TLabel;
    SpeedButton2: TSpeedButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Econtade: TEditLocaliza;
    docde: TEditColor;
    DataDe: TCalendario;
    ValidaGravacao1: TValidaGravacao;
    ConsultaPadrao1: TConsultaPadrao;
    EValor: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EcontadeChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BTransfereBancoClick(Sender: TObject);
  private
    procedure EfetuaTransferencia;
  public
    { Public declarations }
  end;

var
  FTransferenciaBancaria: TFTransferenciaBancaria;

implementation

uses APrincipal, APlanoConta, UnBancario, funobjeto, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTransferenciaBancaria.FormCreate(Sender: TObject);
begin
  DataPara.Date := date;
  DataDe.Date := date;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTransferenciaBancaria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFTransferenciaBancaria.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo( VpfCodigo, '', LPlano, false,(Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;

procedure TFTransferenciaBancaria.EPlanoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    EPlanoExit(SpeedButton2);
end;

procedure TFTransferenciaBancaria.EcontadeChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

procedure TFTransferenciaBancaria.BitBtn2Click(Sender: TObject);
begin
  self.close;
end;

procedure TFTransferenciaBancaria.EfetuaTransferencia;
var
  Dados: TDadosBaixaMovBan;
  MB: TFuncoesBancario;
begin
  Dados := TDadosBaixaMovBan.Create;
  MB := TFuncoesBancario.criar(self, FPrincipal.BaseDados);
  Dados.NumeroConta := EContaPara.Text;
  Dados.DataComp := DataPara.DateTime;
  Dados.NroDocumento := DocPara.text;
  Dados.OperacaoBancaria := EOBancaria.Text;
  Dados.CodigoPlano := EPlano.text;
  Dados.ValorEntrada := EValor.AValor;
  Dados.ValorSaida := 0;
  Dados.Observacao := 'Transferência da conta ' + Econtade.text;
  MB.AdicionaMovbancario(Dados, 0, False, true);

  Dados.NumeroConta := EContade.Text;
  Dados.DataComp := Datade.DateTime;
  Dados.NroDocumento := Docde.text;
  Dados.OperacaoBancaria := EOBancaria.Text;
  Dados.CodigoPlano := EPlano.text;
  Dados.ValorEntrada := 0;
  Dados.ValorSaida := EValor.AValor;
  Dados.Observacao := 'Transferência da conta ' + EcontaPara.text;
  MB.AdicionaMovbancario(Dados, 0, False, true);

  Dados.Free;
  MB.Destroy;
end;

procedure TFTransferenciaBancaria.BTransfereBancoClick(Sender: TObject);
begin
  if Econtade.Text <> EContaPara.text then
  begin
    if EValor.AValor <> 0 then
    begin
      EfetuaTransferencia;
      LimpaEdits(PanelColor1);
      LimpaEdits(GroupBox1);
      LimpaEdits(GroupBox2);
      label5.Caption := '';
      LPlano.Caption := '';
      EValor.AValor := 0;
    end
    else
    begin
      aviso('O valor de transferência não pode estar nulo.');
      EValor.SetFocus;
    end;
  end
  else
    aviso('A traferência não pode ser efetuada para uma mesma conta.');

end;

Initialization
 RegisterClasses([TFTransferenciaBancaria]);
end.
