# Introduction to Spring Boot 

[TOC]





## Idea

Spring Boot is a framework built on top of the Spring framework. It provides a set of defaults and conventions, allowing developers to quickly create applications with minimal configuration.

Spring Web MVC is an MVC architecture which is used for web applications. Via annotations, it abstracts away a lot of details, thus simplifying the development.

Apache Tomcat is used to provide a web server environment in which Java code can also run. A file with `yml` extension can be created inside a `resources` directory in order to provide server settings (change listening port, for example). 





## Changing the logo :)

As you know, when starting the demo Spring Boot application, you see the default Spring logo.

To change the logo, you first need to create a file named `banner.txt` that contains your custom logo and then put it in the `/src/main/resources` directory (next to the `application.properties` file).

To create a stunning logo, you can use this [Spring Boot Banner Generator](https://springhow.com/spring-boot-banner-generator/). 







## Project structure

- `.gradle` -- if gradle is used

- `build.gradle` -- if gradle is used

- `src`
  - `main`
    - `java` -- source code 
    
    - `resources`
      - `static` -- directory for web development 
      - `templates` -- directory for web development
      - `application.properties` -- for environment-specific parameters 
    
  - test

    - `java`

- `pom.xml` -- xml file that contains specifications for spring initializer

- `...`





### `build.gradle`

Dependencies used by Spring Boot application are specified in the `build.gradle` file.

```java
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

The first dependency adds the Spring Boot framework to this project, and the second brings test libraries integrated with Spring Boot. These dependencies are called **starters** and are enough for the simplest Spring Boot application. Each starter dependency is a <u>group</u> of related dependencies.

There are more of starters dependencies. All the starters use a similar naming pattern: `spring-boot-starter-*`, where `*` denotes a type of application. It can be, for example, `web` or `security`.





### `application.properties`

Spring Boot uses the **convention-over-configuration** approach. As such, a developer only needs to specify unconventional aspects of the application, while all other aspects work by default.

To configure a Spring Boot application, there is an `application.properties` file located in `src/main/resources`. This file is empty in a newly generated project, but the application still works thanks to default implicit configurations.

The properties can also be stored in the YAML format within the `application.yml` file. We intend to add examples of it in the future.







## Dependency injection

*Dependency injection (DI)* is a way of organizing and connecting different parts of a software application. It allows the dependencies of a class to be provided <u>externally</u> rather than being created or managed <u>within the class itself</u>.

There are three types of DI: 

- **Constructor Injection** -- dependencies are provided as parameters in the constructor:

  ```java
  public class MyClass {
      private Dependency dependency;
  
      public MyClass(Dependency dependency) {
          this.dependency = dependency;
      }
  }
  ```

- **Setter Injection** -- dependencies are set through the setter methods:

  ```java
  public class MyClass {
      private Dependency dependency;
  
      public void setDependency(Dependency dependency) {
          this.dependency = dependency;
      }
  }
  ```

- **Method Injection** -- dependencies are passed as parameters to the method of the class:

  ```java
  public class MyClass {
      ...
      public void doSomething(Dependency dependency) {
          // Use the dependency here
      }
  }
  ```







## IoC containers

**IoC**, which stands for **Inversion of Control**, is the principle used by frameworks. IoC means that, first, the framework calls the source code, then the source code calls the library functions. 

IoC is used by Spring to implement dependency injection. Thus, objects can define the dependencies they need to run successfully. These dependencies are defined through constructor arguments, factory method arguments, or properties set on the object instance.





### Spring IoC containers

For the Spring application, we need a few components -- *containers* -- to implement the required functionality. 

The Spring containers manage the lifecycle of the application from start to finish. They manage various components created for the application and handle any required dependency injections. 

The Spring containers can be configured through metadata. Two types of metadata are used in Spring: **XML** and **annotations** (annotations are more preferable). The XML approach involves defining class-related data in an external XML file, which can be loaded and used in the Spring application.

The annotations allow us to build objects with the required features and configurations. Such objects are called **POJO classes**. 

<u>The Spring container consists of POJO classes and Metadata.</u> 





### POJO

The term **POJO** stands for **Plain Old Java Object**. A POJO is the most basic object type and contains no ties to frameworks. This means that POJOs are valid objects for any application.

POJOs can have properties, getters and setters, methods, but it cannot extend or implement framework-specific classes and interfaces or contain annotations.





### JavaBeans

A **JavaBean** is a POJO with some additional requirements and restrictions:

- classes are required to be serializable (meas the state of the class can be converted to the byte stream)
- they need private fields and a no-argument constructor. 

These classes can also be customized and configured using Spring metadata. To do this, we can add annotations. For example, the `@Bean` annotation can be added to a factory method to define its return value as a **Spring bean** (a POJO or JavaBean created and managed by the instance of the Spring IoC container). 

With annotations, it is possible to add any configurations to preexisting classes without creating additional files.





### `BeanFactory`

The **`BeanFactory`** is an interface that allows for the configuration and management of objects. It can produce container-managed objects known as *beans*, which can organize the backbone of your application. These beans look like regular Java objects, but they can be created during application startup, registered, and injected into different parts of the application by the container.





### `ApplicationContext`

The **`ApplicationContext`** is an interface extending the `BeanFactory`. `ApplicationContext` objects provide bean configurations for the application setup. There are three main implementations that we typically see in applications:

- **`FileSystemXmlApplicationContext`** -- loads bean definitions from an XML file that is provided to the constructor through its full file path.
- **`ClassPathXmlApplicationContext`** -- loads bean definitions from an XML file that is provided as a classpath property. 
- **`WebApplicationContext`** -- loads the servlet configuration from a file `web.xml`. Inside this file, configurations for each servlet are set. 
- **`AnnotationConfigApplicationContext`** -- creates and annotation-based context from a `@Configuration` class (= the class contains Spring bean configurations.)

One way to create an application context:

```java
public class Application {

    public static void main(String[] args) {
        var context = new AnnotationConfigApplicationContext(Config.class);
    }
}
```







## Spring beans

Spring can create all the necessary objects during the application startup and put them in a container. Then, each class can retrieve the objects it needs from this container.

These container-managed objects are known as **beans,** and they organize the backbone of your application. They look exactly like standard Java or Kotlin objects but can be created and instantiated during the application startup, and then injected into different parts of an application by the container.

❗There is no need to use only Spring beans and ignore ordinary objects. Beans are usually used to form the backbone of your app and separate it by layers and configuration files. 





### Declaring beans

Beans are usually declared in classes with the `@Configuration` annotation. It is also possible to declare them in the class containing the `@SpringBootApplication` annotation.

By default, beans are <u>singletons</u>. But this default behavior can be changed.

By default, the name of a bean is the same as the name of the method that produces it. But this behaviour can be changed: `@Bean("aboba")` -- in this case, the name of the bean is "aboba".

To declare a bean, you need a method with the `@Bean` annotation. The result of executing this method will be a bean that is managed by the IoC container. The simple example: 

```java
@Configuration
public class Addresses {

    @Bean
    public String address() {
        return "Green Street, 102";
    }
}
```





### Autowiring beans

Now that you have declared a bean, you can use it to create other beans that depend on it.

The Spring IoC container provides the DI mechanism that allows us to do that. A bean with a suitable type can be automatically injected into a method annotated with `@Bean`. The `@Autowired` annotation is used. 



#### Example 1

```java
@Configuration
public class Addresses {

    @Bean
    public String address() {
        return "Green Street, 102";
    }
}



public class Customer {
    private final String name;
    private final String address;

    public Customer(String name, String address) {
        this.name = name;
        this.address = address;
    }

    @Override
    public String toString() {
        return "Customer{ name='" + name + "', address='" + address + "' }";
    }
}



@SpringBootApplication
public class DemoSpringApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoSpringApplication.class, args);
    }

	@Bean
	public Customer customer(@Autowired String address) {
		return new Customer("Clara Foster", address);
	}

	@Bean
	public Customer showCustomer(@Autowired Customer customer) {
		System.out.println(customer);
		return customer;
	}
}
```

Spring DI injects the `address` bean into the `customer` method, and this bean can be used to construct a new object of the `Customer` class. Even if the argument had another name (e.g., `aboba`), this code would work as expected.

Also, Spring DI injects the `customer` bean into the `showCustomer` method. As a result, the line 

```txt
Customer{name='Clara Foster', address='Green Street, 102'}
```

is written into `stdout`. 



#### Example 2

```java
@Configuration
public class Addresses {
    @Bean
    public String address() {
        return "Green Street, 102";
    }
}


