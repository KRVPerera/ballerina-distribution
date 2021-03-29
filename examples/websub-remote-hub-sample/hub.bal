// The Main program, which brings up the Ballerina WebSub Hub.
import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/websubhub;

public function main() {

    // Starts the internal Ballerina Hub on port 9191 allowing remote publishers to register topics and publish
    // updates of the topics.
    io:println("Starting up the Ballerina Hub Service");

    websubhub:Hub webSubHub;
    var result = websubhub:startHub(new http:Listener(9191), "/websub", "/hub",
        hubConfiguration = {
            remotePublish: {
                enabled: true
            }
        }
    );

    if (result is websubhub:Hub) {
        webSubHub = result;
    } else if (result is websubhub:HubStartedUpError) {
        webSubHub = result.startedUpHub;
    } else {
        io:println("Hub start error:" + result.message());
        return;
    }

    // Waits for the subscriber to subscribe at this hub and for the publisher to publish the notifications.
    runtime:sleep(10000);

}