![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)(https://www.apache.org/licenses/LICENSE-2.0)
![Bluemix Deployments](https://deployment-tracker.mybluemix.net/stats/f4ae263f304ffe32cbb17f3238c3ac86/badge.svg)

# CognitiveConcierge
CognitiveConcierge is an end-to-end Swift application sample with an iOS front end and a Kitura web framework back end. This application also demonstrates how to pull in a number of different Watson services to your Swift client and server side apps via the Watson Developer Cloud's iOS SDKs, including Conversation, Text to Speech, Speech to Text, and the Natural Language Understanding service.

<img src="images/CC1.png" width="250"><img src="images/CC2.png" width="250"><img src="images/CC7.png" width="250">

## Included Components
- Bluemix Watson Conversation service
- Bluemix Watson Text to Speech service
- Bluemix Watson Speech to Text service
- Bluemix Watson Natural Language Understanding service
- Google Places API

## Application Workflow Diagram
![Application Workflow](images/archi.png)

1. The user deploys the server application to bluemix.

2. The user interacts with the IOS application.

3. When the user performs any action, IOS application the server application API which uses the Watson services and Google Places API to provide the user recommendations.

## Prerequisite
* **Obtain a Google Places API Key for Web:** For this project, you'll need an API Key from Google Places, so that app can have access to review text which will be sent to the Natural Language Understanding service for analysis.  Instructions for obtaining a key can be found [here](https://developers.google.com/places/web-service/get-api-key).
Once you have an API Key, go to the [Google Developer's Console](https://console.developers.google.com/flows/enableapi?apiid=places_backend&reusekey=true), create a project, add your API key and enable the Google Places API for iOS as well.  Make note of the API key for later use in your server and iOS applications.

If you haven't so yet, you also need to download and install the following:
* [Carthage Dependency Manager](https://github.com/Carthage/Carthage/releases)
* [CocoaPods](https://cocoapods.org/?q=cvxv)

## Steps
Use the following steps to deploy the application
- Deploy the Server Application
- Update Conversation Service
- Run the IOS Application

## 1. Deploy the Server Application

You can deploy the server application using any one of the following ways:
- Deploy to Bluemix button
- IBM Cloud Application Tools (ICAT)
- Bluemix command line

### a) Using the Deploy to Bluemix button
Clicking on the button below creates a Bluemix DevOps Toolchain and deploys this application to Bluemix. The `manifest.yml` file [included in the repo] is parsed to obtain the name of the application, configuration details, and the list of services that should be provisioned. For further details on the structure of the `manifest.yml` file, see the [Cloud Foundry documentation](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html#minimal-manifest).

[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://local.dev-console.stage1.bluemix.net:3100/devops/setup/deploy?repository=https://github.com/IBM/CognitiveConcierge.git)

Once deployment to Bluemix is completed, you can view the deployed application and services from your bluemix account.

### b) Using IBM Cloud Application Tools (ICAT)

1. Install [IBM Cloud Application Tools](http://cloudtools.bluemix.net/) for MacOS.
2. Once you've installed the application, you can open it to get started.
3. Click the **Create (+)** button to set up a new project, and then select the Cognitive Concierge Sample Application.
4. Click **Save Files to Local Computer** to clone the project.
5. Once the project is cloned, open up the .xcodeproj file that was created for you in ICAT under Local Server Repository. Edit the Sources/restaurant-recommendations/main.swift file's Constants struct with your own Google API Key for Web.

	<img src="images/xcodeproj.png" width="500">

6. Finally, you can use ICAT to deploy the updated server to Bluemix.  Click **Provision and Deploy Sample Server on Bluemix** under Cloud Runtimes.

	<img src="images/provision.png" width="500">

7. Give your Cloud Runtime a unique name, and click **Next**.  This deployment to Bluemix may take a few minutes.

8. In ICAT, ensure that the Connected to: field in the Client application is pointed to your server instance running on Bluemix. You can also point to your localhost for local testing, but you need to be running a local instance of the server application for this to work.


### c) Using the Bluemix command line

You can also manually deploy the Server Application to Bluemix. Though not as magical as using the Bluemix button above, manually deploying the app gives you some insights about what is happening behind the scenes. Remember that you'd need the Bluemix [command line](http://clis.ng.bluemix.net/ui/home.html) installed on your system to deploy the app to Bluemix.

Execute the following command to clone the Git repository:

```bash
git clone https://github.com/IBM/CognitiveConcierge.git
```

Go to the project's root folder on your system and execute the `Cloud-Scripts/services/services.sh` script to create the services CognitiveConcierge depends on. Please note that you should have logged on to Bluemix before attempting to execute this script. For information on how to log in, see the Bluemix [documentation](https://console.ng.bluemix.net/docs/starters/install_cli.html).

Executing the `Cloud-Scripts/services/services.sh` script:
```bash
$ Cloud-Scripts/cloud-foundry/services.sh
Creating services...
Invoking 'cf create-service conversation free CognitiveConcierge-Conversation'...

Creating service instance CognitiveConcierge-Conversation in org ishan.gulhane@ibm.com / space dev as ishan.gulhane@ibm.com...
OK
Invoking 'cf create-service speech_to_text standard CognitiveConcierge-Speech-To-Text'...

Creating service instance CognitiveConcierge-Speech-To-Text in org ishan.gulhane@ibm.com / space dev as ishan.gulhane@ibm.com...
OK

Attention: The plan `standard` of service `speech_to_text` is not free.  The instance `CognitiveConcierge-Speech-To-Text` will incur a cost.  Contact your administrator if you think this is in error.

Invoking 'cf create-service text_to_speech standard CognitiveConcierge-Text-To-Speech'...

Creating service instance CognitiveConcierge-Text-To-Speech in org ishan.gulhane@ibm.com / space dev as ishan.gulhane@ibm.com...
OK

Attention: The plan `standard` of service `text_to_speech` is not free.  The instance `CognitiveConcierge-Text-To-Speech` will incur a cost.  Contact your administrator if you think this is in error.

Invoking 'cf create-service natural-language-understanding free CognitiveConcierge-NLU'...

Creating service instance CognitiveConcierge-NLU in org ishan.gulhane@ibm.com / space dev as ishan.gulhane@ibm.com...
OK
Services created.
```

After the services are created, you can issue the `bx app push` command from the project's root folder to deploy the server application to Bluemix.

Once the application is running on Bluemix, you can access your application assigned URL (i.e. route). To find the route, you can log on to your [Bluemix account](https://console.ng.bluemix.net), or you can inspect the output from the execution of the `bluemix app push` or `bx app show <application name>` commands. The string value shown next to the `urls` field contains the assigned route.  Use that route as the URL to access the sample server using the browser of your choice.

```bash
$ bx app show CognitiveConcierge
Invoking 'cf app CognitiveConcierge'...

Showing health and status for app CognitiveConcierge in org ishan.gulhane@ibm.com / space dev as ishan.gulhane@ibm.com...
OK

requested state: started
instances: 1/1
usage: 512M x 1 instances
urls: cognitiveconcierge-lazarlike-archaizer.mybluemix.net
last uploaded: Mon Jun 5 18:01:42 UTC 2017
stack: cflinuxfs2
buildpack: swift_buildpack

     state     since                    cpu    memory         disk           details
#0   running   2017-06-05 11:05:41 AM   0.3%   6.4M of 512M   269.8M of 1G
```

## 2. Update Conversation Service
- Conversation service enables you to add a natural language interface to your applications.  While you could create a conversation tree manually, ICAT has run some setup scripts (found in the `Cloud-Scripts/conversation` folder) to add a populated workspace to your conversation service.
- If you are not using ICAT, go to bluemix dashboard and launch the Conversation service. Now manually populate the workspace by uploading the JSON found in `Resources/conversationWorkspace.json`. Make note of the workspace id for later use in running the iOS application.

## 3. Run the iOS Application

### Install the necessary dependencies
- From Terminal, change directories into the YourProjectName/CognitiveConcierge-iOS folder and run the following command to install the necessary dependencies (This may take some time):
```bash
carthage update --platform iOS
pod install
```

### Update configuration for iOS app
- Open the CognitiveConcierge.xcworkspace file in Xcode 8.3 either from ICAT or from your terminal using `open CognitiveConcierge.xcworkspace`

- **Update CognitiveConcierge.plist file:** One way to persist data in Swift is through the property list or .plist file. ICAT has run some set up scripts to generate and populate the `CognitiveConcierge-iOS/CognitiveConcierge/CognitiveConcierge.plist` file. You will need to open this file and add your Google API Key. If you are not using ICAT, then manually update the credentials for all the services. You can get the credentials for services either from the environment variables section present in the runtime tab from your Bluemix dashboard or using the command `bx app env CognitiveConcierge`. ConversationWorkspaceID is the workspace id of the conversation service.

- **Update bluemix.plist file:**
	- You should set the isLocal value to YES if you'd like to use a locally running server; if you set the value to NO, then you will be accessing the server instance running on Bluemix.
	- To get the appRouteRemote value, you should go to your application's page on Bluemix. There, you will find a View App button near the top right. Clicking on it should open up your app in a new tab, the url for this page is your route which maps to the appRouteRemote key in the plist. Make sure to include the http:// protocol in your appRouteRemote and to exclude a forward slash at the end of the url.
	- You can also use the command 'bx app env CognitiveConcierge' where appRouteRemote is uris, bluemixAppGUID is application_id and bluemixAppRegion is your Bluemix region for eg: us-south.
	```bash
	{
	 "VCAP_APPLICATION": {
	  "application_id": "3d06c0e7-1fff-4dbf-b0cb-b289770eccfe",
	  "application_name": "CognitiveConcierge",
	  "application_uris": [
	   "cognitiveconcierge-lazarlike-archaizer.mybluemix.net"
	  ],
	  "application_version": "3ef63168-35f5-4517-84e9-e8f19c8f34b4",
	  "limits": {
	   "disk": 1024,
	   "fds": 16384,
	   "mem": 512
	  },
	  "name": "CognitiveConcierge",
	  "space_id": "2b3083b9-7ef9-4d55-9741-34433be4cea1",
	  "space_name": "dev",
	  "uris": [
	   "cognitiveconcierge-lazarlike-archaizer.mybluemix.net"
	  ],
	  "users": null,
	  "version": "3ef63168-35f5-4517-84e9-e8f19c8f34b4"
	 }
	}

	Running Environment Variable Groups:
	BLUEMIX_REGION: ibm:yp:us-south

	Staging Environment Variable Groups:
	BLUEMIX_REGION: ibm:yp:us-south
	```
	- We need to get the value for `bluemixAppRegion`, which can be one of three options currently:

REGION US SOUTH | REGION UK | REGION SYDNEY
--- | --- | ---
`.ng.bluemix.net` | `.eu-gb.bluemix.net` | `.au-syd.bluemix.net`

### Running the application
Press the Play button in Xcode to build and run the project in the simulator or on your iPhone!
![](images/playbutton.png)


## Running the Kitura-based server locally
You can build the CognitiveConcierge-Server by going to the `CognitiveConcierge-Server` directory of the cloned repository and running `swift build`. To start the Kitura-based server for the CognitiveConcierge app on your local system, go to the `CognitiveConcierge-Server` directory of the cloned repository and run `.build/debug/CognitiveConcierge`. You should also update the `bluemix.plist` and `CognitiveConcierge.plist` file in the Xcode project in order to have the iOS app connect to this local server. See the [Update configuration for iOS app](#update-configuration-for-ios-app) section for details.


## Privacy Notice
This Swift application includes code to track deployments to [IBM Bluemix](https://www.bluemix.net/) and other Cloud Foundry platforms. The following information is sent to a [Deployment Tracker](https://github.com/IBM-Bluemix/cf-deployment-tracker-service) service on each deployment:

* Swift project code version (if provided)
* Swift project repository URL
* Application Name (`application_name`)
* Space ID (`space_id`)
* Application Version (`application_version`)
* Application URIs (`application_uris`)
* Labels of bound services
* Number of instances for each bound service and associated plan information

This data is collected from the parameters of the `CloudFoundryDeploymentTracker`, the `VCAP_APPLICATION` and `VCAP_SERVICES` environment variables in IBM Bluemix and other Cloud Foundry platforms. This data is used by IBM to track metrics around deployments of sample applications to IBM Bluemix to measure the usefulness of our examples, so that we can continuously improve the content we offer to you. Only deployments of sample applications that include code to ping the Deployment Tracker service will be tracked.

### Disabling Deployment Tracking
Deployment tracking can be disabled by removing the following line from main.swift:
```
CloudFoundryDeploymentTracker(repositoryURL: "https://github.com/IBM-MIL/CognitiveConcierge/", codeVersion: nil).track()
```
## CognitiveConcierge App video

[![cognitive concierge video](http://i.imgur.com/hsFxooD.png)](http://vimeo.com/222564546 "Cognitive Concierge Overview")


## Troubleshooting
- If the deployment for server application stage fails, redeploy the pipeline stage.
- If the IOS application is not able to connect to Watson Services, recheck the credential values in CognitiveConcierge.plist and bluemix.plist files.

## License
[Apache 2.0](License.txt)