@Component
public class MyComponent {
    @Autowired
    private String address;

    ...
}
```







### `@Qualifier`

When using `@Autowired`, the location of an injection point is determined only by the type of bean. But what if we have several beans of the same type and want to use a particular one?

The `@Qualifier` annotation allows to specify the name of the bean:

```java
@Bean
public String address1() {
    return "Green Street, 102";
}

@Bean
public String address2() {
    return "Apple Street, 15";
}

@Bean
public Customer customer(@Qualifier("address2") String address) {
    return new Customer("Clara Foster", address);
}
```

Without it, we get an error that several beans can be injected. 







## Components

A **component** is a special kind of class that can be auto-detected by Spring IoC and used for dependency injection. It is typically annotated with `@Component` or one of its specialized annotations (`@Service`, `@Repository`, or `@Controller`). Components are automatically detected and instantiated by the Spring container. 

Example of the usage:

```java
@Component
public class PasswordGenerator {
    private static final String CHARACTERS = "abcdefghijklmnopqrstuvwxyz";
    private static final Random random = new Random();

    public String generate(int length) {
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHARACTERS.length());
            result.append(CHARACTERS.charAt(index));
        }

        return result.toString();
    }
}
```

By default, there is only <u>one bean</u> for every component. This means when you have a `@Component` class and you retrieve that bean from the Spring container, you will always get the same instance of the class.

A bean created with `@Component` is a <u>singleton</u> by default.







### Autowiring components

Lets autowire the `PasswordGenerator` class, used above, to the `Runner` class: 

```java
@Component
public class Runner implements CommandLineRunner {
    private final PasswordGenerator generator;

    @Autowired
    public Runner(PasswordGenerator generator) {
        this.generator = generator;
    }

    @Override
    public void run(String... args) {
        System.out.println("A short password: " + generator.generate(5));
        System.out.println("A long password: " + generator.generate(10));
    }
}
```



When constructor injection is used, the `@Autowired` annotation can be omitted. When it comes to the field injection, the annotation is required, otherwise fields will be null:

```java
@Component
public class Runner implements CommandLineRunner {
    private final PasswordGenerator generator;

    public Runner(PasswordGenerator generator) {
        this.generator = generator;
    }
    
    public void run(String... args) { ... }
}
// OK. The `generator` field is initialized 
```

```java
@Component
public class Runner implements CommandLineRunner {
    private final PasswordGenerator generator;
    
