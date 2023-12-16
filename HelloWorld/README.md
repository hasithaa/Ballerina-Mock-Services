# Hello World REST Service

You can use curl command-line tool to create HTTP requests for your Ballerina service. Here are the examples:

1. To access the greet resource which doesn't require any parameters, you can use the following command:

```
curl http://localhost:8080/HelloService/greet
```

2. To access the greet resource with a parameter (for example, "John"), you can use the following command:

```
curl http://localhost:8080/HelloService/greet/John
```

In both cases, replace localhost with the IP address or hostname of the machine where your Ballerina service is running if it's not on your local machine. Also, replace `8080` with the port number your service is listening on if it's different.

This is the Ballerina implementation (REST) of the [HelloWorld](https://github.com/wso2/micro-integrator/tree/master/integration/samples/axis2Server/src/HelloWorld).