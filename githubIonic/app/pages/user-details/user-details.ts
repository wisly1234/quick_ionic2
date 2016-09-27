import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

/*
  Author : wisly
  use command Rake page_add[my-page-name]

  Generated class for the UserDetailsPage page.

  See http://ionicframework.com/docs/v2/components/#navigation for more info on
  Ionic pages and navigation.
*/
@Component({
  templateUrl: 'build/pages/user-details/user-details.html',
})
export class UserDetailsPage {

  constructor(public nav: NavController, navParams: NavParams, githubUsers: GithubUsers) {
	// Retrieve the login from the navigation parameters
    this.login = navParams.get('login');

    // Get the user details and log
    githubUsers.loadDetails(this.login)
      .then( user => this.user = user)
  }

}