    public void run(String... args) { ... }
}
// The `generator` field is null
```







### Specializations of components

As mentioned above, there are several specializations of components depending on their role in the Spring application:

- `@Component` indicates a generic Spring component.
- `@Service` indicates a business logic component but doesn't provide any additional functions.
- `@Controller` / `@RestController` indicates a component that can work in a REST web services.
- `@Repository` indicates a component that interacts with an external data storage (e.g., a database).

If your component doesn't need to communicate with a database or return an HTTP result, you can use the `@Service` annotation. Also, `@Component` can always be replaced with `@Service`.







## `CommandLineRunner`

In Spring Boot, the `CommandLineRunner` interface is used to run code that needs to be executed after the Spring Boot application has started up and the Spring application context has been fully initialized.

The `CommandLineRunner` interface has a single method called `run()`, which accepts an array of `String` arguments.

When the Spring Boot application starts, any beans implementing the `CommandLineRunner` interface are identified by the Spring container, and their `run()` method is invoked.

Some cases to use `CommandLineRunner`:

1. Data initialization. You can load or initialize data into the application's database or other data sources (for example, by reading from a file).
2. If your application needs to interact with external systems or services upon startup, you can establish connections or perform necessary setup tasks.
3. Scheduling tasks. `CommandLineRunner` can be used to schedule recurring tasks using `@Scheduled` annotations or the `TaskScheduler` interface.
4. Logging. You can log important startup information or generate reports.



**Example:**

```java
@Component
public class MyCommandLineRunner implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {
        System.out.println("Application started! "
                           + "Performing initialization tasks...");
        // Perform initialization logic here
    }
}
```







## More about `ApplicationContext`

`BeanFactory` is a **root** interface for accessing the Spring IoC container. `ApplicationContext` is an interface that extends `BeanFactory`. Since`ApplicationContext` has more functionality, it is more preferable than `BeanFactory`.

There are two ways to create metadata (bean definitions): by using an XML configuration file or annotations. `BeanFactory` doesn't support annotation-based configuration, while `ApplicationContext` does. 



An application context is created based on a configuration class, which describes what objects (beans) will be created inside the IoC container.

One way to create an application context:

```java
public class Person {
   private String name;

   public Person(String name) {
       this.name = name;
   }
}



@Configuration
public class Config {

    @Bean
    public Person personMary() {
        return new Person("Mary");
    }
}



public class DemoApplication {
    public static void main(String[] args) {
        var context = new AnnotationConfigApplicationContext(Config.class);
        System.out.println(
            Arrays.toString(context.getBeanDefinitionNames())
        ); 

// output: [ <several internal beans for the Spring app>, config, personMary ]
    }
}
```



❗`@Configuration` contains the `@Component` annotation inside, which also tells `ApplicationContext` to create a bean based on the `Config` class. So, before creating the `personMary` bean, `ApplicationContext` also creates a `config` bean and places it in the IoC container.





### `getBean()`

`ApplicationContext` overloads the `getBean()` methods inherited from `BeanFactory`:

- `T getBean(Class<T> requiredType)`
- `Object getBean(String name)`   <--------   returns an Object class!
- `T getBean(String name, Class<T> requiredType)`

```java
context.getBean("personMary"); // returns an Object object
context.getBean("personMary", Person.class) // returns a Person object
```





### `@ComponentScan`

Imagine we create beans, using `@Component` annotation. We want to put these components into the same application context as some `@Bean` objects. For the configuration class to know about the existence of the `@Component` classes, the `@ComponentScan` annotation is used.

```java
@Component
public class Book { ... }

@Component
public class Movie { ... }



@ComponentScan
@Configuration
public class Config {

    @Bean
    public Person personMary() {
        return new Person("Mary");
    }
}



public class Application {
    public static void main(String[] args) {
        var context = new AnnotationConfigApplicationContext(Config.class);
        System.out.println(Arrays.toString(context.getBeanDefinitionNames()));
    }
}
```

`@ComponentScan` scans all the classes stored in the start package and all its sub-packages. It looks for `@Component` classes or its specializations(`@Service`, `@Controll` etc). 

By default, the start package is the current one. You can change the default behavior of `@ComponentScan` and explicitly specify one or more base packages for scanning:

```java
@ComponentScan(basePackages = "packageName")
// OR
@ComponentScan(value = "packageName")
// OR 
@ComponentScan("packageName")
```







## Scopes of beans

Be default, the bean is singleton. Still, Spring supports six bean scopes: singleton, prototype, request, session, application, and websocket. The first two scopes can be used in any Spring application, including console-based ones, while the other four are only available in web applications and rely on HTTP-based concepts such as HTTP requests, sessions, etc.

To set up a scope, you should use the `@Scope` annotation. It can be applied to both `@Bean`-annotated method and `@Component`-annotated classes. 



- **Singleton scope**

  Spring bean has a singleton scope <u>by default</u>. With it, the container creates only one instance of a bean for the whole `ApplicationContext` and injects it into other beans when expected.

  The singleton scope can also be specified explicitly:

  ```java
  @Scope("singleton")
  // OR
  @Scope(value = ConfigurableBeanFactory.SCOPE_SINGLETON)
  // OR 
  @Singleton
  ```

  The last option is called a *shortcut annotation*.

  

- **Prototype scope**

  To turn a bean into a non-singleton, we can use *the prototype scope*. When we use it, the container returns a new bean every time it should be injected into a target. 

  ```java
  @Scope("prototype")
  // OR 
  @Scope(value = ConfigurableBeanFactory.SCOPE_PROTOTYPE)
  // OR 
  @Prototype
  ```

  

- **Request scope**

  Available only in web applications.

  Allows a bean to be created for the whole lifecycle of an HTTP request. If a request is processed by several Spring components, the request-scoped bean will be available in all these components.

  ```java
  @Scope("request")
  // OR
  @RequestScope
  ```

  

- **Session scope**

  Available only in web applications.

  Allows a bean to be created for the whole HTTP session, including sequences of HTTP requests connected by cookies or a session ID.

  ```java
  @Scope("session")
  // OR 
  @SessionScope
  ```

  

- **Application scope**

  Available only in web applications. 

  Allows a bean to be created for several applications (`ApplicationContext`) running in the same `ServletContext`. This scope is broader than the singleton scope, which is only scoped to a single application context.

  ```java
  @Scope("application")
  // OR 
  @ApplicationScope
  ```

  

- **Websocket scope**

  Available only in web applications. 

  Allows a bean to be created for the complete life-cycle of a WebSocket session.

  ```java
  @Scope("websocket")
  // OR 
  @WebSocketScope
  ```







## Bean lifecycle

When a Spring application is launched, the Spring Container gets started. The container is mainly responsible for managing the **lifecycle** of beans from their creation to destruction.

```
container started 
⇓
dependencies injected
⇓
Bean initialized. Ready for use
⇓
bean s used by the app
⇓
Bean destroyed
```

A significant difference exists between singletons and beans annotated with `@Scope("prototype")`. Spring doesn't destroy prototypes and doesn't allow us to customize their lifecycle.





### Initialization and destruction

The Spring container performs this initialization automatically, but it also allows us to customize the initialization. We may want to load resources, read a file, connect to a database, etc. 

The same is about destruction. Before destroying the bean, some custom cleanup may be necessary, such as closing some connections, cleaning files, and so on.

- The methods **can** have any names and access modifiers.
- The methods **must not** have any arguments. Otherwise, an exception will be thrown.





#### Option 1: using annotations

**When it comes to a `@Component` class**, we can use `@PostConstruct` and `@PreDestroy` annotations to the methods. Spring will can methods annotated this way only once:

```java
@Component
class TechLibrary {
    private final List<String> bookTitles = 
            Collections.synchronizedList(new ArrayList<>());

