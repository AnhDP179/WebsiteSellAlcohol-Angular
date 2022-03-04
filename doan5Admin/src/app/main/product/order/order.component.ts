import { MustMatch } from '../../../helpers/must-match.validator';
import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { FileUpload } from 'primeng/fileupload';
import { FormBuilder, Validators } from '@angular/forms';
import { BaseComponent } from '../../../lib/base-component';
import 'rxjs/add/operator/takeUntil';
declare var $: any;
@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.css'],
})
export class OrderComponent extends BaseComponent implements OnInit {
  public doneSetup = false;
  public orderdetail: any;
  public orders: any;
  public totalItems: any;
  public pageSize = 3;
  public page = 1;
  public formsearch: any;
  public origin_listjson_chitiet:any;   
  public formdata: any;
  public items: any;
  public item: any;
  public soLuong: any;
  public doneSetupForm: any;
  public showUpdateModal: any;
  public isCreate: any;

  @ViewChild(FileUpload, { static: false }) file_image: FileUpload;
  constructor(private fb: FormBuilder, injector: Injector) {
    super(injector);
  }

  ngOnInit(): void {
    this.formsearch = this.fb.group({
      'hoTen': [''],
      'diaChiNhan': [''],
    });

    this.search();
  }

  loadPage(page) {
    this._api
      .post('/api/hoadon/search', {
        page: page,
        pageSize: this.pageSize,
      })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.orders = res.data;
        this.totalItems = res.totalItems;
        this.pageSize = res.pageSize;
      });
  }

  onRowExpand(row) {
    this.doneSetup = false;
    this._api
      .get('/api/hoadon/get-by-id/' + row.data.maDonHang)
      .subscribe((res: any) => {
        this.orderdetail = res;
        this.doneSetup = true;
      });
  }

  search() {
    this.page = 1;
    this.pageSize = 10;
    this._api
      .post('/api/hoadon/search', {
        page: this.page,
        pageSize: this.pageSize,
        hoTen: this.formsearch.get('hoTen').value,
        diaChiNhan: this.formsearch.get('diaChiNhan').value,
      })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.orders = res.data;
        this.totalItems = res.totalItems;
        this.pageSize = res.pageSize;
      });
  }

  // pwdCheckValidator(control) {
  //   var filteredStrings = { search: control.value, select: '@#!$%&*' };
  //   var result = (
  //     filteredStrings.select.match(
  //       new RegExp('[' + filteredStrings.search + ']', 'g')
  //     ) || []
  //   ).join('');
  //   if (control.value.length < 6 || !result) {
  //     return { matkhau: true };
  //   }
  // }

  // get f() {
  //   return this.formdata.controls;
  // }

  onSubmit(value) {

    this.orderdetail.hoTen = this.formdata.get('hoTen').value;
    this.orderdetail.diaChiNhan = this.formdata.get('diaChiNhan').value;
    this.orderdetail.sdtNhan = this.formdata.get('sdtNhan').value;
    this.orderdetail.note = this.formdata.get('note').value;

    let orderdetail_new =   $.extend(true, {},   this.orderdetail);
    orderdetail_new.listjson_chitiet = this.compare(this.origin_listjson_chitiet, this.orderdetail.listjson_chitiet, 'id');
    if(orderdetail_new.listjson_chitiet)
    {
      orderdetail_new.listjson_chitiet.forEach(element => {
        element.soLuong = +element.soLuong;
      });
    } 
    this._api.post('/api/hoadon/update',  orderdetail_new).takeUntil(this.unsubscribe).subscribe(res => {
      alert('Cập nhật thành công');
    });

  }

  onDelete(row) {
    this._api
      .post('/api/users/delete-user', { user_id: row.user_id })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        alert('Xóa thành công');
        this.search();
      });
  }

  public Them() {
    let idx = this.items.findIndex(x => x.id == this.item.id);
    if (idx !== -1) {
      let _item_name = this.items[idx].wine_name;
      this.orderdetail.listjson_chitiet.push({ wine_name: _item_name, maDonHang: this.orderdetail.maDonHang, id: this.item.id, soLuong: this.soLuong });
    }
  }
  Xoa(item) {
    let idx = this.orderdetail.listjson_chitiet.findIndex(
      (x) => x.id == item.id
    );
    if (idx !== -1) {
      this.orderdetail.listjson_chitiet.splice(idx, 1);
    }
  }

  public openUpdateModal(row) {
    this.doneSetupForm = false;
    this.showUpdateModal = true;
    this.isCreate = false;
    setTimeout(() => {
      $('#createUserModal').modal('toggle');
      this._api
        .get('/api/hoadon/get-by-id/' + row.maDonHang)
        .takeUntil(this.unsubscribe)
        .subscribe((res: any) => {
          this.orderdetail = res;
          this.origin_listjson_chitiet = $.extend(
            true,
            [],
            this.orderdetail.listjson_chitiet
          );
          this.formdata = this.fb.group({
            hoTen: [this.orderdetail.hoTen, Validators.required],
            diaChiNhan: [this.orderdetail.diaChiNhan],
            sdtNhan: [this.orderdetail.sdtNhan],
            tongTien: [this.orderdetail.tongTien],
            ngayDat: [this.orderdetail.ngayDat],
            note: [this.orderdetail.note],
            soLuong: [],
            sanpham: [],
            abc: [],
          });
          this._api
            .get('/api/sanpham/get-all')
            .takeUntil(this.unsubscribe)
            .subscribe((res: any) => {
              this.items = res;
            });
          this.doneSetupForm = true;
        });
    }, 700);
  }

  closeModal() {
    $('#createUserModal').closest('.modal').modal('hide');
  }
}
