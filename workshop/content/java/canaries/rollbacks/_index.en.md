+++
title = "Rollbacks"
date = 2019-11-12T08:00:36-08:00
weight = 30
+++

Monitoring the health of your canary allows CodeDeploy to make a decision to whether a rollback is needed or not. If any of the CloudWatch Alarms specified gets to ALARM status, CodeDeploy rollsback the deployment automatically. 

### Introduce an error on purpose

Lets break the Lambda function on purpose so that the _CanaryErrorsAlarm_ gets triggered during deployment. Update the lambda code in `/sam-app/HelloWorldFunction/src/main/java/helloworld/App.java` to throw an error on every invocation, like this:

```java
package helloworld;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

/**
 * Handler for requests to Lambda function.
 */
public class App implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    public APIGatewayProxyResponseEvent handleRequest(final APIGatewayProxyRequestEvent input, final Context context) {
        throw new Error("This will cause a deployment rollback");
        // Map<String, String> headers = new HashMap<>();
        // headers.put("Content-Type", "application/json");
        // headers.put("X-Custom-Header", "application/json");

        // APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent()
        //         .withHeaders(headers);
        // try {
        //     final String pageContents = this.getPageContents("https://checkip.amazonaws.com");
        //     String output = String.format("{ \"message\": \"hello beautiful world\", \"location\": \"%s\" }", pageContents);

        //     return response
        //             .withStatusCode(200)
        //             .withBody(output);
        // } catch (IOException e) {
        //     return response
        //             .withBody("{}")
        //             .withStatusCode(500);
        // }
    }

    private String getPageContents(String address) throws IOException{
        URL url = new URL(address);
        try(BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()))) {
            return br.lines().collect(Collectors.joining(System.lineSeparator()));
        }
    }
}

```

Make sure to update the unit test, otherwise the build will fail. Comment out every line in the `/sam-app/HelloWorldFunction/src/test/java/helloworld/AppTest.java` file: 

```java
package helloworld;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import org.junit.Test;

public class AppTest {
  @Test
  public void successfulResponse() {
    // App app = new App();
    // APIGatewayProxyResponseEvent result = app.handleRequest(null, null);
    // assertEquals(result.getStatusCode().intValue(), 200);
    // assertEquals(result.getHeaders().get("Content-Type"), "application/json");
    // String content = result.getBody();
    // assertNotNull(content);
    // assertTrue(content.contains("\"message\""));
    // assertTrue(content.contains("\"hello beautiful world\""));
    // assertTrue(content.contains("\"location\""));
  }
}

```

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```
git add .
git commit -m "Breaking the lambda function on purpose"
git push
```