    @PostConstruct
    public void init() {
        bookTitles.add("Clean Code");
        bookTitles.add("The Art of Computer Programming");
        bookTitles.add("Introduction to Algorithms");
        System.out.println("The library has been initialized: " + bookTitles);
    }

    @PreDestroy
    public void destroy() {
        bookTitles.clear();
        System.out.println("The library has been cleaned: " + bookTitles);
    }
}
```

After the bean instance is created and all its properties have been set (via dependency injection or other means), the Spring container calls the `init()` method.



**When it comes to a `@Bean` method**, you can specify methods inside the `@Bean` annotation:

```java
@Configuration
class Config {

    @Bean(initMethod = "init", destroyMethod = "destroy")
    public TechLibrary library() {
        return new TechLibrary();
    }
}

class TechLibrary {
    private final List<String> bookTitles = 
            Collections.synchronizedList(new ArrayList<>());

    public void init() {
        bookTitles.add("Clean Code");
        bookTitles.add("The Art of Computer Programming");
        bookTitles.add("Introduction to Algorithms");
        System.out.println("The library has been initialized: " + bookTitles);
    }

    public void destroy() {
        bookTitles.clear();
        System.out.println("The library has been cleaned: " + bookTitles);
    }
}
```

During the bean instantiation process, the Spring container checks for the presence of `initMethod` and `destroyMethod` attributes on the `@Bean` annotation. Then It looks for corresponding methods (`init` and `destroy` in this case) within the bean class (`TechLibrary` in this case).

Instead of using attributes inside `@Bean` annotation, we still can add the `@PostConstruct` and `@PreDestroy` annotations to the `init` and `destroy` methods.





#### Option 2: implement some interfaces

Another way to customize the initialization and destruction of beans is to implement the `InitializingBean` and `DisposableBean` interfaces and override their `afterPropertiesSet` and `destroy` methods:

```java
@Component
class TechLibrary implements InitializingBean, DisposableBean {
    private final List<String> bookTitles = 
            Collections.synchronizedList(new ArrayList<>());

    @Override
    public void afterPropertiesSet() throws Exception {
        bookTitles.add("Clean Code");
        bookTitles.add("The Art of Computer Programming");
        bookTitles.add("Introduction to Algorithms");
        System.out.println("The library has been initialized: " + bookTitles);
    }

    @Override
    public void destroy() {
        bookTitles.clear();
        System.out.println("The library has been cleaned: " + bookTitles);
    }
}
```

After the bean instance is created and all its properties have been set (via dependency injection or other means), the Spring container calls the `afterPropertiesSet()` method.





#### Option 3: use an XML bean definition file

This is an outdated way mostly used for legacy applications. Forget it. 







### Post-processors

You can customize beans using the `BeanPostProcessor` interface. Some custom operations will be run before or after the bean is initialized. To use this feature, the `postProcessBeforeInitialization` or `postProcessAfterInitialization` methods need to be overriden.

Note that a `BeanPostProcessor` is executed for each bean defined in the Spring context, including the beans created by the framework. However, it is possible to keep beans from being modified using conditions.

Post-processors are an advanced concept. Unlike `@PostConstruct`, `@PreDestroy`, and other approaches for custom initialization, post-processors are used for processing multiple beans.







## Logging

For our logging, we are going to use a **Logback** component. It is automatically added via `spring-boot-starter`. 

The Logback component is accessible through an external interface called `slf4j`. The `Logger` class is imported from the `slf4j` library:

```java
import org.slf4j.Logger;
//...

