# Green League app


## Deployment

Using BetaBuilder (http://lukeredpath.co.uk/projects/betabuilder/) for deployment.

To set it up:

 * Create an 'Adhoc' build (copying the 'Release' configuration). See http://support.testflightapp.com/kb/tutorials/how-to-create-an-ipa
 * Install with
 
	sudo gem install betabuilder
 
To deploy: 

	rake beta:deploy


## Distribution

### Set up distrubtion certificate/provisioning profile and iTunes info
Need Paul (Apple account admin user):

* Obtaining your iOS Distribution Certificate (see http://developer.apple.com/ios/manage/distribution/index.action) - only done once
* Create and download your iOS Distribution Provisioning Profile for App Store Distribution - need Paul for this
* Fill in iTunes connect form for new app - https://itunesconnect.apple.com/
* Click on the Ready for Upload button in the project view (top right blue button)

### Dev deployment
* Follow this to create archive and submit to apple: http://www.weston-fl.com/blog/?p=2442
 * Add provisioning profile to XCode Organizer
 * Go to Xcode menu > Product > Archive
 * Go to Organiser > Archives > Validate... (select the deployment provisioning profile) - need Paul account
 * Go to Organiser > Archives > Submit...

