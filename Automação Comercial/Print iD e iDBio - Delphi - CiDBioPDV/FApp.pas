unit FApp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ControliD, Vcl.StdCtrls, StrUtils,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.CheckLst, UProduct, UProductService, UOrderService, UOrder, FCreateUser, UFingerService, UFinger, UUser;

type
  TFormApp = class(TForm)
    ButtonUnlock: TButton;
    ComboBoxProduct: TComboBox;
    LabelProduct: TLabel;
    LabelProductQuantity: TLabel;
    EditProductQuantity: TEdit;
    ButtonAddToCart: TButton;
    CheckListBoxCart: TCheckListBox;
    ButtonRemoveCartItem: TButton;
    LabelCart: TLabel;
    ButtonCheckout: TButton;
    ButtonLock: TButton;
    LabelProductPrice: TLabel;
    LabelTotalPrice: TLabel;
    ButtonCreateUser: TButton;
    ButtonPrintTicket: TButton;
    LabelGreeting: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure EditProductQuantityExit(Sender: TObject);
    procedure ButtonRemoveCartItemClick(Sender: TObject);
    procedure ButtonUnlockClick(Sender: TObject);
    procedure ButtonLockClick(Sender: TObject);
    procedure ComboBoxProductClick(Sender: TObject);
    procedure EditProductQuantityKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonAddToCartClick(Sender: TObject);
    procedure ButtonCreateUserClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure LockApp;
    procedure UnlockApp;
    procedure ChangeComponentsVisibility(Visible: boolean);
    procedure UpdateProductPrice;
    procedure NormalizeProductQuantity;
    procedure UpdateProductsInComboBox(Products: TList);
    procedure AddProductToComboBox(Product: TProduct);
    procedure UpdateOrdersInComboBox;
    procedure AddOrderToComboBox(Order: TOrder);
    procedure UpdateTotalPrice;

    function GetIDFromSelectedProduct: integer;
    function GetProductQuantity: integer;
  public
    { Public declarations }
  end;

var
  FormApp: TFormApp;
  LeitorBiometrico: CIDBio;
  ProductService: TProductService;
  OrderService: TOrderService;
  FingerService: TFingerService;

implementation

{$R *.dfm}

procedure TFormApp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LeitorBiometrico.DeleteAllTemplates;
  LeitorBiometrico.Terminate;
end;

procedure TFormApp.FormCreate(Sender: TObject);
var
  Product: TProduct;
  Products: TList;

begin
  LockApp;

  CheckListBoxCart.MultiSelect := True;

  LeitorBiometrico := CIDBio.Create;
  LeitorBiometrico.Init;

  ProductService := TProductService.Create;
  Products := ProductService.CreateDefaults;
  UpdateProductsInComboBox(Products);

  OrderService := TOrderService.Create;

  FingerService := TFingerService.Create;
end;

function TFormApp.GetIDFromSelectedProduct: integer;
begin
  Result := 0;

  if ComboBoxProduct.ItemIndex < 0 then exit;

  Result := Integer(ComboBoxProduct.Items.Objects[ComboBoxProduct.ItemIndex]);
end;

function TFormApp.GetProductQuantity: integer;
begin
  Result := 0;

  if EditProductQuantity.Text <> '' then
  begin
    Result := StrToInt(EditProductQuantity.Text);
  end;
end;

procedure TFormApp.AddOrderToComboBox(Order: TOrder);
begin
  CheckListBoxCart.AddItem(Order.GetDisplayName, TObject(Order.ID));
end;

procedure TFormApp.UpdateProductsInComboBox(Products: TList);
var
  Product: TProduct;
begin
  ComboBoxProduct.Items.Clear;

  for Product in Products do
  begin
    AddProductToComboBox(Product);
  end;
end;

procedure TFormApp.AddProductToComboBox(Product: TProduct);
begin
  ComboBoxProduct.AddItem(Product.Name, TObject(Product.ID));
end;

procedure TFormApp.ButtonAddToCartClick(Sender: TObject);
var
  ProductID, Quantity: integer;
  Product: TProduct;
  Order: TOrder;
begin
  ProductID := GetIDFromSelectedProduct;

  if ProductID = 0 then
  begin
    ShowMessage('Selecione um produto!');
    exit;
  end;

  Product := ProductService.FindByID(ProductID);
  Quantity := GetProductQuantity;

  OrderService.CreateOrder(Product, Quantity);
  UpdateOrdersInComboBox;

  UpdateTotalPrice;
