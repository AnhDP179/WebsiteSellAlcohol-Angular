import { AfterViewInit, Component, Injector, OnInit } from '@angular/core';
import { BaseComponent } from 'src/app/core/base-component';
import { AbstractControl, FormControl, FormGroup, ValidationErrors, Validators } from '@angular/forms';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent extends BaseComponent implements OnInit,  AfterViewInit {

  public frmCheckout: FormGroup;
  namePattern= "^([a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌÓỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳýỵỷỹ \s]+)$";
  mobilePattern="^[0-9 _-]{10,12}$";
  items:any;
  total:any;
  ngayDat:any;
  constructor(injector: Injector) { 
    super(injector);
  }

  ngOnInit(): void {
    window.scrollTo(0,0);
    var today = new Date();
    this.ngayDat = today.toLocaleDateString();
    this.frmCheckout = new FormGroup({
      txtHo: new FormControl('', [Validators.required, Validators.minLength(2), Validators.maxLength(50),Validators.pattern(this.namePattern)]),
      txtTen: new FormControl('', [Validators.required, Validators.minLength(2), Validators.maxLength(50),Validators.pattern(this.namePattern)]),
      txtDiaChi: new FormControl('',[Validators.required]),
      txtSDT: new FormControl('', [Validators.required, Validators.pattern(this.mobilePattern)]),
      txtEmail: new FormControl('', [this.CustomEmailValidator]),
    });
    
    this._cart.items.subscribe((res) => {
      this.items = res;
      this.total = 0;
      for(let x of this.items){ 
        x.maSanPham=x.id;
        x.soLuong = +x.quantity;
        x.giaBan = x.quantity * x.price;
        this.total += x.quantity * x.price;
      } 
    });
  }
  public CustomEmailValidator(control: AbstractControl): ValidationErrors | null {
    if ((control.value || '').toString() == '') {
      return null;
    }
    return Validators.email(control);
  }
  public txtMatKhauCheckValidator(control) {
    var filteredStrings = { search: control.value, select: '@#!$%&*' }
    var result = (filteredStrings.select.match(new RegExp('[' +
    filteredStrings.search + ']', 'g')) || []).join('');
    if ((control.value.length < 6 || result == '') && control.value) {
      return { nameX: true };
    }
  }
  public onSubmit(value: any) {
    let fullname = value.txtHo + ' ' + value.txtTen;
    let hoadon = {
      hoTen: fullname, 
      diaChiNhan:value.txtDiaChi,
      SDTNhan:value.txtSDT,
      email:value.txtEmail, 
      tinhTrang: "Chờ xử lý",
      tongTien: this.total,
      note:value.txtNote,
      ngayDat:  this.ngayDat,
      listjson_chitiet:this.items};
      this._api.post('/api/hoadon/create', hoadon).takeUntil(this.unsubscribe).subscribe(res => {
        alert('Đơn hàng của bạn đang trên đường tới !');
        this._cart.clearCart();
      }, err => { });      
    }
  ngAfterViewInit() { 
    this.loadScripts(); 
   }
}
