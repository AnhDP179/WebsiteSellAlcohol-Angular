import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { FileUpload } from 'primeng/fileupload';
import { BaseComponent } from 'src/app/lib/base-component';
import 'rxjs/add/operator/takeUntil';
declare var $: any;
@Component({
  selector: 'app-type',
  templateUrl: './type.component.html',
  styleUrls: ['./type.component.css'],
})
export class TypeComponent extends BaseComponent implements OnInit {
  public products: any;
  public product: any;
  public totalRecords: any;
  public pageSize = 3;
  public page = 1;
  public formsearch: any;
  public formdata: any;
  public doneSetupForm: any;
  public showUpdateModal: any;
  public isCreate: any;
  submitted = false;
  @ViewChild(FileUpload, { static: false }) file_image: FileUpload;
  constructor(private fb: FormBuilder, injector: Injector) {
    super(injector);
  }
  ngOnInit(): void {
    this.formsearch = this.fb.group({
      manufacturer: [''],
    });
    this.search();
  }
  
  loadPage(page) {
    this._api
      .post('/api/loaisanpham/search', { page: page, pageSize: this.pageSize })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.products = res.data;
        this.totalRecords = res.totalItems;
        this.pageSize = res.pageSize;
      });
  }

  search() {
    this.page = 1;
    this.pageSize = 10;
    this._api
      .post('/api/loaisanpham/search', {
        page: this.page,
        pageSize: this.pageSize,
        manufacturer: this.formsearch.get('manufacturer').value,
      })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.products = res.data;
        this.totalRecords = res.totalItems;
        this.pageSize = res.pageSize;
      });
  }
  
  pwdCheckValidator(control) {
    var filteredStrings = { search: control.value, select: '@#!$%&*' };
    var result = (
      filteredStrings.select.match(
        new RegExp('[' + filteredStrings.search + ']', 'g')
      ) || []
    ).join('');
    if (control.value.length < 6 || !result) {
      return { _description: true };
    }
  }
  get f() {
    return this.formdata.controls;
  }

  onSubmit(value) {
    this.submitted = true;
    if (this.formdata.invalid) {
      return;
    }
    if (this.isCreate) {
      let tmp = {
        manufacturer: value.manufacturer,
        _description: value._description,
      };
      this._api
        .post('/api/loaisanpham/create', tmp)
        .takeUntil(this.unsubscribe)
        .subscribe((res) => {
          alert('Thêm thành công');
          this.search();
          this.closeModal();
        });
    } else {
      let tmp = {
        manufacturer: value.manufacturer,
        _description: value._description,
        id: this.product.id,
      };
      this._api
        .post('/api/loaisanpham/update', tmp)
        .takeUntil(this.unsubscribe)
        .subscribe((res) => {
          alert('Cập nhật thành công');
          this.search();
          this.closeModal();
        });
    }
  }

  onDelete(row) {
    this._api
      .post('/api/loaisanpham/delete', { id: row.id })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        alert('Xóa thành công');
        this.search();
      });

  }

  Reset() {
    this.product = null;
    this.formdata = this.fb.group({
      manufacturer: ['', Validators.required],
      _description: ['', Validators.required],
    });
  }
  createModal() {
    this.doneSetupForm = false;
    this.showUpdateModal = true;
    this.isCreate = true;
    this.product = null;
    setTimeout(() => {
      $('#createModal').modal('toggle');
      this.formdata = this.fb.group({
        manufacturer: ['', Validators.required],
        _description: ['', Validators.required],
      });
      this.doneSetupForm = true;
    });
  }
  public openUpdateModal(row) {
    this.doneSetupForm = false;
    this.showUpdateModal = true;
    this.isCreate = false;
    setTimeout(() => {
      $('#createModal').modal('toggle');
      this._api
        .get('/api/loaisanpham/get-by-id/' + row.id)
        .takeUntil(this.unsubscribe)
        .subscribe((res: any) => {
          this.product = res;
          this.formdata = this.fb.group({
            manufacturer: [this.product.manufacturer, Validators.required],
            _description: [this.product._description, Validators.required],
          });
          this.doneSetupForm = true;
        });
    }, 700);
  }

  closeModal() {
    $('#createModal').closest('.modal').modal('hide');
  }
}