@Component
public class Runner implements CommandLineRunner {
    private static final Logger LOGGER = LoggerFactory.getLogger(DemoApplication.class);
    @Override
    public void run(String... args) {
        LOGGER.info("Spring Boot application was launched!");
    }
}
```

```shell
> 12:05:30.102 [main] INFO com.example.app.LoggingApplication - Spring Boot application was launched!
```







### General info

The `Logger` class has several methods, each of them provides logging at different levels (from the least critical level to the most critical one):

1. **Debug:** used to help track program execution for fixing bugs or issues.
2. **Info:** used to log general information about the execution of the program, for example, service start, service stop, configurations and many more.
3. **Warn:** used when unexpected events happen that do not affect the user. For example, repeated attempts to access a resource, missing secondary data, switching from a primary server to a back-up server, or a possible disconnection with the server.
4. **Error:** used to track issues that affect the result of the operation but do not terminate the program. For example, when a database is temporarily unavailable. 
5. **Trace:** used to create more detailed and high-volume sets of information about program execution.



In the example above, the level (`INFO`) and the logger name (`LoggingApplication`) are shown. 



The **format** of the log message is usually:

```she
[date time] [log level] [message]
```

Examples:

```shell
[2021-02-02 15:00:00] [INFO] User 'demo' has registered
[2021-02-02 01:00:10] [ERROR] User 'alex98' cannot log in because the database is temporarily unavailable
```







### File Output

By default, Spring Boot logs only to the console and does not write log files. If you want to write log files in addition to the console output, you need to set a `logging.file.name` or `logging.file.path` property in the `application.properties` file located in `src/main/resources/`.

- If there are both `name` and `path` properties, info from the `path` will be ignored.
- if there is only the `path` property, the default name for a log gile is `spring.log`.



Example:

```properties
logging.level.root=info
logging.pattern.console=%d{HH:mm} %-5level %logger{36} - %msg%n
logging.file.name=log/logfile.log
```

Also, we defined the lowest level of logging  which is important for us. Here the information from `debug` and `trace` levels of logging will be ignored.







## HTTP messages

There are two types of messages: **requests** and **responses**. A request is an operation that a client wants to perform on the server, and a response is an answer from the server to an incoming request.





### Format

In the HTTP protocol, all messages consist of text strings. Both requests and responses have roughly the same standardized format:

1. **Start line** -- $\textcolor{red}{\texttt{required}}$:
   - for requests, it indicates the type of request (**method**) and the URL where to send it (**target**);
   - for responses, it contains a status code to determine the success of the operation.
2. **Headers** -- $\textcolor{red}{\texttt{required}}$: describe the message and convey various parameters.
3. **Body** -- $\texttt{can be empty}$: contains data.





### HTTP interaction

<img src="./pics for conspects/spring_boot/http_messages.png" alt="http_messages" style="zoom:80%;" />





### Methods

HTTP defines a set of request types (methods) to interact with web resources. Here are the most commonly used query methods:

- `GET` -- used to retrieve data from a resource. Multiple identical requests will have the same effect.
- `HEAD` -- similar to `GET`, but retrieves only headers, without the response body.
- `POST` -- submits data to the specified resource. It can create new resources or update existing ones. Multiple identical requests may have different effects.
- `PUT` -- used to update or replace an existing resource with the request payload. Multiple identical requests will have the same effect.
- `DELETE` -- deletes a specified resource. 





### Status code

| code pattern | description                                                  |
| :----------- | ------------------------------------------------------------ |
| `1xx`        | Information code. It means the request has been received and the process is continuing. |
| `2xx`        | Success code. Informs that the client's action has been successfully accepted for processing. |
| `3xx`        | Redirection code. It means further action must be taken in order to complete the request. |
| `4xx`        | Client Error. It reports errors on the client's side.        |
| `5xx`        | Server Error. It indicates that the operation was unsuccessful due to the fault of the server. |







## Spring repositories

We might want to update or delete the data from the database. These operations are called **CRUD** operations, short for Create, Read, Update, and Delete.

In Java and Kotlin, we manipulate database data using an entity (it is simply a class). Spring data has the `Repository` concept. A **repository** is an abstraction that helps us reduce the amount of boilerplate code. Spring Data provides several repository interfaces. All these interfaces are database-agnostic. This means you can use these abstractions with any relational or NoSQL database.



The base interface is **`Repository`**:

```java
@Indexed
public interface Repository<T, ID> {}
```

`@Indexed` means that all descendants should be treated as candidates for repository beans. 

The `Repository` interface is generic. `T` is the type of the entity, `ID` is the type of the primary key. 



The **`CrudRepository`** interface is used for CRUD operations:

```java
@NoRepositoryBean
public interface CrudRepository<T, ID> extends Repository<T, ID> {
    // CREATE/UPDATE methods
    <S extends T> S save(S entity);
    <S extends T> Iterable<S> saveAll(Iterable<S> entities);

    // READ methods
    Optional<T> findById(ID id);
    boolean existsById(ID id);
    Iterable<T> findAll();
    Iterable<T> findAllById(Iterable<ID> ids);
    long count();

    // DELETE methods
    void deleteById(ID id);
    void delete(T entity);
    void deleteAllById(Iterable<? extends ID> ids);
    void deleteAll(Iterable<? extends T> entities);
    void deleteAll();
}
```

The `CrudRepository` interface has basic auto-generated CRUD operations. 

It has the same declared methods for the `Create` and `Update` operations. Under the hood, Spring data checks if a given entity is new or old and, depending on that, creates or updates the entity.





### Declaring a repository

Lets use a `Treadmill` class as an entity:

```java
// an annotation goes here
public class Treadmill {
    private Integer code;
    private String model;

