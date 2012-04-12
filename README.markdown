# Green League app

## Overview

The Green League app is built with a [MVC architecture](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) in mind.

`GreenLeagueAppDelegate` holds the application together, and loads the model, and sets up the view controllers.

`UniversitiesModel` manages the data for the university scores.

The different tabs in the app are represented by the separate view controllers:

* `FindViewController`
* `CompareViewController`
* `MethodologyViewController`
* `AboutViewController`

More details about the files and how they work are on the top of the respective .h files.


### Other noteworthy files

* About.html                    - The about page content.
* description.txt               - App store description.
* gl11-raw-export-final-key.csv - The keys used for associating the green league data with titles/definitions.
* gl11-export-final.csv         - The 2011 green league data.
* green_league.xcdatamodel      - The data model.
* Methodology.html              - The methodology page content.

### Model files

Using [mogenerator](http://rentzsch.github.com/mogenerator/) to generate model files (/Models/_[model name] .h and .m files) from the .xcdatamodel files. These are inherited by the respective /Models/[model name] .h and .m files.

To generate models, after the .xcdatamodel has changed, run:

    mogenerator -m Classes/green_league.xcdatamodel -O Classes


## Deployment

This project uses [BetaBuilder](http://lukeredpath.co.uk/projects/betabuilder/) for deployment.

To set it up:

 * Create an 'Adhoc' build (copying the 'Release' configuration). See http://support.testflightapp.com/kb/tutorials/how-to-create-an-ipa-xcode-4
 * Install with
 
    sudo gem install betabuilder
 
To deploy:

    rake beta:deploy


## Distribution

### Set up distrubtion certificate/provisioning profile and iTunes info:

* Obtain the [iOS Distribution Certificate](http://developer.apple.com/ios/manage/distribution/index.action) - only needs to be done once
* Create and download the iOS Distribution Provisioning Profile for App Store Distribution
* Fill in [iTunes connect form](https://itunesconnect.apple.com/) for new app
* Click on the 'Ready for Upload' button in the project view (top right blue button)

### Developer deployment

Follow this to create an archive and submit to apple (http://www.weston-fl.com/blog/?p=2442):

 * Add provisioning profile to XCode Organizer
 * Go to Xcode menu > Product > Archive
 * Go to Organiser > Archives > Validate... (select the deployment provisioning profile)
 * Go to Organiser > Archives > Submit...

## Copyright

All data and images contained within this app are the property of People & Planet Student Activities Ltd and may not be reproduced without prior permission. Contact greenleague@peopleandplanet.org or 01865 264180 for further information and permissions.
