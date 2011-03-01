Green League app
================

Deployment
----------

Using BetaBuilder (http://lukeredpath.co.uk/projects/betabuilder/) for deployment.

To set it up:

 * Create an 'Adhoc' build (copying the 'Release' configuration). See http://support.testflightapp.com/kb/tutorials/how-to-create-an-ipa
 * Install with
 
	sudo gem install betabuilder
 
To deploy: 

	rake beta:deploy