    // constructors, getters, setters
}
```

We didn't annotate the `Treadmill` class. The reason is that the entity declaration can vary depending on the actual database you are using. Depending on your target database, you have to choose:

- `@Entity` (for relational databases. Also, `@Id` is used to mark a primary key)
- `@Document` (for NoSQL document-oriented databases like MongoDB)
- `@KeySpace` (for NoSQL graph database like Neo4J)
- or another annotation.



Now lets create a repo for `Treadmill` entities:

```java
public interface TreadmillRepository extends 
    CrudRepository<Treadmill, Integer> {

}
```

We will use the `Integer` property `code` as the ID. 



Now lets use the repo:

```java
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class);
    }

    @Component
    public class Runner implements CommandLineRunner {
        private final TreadmillRepository repository;

        public Runner(TreadmillRepository repository) {
            this.repository = repository;
        }

        @Override
        public void run(String... args) {
            // all CRUP operations are done here
        }
    }
}
```







## REST

**REST (Representational State Transfer)** is a fairly common way of interaction between client applications and services on the Internet. It is one of the possible ways to use HTTP. It is not a standard, but rather a set of useful recommendations.



There are six principles that guarantee the service to be *RESTful*:

1. **Client-server interaction model.** By separating the user interface from the data warehouse server, we improve and simplify application operation.
2. **Stateless.** Each request from a client to a server must contain all necessary information and cannot rely on any state stored on the server side. According to REST, the service does not store the results of the previous operation. Simply put, it works according to the *"Asked, answered, forgotten"* concept.
3. **Cacheable.** A request-response pair can be marked as cached and stored on the user side. It is possible to draw an analogy to web page caching: if a page was downloaded once, it can be accessed without addressing the server again.
4. **Uniform interface.** REST architecture specifies that any REST service must be understandable without its developer.
5. **Layered system.** A client cannot just tell whether it is connected directly to the end server or an intermediary along the way.
6. **Code on demand [Optional]**. On request, the service must give executable code in the form of an applet or script to be executed on the client's side. In practice, it is very seldom used.



In the REST concept, interaction with resources is performed by calling the URL of the resource and four basic HTTP methods: `GET`, `POST`, `PUT`, `DELETE`. 

- `POST` is used to create new resources. If the resource is successfully created, the HTTP code *201 (Created)* is returned, the address of the created resource is passed in the header `Location`.
- `GET` is used to retrieve data. If the `GET` method is successful and does not contain address errors, it returns an XML or JSON representation of the resource in combination with an HTTP *200 (OK)* status code. In case of errors, the code *404 (NOT FOUND)* or *400 (BAD REQUEST)* is returned.
- `PUT` method either creates a resource by the specified ID or updates an existing one. If the update is successful, the code is *200 (OK)*; *204 (NO CONTENT)* is returned if no content in the response body has been transmitted.
- `DELETE` method is used to remove a specific resource. If the deletion is successful, *200 (OK)* HTTP code is returned, together with the response body containing the data of the remote resource. It is also possible to use HTTP code *204 (NO CONTENT)* without the response body.







## SOLID

Each letter in SOLID refers to a distinct design principle:

- **S**ingle Responsibility Principle (*SRP*) -- every class should have a single responsibility or single job or single purpose. Use *layers* in your application and break God classes into smaller classes or modules.

- **O**pen-Closed Principle (*OCP*) -- you should be able to extend a class behavior, without modifying it.

- **L**iskov Substitution Principle (*LSP*) -- any class that is the child of a parent class should be usable in place of its parent without any unexpected behavior.

- **I**nterface Segregation Principle (*ISP*) -- avoid fat interface and give preference to many small client-specific interfaces. 

- **D**ependency Inversion Principle (*DIP*):

  1. High-level modules/classes should not depend on low-level modules/classes. Both should depend upon abstractions.

  2. Abstractions should not depend upon details. Details should depend upon abstractions.

*SOLID* principles help you to organize your code. Applying them, you make your code more structured and clean, so it doesn't look like a maze anymore.







## Jackson

Jackson is a powerful, lightweight, and flexible Java library that provides a way to convert Java objects to JSON and vice versa. The  `jackson-databind` dependency can be used in Spring applications. 

*A quick summary.* The `ObjectMapper` class is a Jackson serializer/deserializer. Its `writeValueAsString()` method is used to convert Java object to JSON, and its `readValue()` method is used for the opposite. 





### Serialization

Imagine we have a class `Task`:

```java
public class Task {
    private int id;
    private String name;
    private String description;
    private Date date;

	// contructor, getters, setters
}
```



The `ObjectMapper` object is used to convert an instance of `Post` into the JSON format:

```java
Task task = new Task(1, "sing", "sing a song");

ObjectMapper objectMapper = new ObjectMapper();

String json = objectMapper.writeValueAsString(task);
System.out.println(json);
```

```shell
{"id":1,"name":"sing","description":"sing a song","date":1689714161375}
```



Let's get a **formatted JSON string**:

```java
String json = objectMapper
    .writerWithDefaultPrettyPrinter()
    .writeValueAsString(task);
System.out.println(json);
```

```shell
{
  "id" : 1,
  "name" : "sing",
  "description" : "sing a song",
  "date" : 1689714218288
}
```





#### `@JsonProperty`

Basically, the `@JsonProperty` annotations shows where the value for the property can be found. You can either create class getters or use the annotation in two ways:

1. The `@JsonProperty` annotation allows you to change the name used in JSON as a key:

   ```java
   public class Post {
       private int id;
       private String name;
       private String description;
       
       @JsonProperty("createdAt")
       private Date date;
       
       // contructor, getters, setters
   }
   ```

   ```shell
   {
     "id" : 1,
     "name" : "sing",
     "description" : "sing a song",
     "createdAt" : 1689714308210
   }
   ```

   

2. It allows to denote a custom getter/setter that will be used on a JSON property (even if the property is not a field of the class, like `currentTime` in the example):

   ```java
   public class Post {
       private int id;
       private String name;
       private String description;
       private Date date;
   
       // contructor, getters, setters
   
   
       @JsonProperty("date")
       public String getModifiedDate() {
           return (new SimpleDateFormat("dd-MM-yyyy")).format(date);
       }
       
       @JsonProperty("currentTime")
       public String getCurrentTime() {
           DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
           return LocalTime.now().format(formatter);
       }
   }
   ```

   ```java
   {
     "id" : 1,
     "name" : "sing",
     "description" : "sing a song",
     "date" : "18-07-2023",
     "currentTime" : "23:11"
   }
   ```





#### `@JsonIgnore`

`@JsonIgnore` helps us ignore some Java class fields:

```java
public class Post {
    @JsonIgnore
    private int id;
    private String name;
    private String description;
    private Date date;

    // contructor, getters, setters
    
