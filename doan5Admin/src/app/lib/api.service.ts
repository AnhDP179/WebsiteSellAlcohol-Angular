import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from './../../environments/environment';
import { Router } from '@angular/router';
import { catchError, map } from 'rxjs/operators';
import { Observable, throwError as observableThrowError } from 'rxjs';


@Injectable({
  providedIn: 'root',
})
export class ApiService {
  public host = 'http://localhost:49354';
  constructor(private _http: HttpClient, public router: Router) {}
  public handleError(error: any) {
    this.router.navigate(['/err']);
    return observableThrowError(error);
  }

  uploadFile(file: FormData) : Observable<any>{
    return this._http.post('https://localhost:44317/api/sanpham/upload', file);
  }
  post(url: string, obj: any) {
    const body = JSON.stringify(obj);
    return this._http
      .post<any>(this.host + url, body)
      .pipe(
        map(res => {
          return res;
        })
      );      
  }
  
  get(url: string) {
    return this._http
      .get(this.host + url)
      .pipe(
        map(res  => {
          return res;
        })
      );       
  } 

}
