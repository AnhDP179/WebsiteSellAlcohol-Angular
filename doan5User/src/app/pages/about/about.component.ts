import { AfterViewInit, Component, Injector, OnInit } from '@angular/core';
import { BaseComponent } from 'src/app/core/base-component';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.css']
})
export class AboutComponent extends BaseComponent implements OnInit,  AfterViewInit {

  constructor(injector: Injector) {
    super(injector);
  }
  ngOnInit(): void {
  }
  ngAfterViewInit() { 
    this.loadScripts(); 
   }
}