end;

procedure TFormApp.ButtonCreateUserClick(Sender: TObject);
begin
  with TFormCreateUser.Create(nil) do
  begin
    try
      ShowModal;
    finally
      Free
    end;
  end;
end;

procedure TFormApp.ButtonLockClick(Sender: TObject);
begin
  LockApp;
end;

procedure TFormApp.ButtonRemoveCartItemClick(Sender: TObject);
var
  I, ID: Integer;
  Order: TOrder;
begin
  for I := 0 to (CheckListBoxCart.Count - 1) do
  begin
    if (not CheckListBoxCart.Checked[I]) then Continue;

    ID := Integer(CheckListBoxCart.Items.Objects[I]);

    OrderService.DeleteByID(ID);
  end;

  UpdateOrdersInComboBox;
  UpdateTotalPrice;
end;

procedure TFormApp.ButtonUnlockClick(Sender: TObject);
var
  ID: Int64;
  Score, Quality: Integer;
  Code: RetCode;
  Finger: TFinger;
  UserID: integer;
  User: TUser;

begin
  Code := LeitorBiometrico.CaptureAndIdentify(ID, Score, Quality);

  if RetCode.ERROR_NOT_IDENTIFIED = Code then
  begin
    ShowMessage('Não identificado, tente novamnete...');
    exit;
  end;

  Finger := FingerService.IdentifyByID(ID);

  if Finger = nil then
  begin
    ShowMessage('Não identificado, tente novamnete...');
    exit;
  end;

  UserID := Finger.UserID;

  User := UserService.FindByID(UserID);

  LabelGreeting.Caption := 'Olá ' + User.Name + '!';

  UnlockApp;
end;

procedure TFormApp.EditProductQuantityExit(Sender: TObject);
begin
  NormalizeProductQuantity;
  UpdateProductPrice;
end;

procedure TFormApp.EditProductQuantityKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  UpdateProductPrice;
end;

procedure TFormApp.ComboBoxProductClick(Sender: TObject);
begin
  UpdateProductPrice;
end;

procedure TFormApp.LockApp;
begin
  ChangeComponentsVisibility(False);
  ButtonUnlock.Enabled := True;
  ButtonCreateUser.Enabled := True;
end;

procedure TFormApp.NormalizeProductQuantity;
var
  Text: string;
begin
  Text := EditProductQuantity.Text;

  if (Text = '') or (Text = '0') then
  begin
    Text := '1';
  end;

  EditProductQuantity.Text := Text;
end;

procedure TFormApp.UnlockApp;
begin
  ChangeComponentsVisibility(True);
  ButtonUnlock.Enabled := False;
end;

procedure TFormApp.UpdateOrdersInComboBox;
var
  Order: TOrder;
  Orders: TList;
begin
  CheckListBoxCart.Items.Clear;

  Orders := OrderService.ListAll;

  for Order in Orders do
  begin
    AddOrderToComboBox(Order);
  end;
end;

procedure TFormApp.UpdateProductPrice;
var
  ID, Price, Quantity: integer;
  Product: TProduct;

begin
  ID := GetIDFromSelectedProduct;
  Quantity := GetProductQuantity;

  if (ID = 0) or (Quantity = 0) then exit;

  Product := ProductService.FindByID(ID);

  Price := Quantity * Product.Price;
  LabelProductPrice.Caption := 'Preço: R$ ' + IntToStr(Price) + ',00';
end;

procedure TFormApp.UpdateTotalPrice;
var
  Price: integer;
  Order: TOrder;
  Orders: TList;
begin
  Price := 0;

  Orders := OrderService.ListAll;

  for Order in Orders do
  begin
    Price := Price + Order.Price;
  end;

  LabelTotalPrice.Caption := 'Total: R$ ' + IntToStr(Price) + ',00';
end;

procedure TFormApp.ChangeComponentsVisibility(Visible: boolean);
var
  I: Integer;
  Component: TComponent;
begin
  for I := 0 to (Self.ComponentCount - 1) do
  begin
    Component := Self.Components[I];

    if Component is TButton then
    begin
      (Component as TButton).Enabled := Visible;
    end
    else if Component is TEdit then
    begin
      (Component as TEdit).Enabled := Visible;
    end
    else if Component is TComboBox then
    begin
      (Component as TComboBox).Enabled := Visible;
    end
    else if Component is TLabel then
    begin
      (Component as TLabel).Enabled := Visible;
    end;
  end;
end;

end.
