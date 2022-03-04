import { AfterViewInit, Component, Injector, OnInit } from '@angular/core';
import { BaseComponent } from 'src/app/core/base-component';

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css']
})
export class ContactComponent extends BaseComponent implements OnInit,  AfterViewInit {

  constructor(injector: Injector) {
    super(injector);
  }
  ngOnInit(): void {
  }
  ngAfterViewInit() { 
    this.loadScripts(); 
   }
}

