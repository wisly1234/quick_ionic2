import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

/*
  Generated class for the UserDetailsPage page.

  See http://ionicframework.com/docs/v2/components/#navigation for more info on
  Ionic pages and navigation.
*/
@Component({
  templateUrl: 'build/pages/user-details/user-details.html',
})
export class UserDetailsPage {
  login: string;
  constructor(public navCtrl: NavController, navParams: NavParams) {
	// Retrieve the login from the navigation parameters
    this.login = navParams.get('login');
  }

}