    @JsonProperty("date")
    public String getModifiedDate() {
        return (new SimpleDateFormat("dd-MM-yyyy")).format(date);
    }
}
```

```shell
{
  "name" : "sing",
  "description" : "sing a song",
  "date" : "18-07-2023"
}
```





#### `@JsonPropertyOrder`

By default, the ordering of the fields in the serialized JSON depends on the JDK. `@JsonPropertyOrder` allows us to set a specific order when serializing a Java object:

```java
@JsonPropertyOrder({
        "date",
        "id",
        "name",
        "description"
})
public class Post {
    @JsonIgnore
    private int id;
    private String name;
    private String description;
    private Date date;

    // contructor, getters, setters
    
    @JsonProperty("date")
    public String getModifiedDate() {
        return (new SimpleDateFormat("dd-MM-yyyy")).format(date);
    }
}
```

```java
{
  "date" : "18-07-2023",
  "name" : "sing",
  "description" : "sing a song"
}
```





### Deserialization

To convert a JSON object to a Java object, the `readValue()` method from the `ObjectMapper` is used. 

```java
ObjectMapper objectMapper = new ObjectMapper();

String json = """
    {
      "date" : "18-07-2023",
      "id" : 1,
      "name" : "sing",
      "description" : "sing a song"
    }""";

Task task = objectMapper.readValue(json, Task.class);
```





#### Restrictions

For Jackson to be able to convert JSON into a Java object of some class, this class must satisfy several conditions:

- The class must have an empty constructor, and the fields must not be `final`. Jackson will first create an instance of the class, and then put values into all fields through reflection.  Setters are only needed if you want to change the value in the fields — Jackson doesn't use them.

- The class must have a constructor with the `@JsonCreator` annotation, and all its parameters must have the `@JsonProperty` annotation, which must necessarily contain the name from JSON.

  ```java
  public class Task {
      private int id;
      private String name;
      private String description;
      private Date date;
      
      Task() {}
      
      @JsonCreator
      public Task(@JsonProperty("id") int id,
                  @JsonProperty("name") String name,
                  @JsonProperty("description") String description,
                  @JsonProperty("date") String date) throws ParseException {
          this.id = id;
          this.name = name;
          this.description = description;
  
          SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
          this.date = dateFormat.parse(date);
      }
      
      // getters and setters
  }
  ```

  





## `@RestController`

A **controller** is a part of the application that handles these API methods. A basic **REST-based controller** (server) is used for retrieving data through `GET` requests. 

```java
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskController { }
```

The `@RestController` annotation makes a class provide exact endpoints (URLs) to access the REST methods. The annotation is a wrapper of two different annotations:

1. `@Controller` contains handler methods for various requests. Since we opted for `@RestController`, the methods are related to REST requests.
2. `@ResponseBody` binds the return value of each handler method to a web response body. When we send a request, the HTTP response we receive is <u>in JSON format</u>. 







### `@RequestMapping`

`@RequestMapping` is an annotation used to map HTTP requests to handler methods in a controller class. It defines the routes and endpoints for incoming HTTP requests and specifies how these requests should be handled.



Simple, the `@RequestMapping` annotation allows you to define the URL pattern that should be used to invoke a specific method within the controller class:

```java
@RestController
@RequestMapping("/tasks")
public class TaskController { ... }
```

Here, the <u>base path</u> for the controller is set to `localhost:<port>/tasks`. So you only need to specify the additional part of the URL for such annotations as `@GetMapping` and `@PostMapping`. 



`@RequestMapping` has some attributes:

- `method` -- specifies the type of HTTP request
-  `value` or `path` -- defines the URL pattern 
- `produces` and `consumes` -- specify the media types that the method can produce and consume, respectively



`@GetMapping`, `@PostMapping`, etc. are *shortcut annotations* used for defining HTTP requests (you can read about them below). For example, `GetMapping("/tasks")` is equal to `@RequestMapping(calue = "/tasks", method = RequestMethod.GET)`.







### `GET`

#### `@GetMapping`

To implement a `GET` request, we can use the `@GetMapping` annotation. It indicates what URL path should be associated with a `GET` request:

```java
public class Task {
    private int id;
    private String name;
    private String description;

    public Task() {}

    public Task(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    // getters and setters
}


@RestController
public class TaskController {
    private final List<Task> taskList = List.of(
            new Task(1, "task 1", "A first task"),
            new Task(2, "task 2", "A second task")
    );

