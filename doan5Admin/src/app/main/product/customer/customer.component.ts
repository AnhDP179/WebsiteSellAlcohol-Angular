import { HttpClient } from '@angular/common/http';
import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, NgForm, Validators } from '@angular/forms';
import { MustMatch } from 'src/app/helpers/must-match.validator';
import { BaseComponent } from 'src/app/lib/base-component';
import { Customer } from 'src/app/models/customer';
declare var $: any;

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.css']
})

export class CustomerComponent extends BaseComponent implements OnInit {
  customer: Customer = new Customer();

  public customers: any;
  public totalRecords: any;
  public pageSize = 3;
  public page = 1;
  public formsearch: any;
  public formdata: any;
  public doneSetupForm: any;
  public showUpdateModal: any;
  public isCreate: any;
  submitted = false;
  isEdit: boolean = false;

  constructor(    private httpclient: HttpClient,
    private fb: FormBuilder,
    injector: Injector) {
    super(injector);
  }

  ngOnInit(): void {
    this.formsearch = this.fb.group({
      customerName: [''],
      email: [''],
    });
    this.search();
  }

  loadPage(page) {
    this._api
      .post('/api/customer/search', { page: page, pageSize: this.pageSize })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.customers = res.data;
        this.totalRecords = res.totalItems;
        this.pageSize = res.pageSize;
      });
  }

  search() {
    this.page = 1;
    this.pageSize = 10;
    this._api
      .post('/api/customer/search', {
        page: this.page,
        pageSize: this.pageSize,
        customerName: this.formsearch.get('customerName').value,
        email: this.formsearch.get('email').value,

      })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.customers = res.data;
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


  onDelete(row) {
    this._api
      .post('/api/customer/delete', { id: row.id })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        alert('Xóa thành công');
        this.search();
      });

  }

  Reset() {
    this.customer = null;
    this.formdata = this.fb.group({
      customerName: ['', Validators.required],
      dateOfBirth: ['', Validators.required],
      address: ['', Validators.required],
      phone: ['', Validators.required],
      email: ['', Validators.required],

    });
  }
  resetform(form) {
    if (form != null) form.resetForm();
  }
  displayAdd: boolean = false;
  createModal() {
    this.displayAdd = true;

  }
  AddNewProduct(form: NgForm) {
    console.log(form.value);
    try {
            const khach: Customer = new Customer();
            khach.customerName = form.controls['customerName'].value;
            khach.dateOfBirth = form.controls['dateOfBirth'].value;
            khach.address = form.controls['address'].value;
            khach.phone = form.controls['phone'].value;
            khach.email = form.controls['email'].value;
            khach.password =
              form.controls['password'].value;
            this.loadPage(this.page);
            this._api
              .post('/api/customer/create', khach)
              .takeUntil(this.unsubscribe)
              .subscribe(
                (res) => {
                  alert('Thêm mới thành công');
                  this.resetform(form);
                  this.search();
                  this.displayAdd = false;
                },
                (err) => {
                  console.log(err);
                }
              );
    } catch (error) {
      console.log(error);
    }
  }
  openUpdateModal(customer: Customer) {
    this.customer = customer;
    this.isEdit = true;
  }

  SaveData() {
    try {
      this._api
        .post('/api/customer/update', this.customer)
        .takeUntil(this.unsubscribe)
        .subscribe(
          (res) => {
            alert('Cập nhật thành công');
            this.search();
            this.isEdit = false;
          },
          (err) => {
            console.log(err);
          }
        );
    } catch (error) {
      console.log(error);
    }
  }
  
}
