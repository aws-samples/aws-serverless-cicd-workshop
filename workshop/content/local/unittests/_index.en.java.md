+++
title = "Run the unit tests"
date = 2019-10-03T09:05:09-07:00
weight = 20
+++

### Fix the unit test
We changed the response message to **hello beautiful world** and the unit test was expecting **hello world**. This is an easy fix, let's update the unit test. 

Open the file `sam-app/HelloWorldFunction/src/test/java/helloworld/AppTest.java` and update the expected value for the response to match the new message. The unit test should look like this after the update:

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
    App app = new App();
    APIGatewayProxyResponseEvent result = app.handleRequest(null, null);
    assertEquals(result.getStatusCode().intValue(), 200);
    assertEquals(result.getHeaders().get("Content-Type"), "application/json");
    String content = result.getBody();
    assertNotNull(content);
    assertTrue(content.contains("\"message\""));
    assertTrue(content.contains("\"hello beautiful world\""));
    assertTrue(content.contains("\"location\""));
  }
}
```

**Note: Make sure you save the files after changing them.**

### Run the tests again
Run the same command again.

```
sam build
```

Now the tests should pass:
![UnitTestsSucceed](/images/java/chapter2/unittests/build-succeeded.png)

Then rerun our local deployment

```
sam local start-api --port 8080
```

Now refresh the browser tab or re-trigger the CURL command to see the changes reflected in your endpoint.
![SamLocalCodeChange](/images/java/chapter2/unittests/terminal.png)

![SamLocalCodeChange](/images/java/chapter2/unittests/preview.png)