    @GetMapping("/tasks")
    public List<Task> getTasks() {
        return taskList;
    }
}
```

We can create a `GET` request that returns a list of tasks in JSON format when `http://localhost:8080/tasks` is accessed.

It is essential to implement getters and setters. If they are not implemented, Spring cannot display object contents correctly. Spring will try to return all data from our controller in JSON format or similar.

When we work with Spring, we can face a lot of `GET` requests at the same time. So, using an <u>immutable collection</u> to eliminate any thread-based issues would be a good idea.





#### Returning a status code

By default, a method annotated with `@GetMapping` returns a response with the status code `200 OK` if a request was processed successfully and the status code `500` if there is an uncaught exception. 

However, we can change this default status code by returning an object of the `ResponseEntity<T>` class:

```java
@GetMapping("/tasks")
public ResponseEntity<List<Task>> getTasks() {
    return new ResponseEntity<>(taskList, HttpStatus.ACCEPTED);
}

// the code 202 (ACCEPTED) instead of 200 (OK) is returned 
```





#### `@PathVariable`

There is an option to get a value from the URL. To do this, the `@PathVariable` annotation is used:

```java
@RestController
public class TaskController {
    private final List<Task> taskList = List.of(
        new Task(1, "task1", "A first test task"),
        new Task(2, "task2", "A second test task")
    );

    @GetMapping("/tasks/byId/{id}")
    public Task getTask(@PathVariable int id) {
        return taskList.get(id);
    }

    @GetMapping("/tasks/byName/{name}")
    public Task getTask(@PathVariable("name") String name) {
        for (Task task : taskList) {
            if (task.getName().equals(name)) {
                return task;
            }
        }
        return null;
    }
}
```







### `POST`

With `POST` requests, users can add information by sending **values** they wish to upload. The `POST` requests are implemented using a `@PostMapping` annotation. 

If it works, the code `200 (OK)` is returned. If a `POST` parameter is either missing or invalid, a user receives a `400 (Bad Request)`.

We advise using a **thread-safe object** to work with data in a `@RestController`. The controller can get multiple requests simultaneously, which are processed by different threads. If the object is not thread-safe, multiple requests can lead to data loss and other unexpected errors.







#### `@RequestParam`

A `@RequestParam` is a variable provided by a user through the **query parameters**. It can be provided in two ways:

1. In the query parameters section of a REST request (in postman, `Params -> Query Params`).
2. In the URL path (`localhost:<port>/<api-path>?<param>=<value>&<param>=<value>`).

When we provide a parameter through the query parameters, we need to set a name and a value. The name and the type of the parameter should match the name and the type of the `@RequestParam`.

If a `@RequestParam` parameter is either missing or invalid, a user receives a `400 (Bad Request)`.







#### `@PostMapping`

The server should be able to receive data and store it somewhere. To make this possible, the `@PostMapping` annotation.

To show how it works, we will extend the example with tasks:

```java
@RestController
public class TaskController {
    private int nextId = 0;
    private final List<Task> taskList = new ArrayList<>();
    
    // methods for `GET` requests
    
    @PostMapping("/tasks/addTask")
    public Task addTask(@RequestParam String name, @RequestParam String descr) {
        Task createdTask = new Task(nextId, name, descr);
        nextId++;
        
        taskList.add(createdTask);
        return createdTask;
    }
}
```

The url `http://localhost:8080/tasks/addTask?name=sing&descr=sing%20a%20song` will add a new task with the name `sing` and description `sing a song`  to the `taskList`.







#### `@RequestBody`

The `@RequestBody` annotation is commonly used in `POST` requests to extract the request payload or body. It helps map the data to a specific parameter in the controller method. It tells Spring to deserialize the request body into the corresponding Java object automatically.

```java
@PostMapping("tasks/addTask")
public boolean addTask(@RequestBody Task task) {
    nextFreeId = task.getId() + 1;
    taskList.add(task);
    return true;
}
```

It is possible to send multiple JSON objects in a single request (as a JSON array) using a list of objects in the `@RequestBody`:

```java
@PostMapping("tasks/addTask")
public boolean addTask(@RequestBody List<Task> taskList) {
    this.taskList.addAll(taskList);
    nextFreeId = taskList.last().getId() + 1;
    return true;
}
```



In addition to JSON arrays, it is also possible to use a different format. For example, we can use XML. To do this, we need to add `consumes = MediaType.APPLICATION_XML_VALUE` to the `@PostMapping` annotation:

```java
@PostMapping(value = "tasks/addTask", consumes = MediaType.APPLICATION_XML_VALUE)
public boolean addTask(@RequestBody Task task) {
    taskList.add(task);
    nextFreeId = task.getId() + 1;
    return true;
}
```

If a `consumes` argument is not provided, it will be JSON by default. There are many other `MediaType` values. For example, `TEXT_PLAIN` can be used for plain text, and `TEXT_HTML` can be used for HTML.







### `PUT`

`PUT` requests allow users to  update or replace an existing resource with the request payload.



#### `@PutMapping`

The `@PutMapping` annotation is used to execute `PUT` requests. 

```java
@RestController
public class TaskController {
    private int nextId = 0;
    private final List<Task> taskList = new ArrayList<>();
    
    // methods for `GET` requests
    // methods for `POST` requests
    
    @PutMapping("tasks/updateTaskNameById/{id}")
    public boolean updateTask(@PathVariable("id") int id,
                              @RequestParam String name) {
        for (var task : taskList) {
            if (task.getId() == id) {
                task.setName(name);
                return true;
            }
        }
        return false;
    }
}
```

For example, there are three tasks now. The url `http://localhost:8080/tasks/updateTaskNameById/0` updates the task with `id=0` and returns `true` as a response. 







### `DELETE`

`DELETE` requests allow users to remove existing data from an application. They are implemented using a `@DeleteMapping` annotation. 



#### `@DeleteMapping`

```java
@RestController
public class TaskController {
    private int nextId = 0;
    private final List<Task> taskList = new ArrayList<>();
    
    // methods for `GET` requests
    // methods for `POST` requests
    // methods for `PUT` requests
    
    @DeleteMapping("tasks/deleteTask")
    public Task deleteTask(@RequestParam int id) {
        for (Task task : taskList) {
            if (task.getId() == id) {
                taskList.remove(task);
                return task;
            }
        }
        return null;
    }
}
```































































## *NOT EDITED PART*



**Spring Data JPA** 

JPA -- *Jakarta Persistence API* -- interface specification that maps java classes to database table. Thus, we can interact with the database without writing any SQL code. 





**JpaRepository**

A default interface that maps [Entity class](###`@Entity`) to a database table. The name of the table is the same as the name of the class. 

`JpaRepository` has two generic parameters. The first refers to the Entity class, the second refers to the type of primary key.

For example, we have the Entity class `Student`:

```java
@Entity
public class Student {
  @Id
  @SequenceGenerator(
      name = "student_id_sequence",
      sequenceName = "student_id_sequence",
      allocationSize = 1
  )
  @GeneratedValue(
      strategy = GenerationType.SEQUENCE,
      generator = "student_id_sequence"
  )
  private Long id;
  private String name;
  private Integer age;

  // constructors
  // getters and setters 
}
```

We create a `StudentRepository` interface which allows us to use a database table named `Student`:

```java
public interface StudentRepository extends JpaRepository<Student, Long> {
}
```

 The second parameter is `Long` since `id` of `Student` class is a primary key and has a type `Long`. 
