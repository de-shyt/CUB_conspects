# Spring Boot 

[TOC]







## Part I - Introduction

### Idea

Spring Boot is a framework built on top of the Spring framework. It provides a set of defaults and conventions, allowing developers to quickly create applications with minimal configuration.

Spring Web MVC is an MVC architecture which is used for web applications. Via annotations, it abstracts away a lot of details, thus simplifying the development.

Apache Tomcat is used to provide a web server environment in which Java code can also run. A file with `yml` extension can be created inside a `resources` directory in order to provide server settings (change listening port, for example). 





### Changing the logo :)

As you know, when starting the demo Spring Boot application, you see the default Spring logo.

To change the logo, you first need to create a file named `banner.txt` that contains your custom logo and then put it in the `/src/main/resources` directory (next to the `application.properties` file).

To create a stunning logo, you can use this [Spring Boot Banner Generator](https://springhow.com/spring-boot-banner-generator/). 







### Project structure

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





#### `build.gradle`

Dependencies used by Spring Boot application are specified in the `build.gradle` file.

```java
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

The first dependency adds the Spring Boot framework to this project, and the second brings test libraries integrated with Spring Boot. These dependencies are called **starters** and are enough for the simplest Spring Boot application. Each starter dependency is a <u>group</u> of related dependencies.

There are more of starters dependencies. All the starters use a similar naming pattern: `spring-boot-starter-*`, where `*` denotes a type of application. It can be, for example, `web` or `security`.





#### `application.properties`

Spring Boot uses the **convention-over-configuration** approach. As such, a developer only needs to specify unconventional aspects of the application, while all other aspects work by default.

To configure a Spring Boot application, there is an `application.properties` file located in `src/main/resources`. This file is empty in a newly generated project, but the application still works thanks to default implicit configurations.

The properties can also be stored in the YAML format within the `application.yml` file. We intend to add examples of it in the future.







### Dependency injection

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







### IoC containers

**IoC**, which stands for **Inversion of Control**, is the principle used by frameworks. IoC means that, first, the framework calls the source code, then the source code calls the library functions. 

IoC is used by Spring to implement dependency injection. Thus, objects can define the dependencies they need to run successfully. These dependencies are defined through constructor arguments, factory method arguments, or properties set on the object instance.





#### Spring IoC containers

For the Spring application, we need a few components -- *containers* -- to implement the required functionality. 

The Spring containers manage the lifecycle of the application from start to finish. They manage various components created for the application and handle any required dependency injections. 

The Spring containers can be configured through metadata. Two types of metadata are used in Spring: **XML** and **annotations** (annotations are more preferable). The XML approach involves defining class-related data in an external XML file, which can be loaded and used in the Spring application.

The annotations allow us to build objects with the required features and configurations. Such objects are called **POJO classes**. 

<u>The Spring container consists of POJO classes and Metadata.</u> 





#### POJO

The term **POJO** stands for **Plain Old Java Object**. A POJO is the most basic object type and contains no ties to frameworks. This means that POJOs are valid objects for any application.

POJOs can have properties, getters and setters, methods, but it cannot extend or implement framework-specific classes and interfaces or contain annotations.





#### JavaBeans

A **JavaBean** is a POJO with some additional requirements and restrictions:

- classes are required to be serializable (meas the state of the class can be converted to the byte stream)
- they need private fields and a no-argument constructor. 

These classes can also be customized and configured using Spring metadata. To do this, we can add annotations. For example, the `@Bean` annotation can be added to a factory method to define its return value as a **Spring bean** (a POJO or JavaBean created and managed by the instance of the Spring IoC container). 

With annotations, it is possible to add any configurations to preexisting classes without creating additional files.





#### `BeanFactory`

The **`BeanFactory`** is an interface that allows for the configuration and management of objects. It can produce container-managed objects known as *beans*, which can organize the backbone of your application. These beans look like regular Java objects, but they can be created during application startup, registered, and injected into different parts of the application by the container.





#### `ApplicationContext`

`BeanFactory` is a **root** interface for accessing the Spring IoC container. `ApplicationContext` is an interface that extends `BeanFactory`. Since`ApplicationContext` has more functionality, it is more preferable than `BeanFactory`.

`ApplicationContext` objects provide bean configurations for the application setup. 

There are two ways to create metadata (bean definitions): by using an XML configuration file or annotations. `BeanFactory` doesn't support annotation-based configuration, while `ApplicationContext` does. 

Options for creating `ApplicationContext`:

- **`FileSystemXmlApplicationContext`** -- loads bean definitions from an XML file that is provided to the constructor through its full file path.
- **`ClassPathXmlApplicationContext`** -- loads bean definitions from an XML file that is provided as a classpath property. 
- **`WebApplicationContext`** -- loads the servlet configuration from a file `web.xml`. Inside this file, configurations for each servlet are set. 
- **`AnnotationConfigApplicationContext`** -- creates and annotation-based context from a `@Configuration` class (= the class contains Spring bean configurations.)





Since XML configurations files are seldom used nowadays, lets forget about them and look at annotation-based application context:

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







##### `getBean()`

`ApplicationContext` overloads the `getBean()` methods inherited from `BeanFactory`:

- `T getBean(Class<T> requiredType)`
- `Object getBean(String name)`   <--------   returns an Object class!
- `T getBean(String name, Class<T> requiredType)`

```java
context.getBean("personMary"); // returns an Object object
context.getBean("personMary", Person.class) // returns a Person object
```







##### `@ComponentScan`

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







### Spring beans

Spring can create all the necessary objects during the application startup and put them in a container. Then, each class can retrieve the objects it needs from this container.

These container-managed objects are known as **beans,** and they organize the backbone of your application. They look exactly like standard Java or Kotlin objects but can be created and instantiated during the application startup, and then injected into different parts of an application by the container.

❗There is no need to use only Spring beans and ignore ordinary objects. Beans are usually used to form the backbone of your app and separate it by layers and configuration files. 





#### Declaring beans

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





#### Autowiring beans

Now that you have declared a bean, you can use it to create other beans that depend on it.

The Spring IoC container provides the DI mechanism that allows us to do that. A bean with a suitable type can be automatically injected into a method annotated with `@Bean`. The `@Autowired` annotation is used. 



**Example 1**

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



**Example 2**

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







#### `@Qualifier`

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







### Components

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







#### Autowiring components

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







#### Specializations of components

As mentioned above, there are several specializations of components depending on their role in the Spring application:

- `@Component` indicates a generic Spring component.
- `@Service` indicates a business logic component but doesn't provide any additional functions.
- `@Controller` / `@RestController` indicates a component that can work in a REST web services.
- `@Repository` indicates a component that interacts with an external data storage (e.g., a database).

If your component doesn't need to communicate with a database or return an HTTP result, you can use the `@Service` annotation. Also, `@Component` can always be replaced with `@Service`.







### `CommandLineRunner`

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







### Scopes of beans

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







### Bean lifecycle

When a Spring application is launched, the Spring Container gets started. The container is mainly responsible for managing the **lifecycle** of beans from their creation to destruction.

```
container started 
⇓
dependencies injected
⇓
Bean initialized. Ready for use
⇓
bean is used by the app
⇓
Bean destroyed
```

A significant difference exists between singletons and beans annotated with `@Scope("prototype")`. Spring doesn't destroy prototypes and doesn't allow us to customize their lifecycle.





#### Initialization and destruction

The Spring container performs this initialization automatically, but it also allows us to customize the initialization. We may want to load resources, read a file, connect to a database, etc. 

The same is about destruction. Before destroying the bean, some custom cleanup may be necessary, such as closing some connections, cleaning files, and so on.

- The methods **can** have any names and access modifiers.
- The methods **must not** have any arguments. Otherwise, an exception will be thrown.





##### Option 1: using annotations

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





##### Option 2: implement some interfaces

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





##### Option 3: use an XML bean definition file

This is an outdated way mostly used for legacy applications. Forget it. 







#### Post-processors

You can customize beans using the `BeanPostProcessor` interface. Some custom operations will be run before or after the bean is initialized. To use this feature, the `postProcessBeforeInitialization` or `postProcessAfterInitialization` methods need to be overriden.

Note that a `BeanPostProcessor` is executed for each bean defined in the Spring context, including the beans created by the framework. However, it is possible to keep beans from being modified using conditions.

Post-processors are an advanced concept. Unlike `@PostConstruct`, `@PreDestroy`, and other approaches for custom initialization, post-processors are used for processing multiple beans.







### Logging

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







#### General info

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







#### File Output

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







### HTTP messages

There are two types of messages: **requests** and **responses**. A request is an operation that a client wants to perform on the server, and a response is an answer from the server to an incoming request.





**Format:**

In the HTTP protocol, all messages consist of text strings. Both requests and responses have roughly the same standardized format:

1. **Start line** -- $\textcolor{red}{\texttt{required}}$:
   - for requests, it indicates the type of request (**method**) and the URL where to send it (**target**);
   - for responses, it contains a status code to determine the success of the operation.
2. **Headers** -- $\textcolor{red}{\texttt{required}}$: describe the message and convey various parameters.
3. **Body** -- $\texttt{can be empty}$: contains data.





**HTTP interaction:**

<img src="./pics for conspects/spring_boot/http_messages.png" alt="http_messages" style="zoom:80%;" />





**HTTP methods:**

HTTP defines a set of request types (methods) to interact with web resources. Here are the most commonly used query methods:

- `GET` -- used to retrieve data from a resource. Multiple identical requests will have the same effect.
- `HEAD` -- similar to `GET`, but retrieves only headers, without the response body.
- `POST` -- submits data to the specified resource. It can create new resources or update existing ones. Multiple identical requests may have different effects.
- `PUT` -- used to update or replace an existing resource with the request payload. Multiple identical requests will have the same effect.
- `DELETE` -- deletes a specified resource. 





**Returned status code:**

| code pattern | description                                                  |
| :----------- | ------------------------------------------------------------ |
| `1xx`        | Information code. It means the request has been received and the process is continuing. |
| `2xx`        | Success code. Informs that the client's action has been successfully accepted for processing. |
| `3xx`        | Redirection code. It means further action must be taken in order to complete the request. |
| `4xx`        | Client Error. It reports errors on the client's side.        |
| `5xx`        | Server Error. It indicates that the operation was unsuccessful due to the fault of the server. |







### Spring repositories

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





#### Declaring a repository

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







### REST

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







### SOLID

Each letter in SOLID refers to a distinct design principle:

- **S**ingle Responsibility Principle (*SRP*) -- every class should have a single responsibility or single job or single purpose. Use *layers* in your application and break God classes into smaller classes or modules.

- **O**pen-Closed Principle (*OCP*) -- you should be able to extend a class behavior, without modifying it.

- **L**iskov Substitution Principle (*LSP*) -- any class that is the child of a parent class should be usable in place of its parent without any unexpected behavior.

- **I**nterface Segregation Principle (*ISP*) -- avoid fat interface and give preference to many small client-specific interfaces. 

- **D**ependency Inversion Principle (*DIP*):

  1. High-level modules/classes should not depend on low-level modules/classes. Both should depend upon abstractions.

  2. Abstractions should not depend upon details. Details should depend upon abstractions.

*SOLID* principles help you to organize your code. Applying them, you make your code more structured and clean, so it doesn't look like a maze anymore.







### Jackson

Jackson is a powerful, lightweight, and flexible Java library that provides a way to convert Java objects to JSON and vice versa. The  `jackson-databind` dependency can be used in Spring applications. 

*A quick summary.* The `ObjectMapper` class is a Jackson serializer/deserializer. Its `writeValueAsString()` method is used to convert Java object to JSON, and its `readValue()` method is used for the opposite. 





#### Serialization

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





##### `@JsonProperty`

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





##### `@JsonIgnore`

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





##### `@JsonPropertyOrder`

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





#### Deserialization

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





##### Restrictions

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






##### Are getters and setters mandatory? 

Jackson uses getters and setters of a class to access and modify the class's properties during (de)serialization. The getters and setters should be <u>public</u>. 

However, Jackson can work with fields *directly* as well by using field access instead of method access. Jackson will use direct field access to read and write the properties, and getters and setters are no longer required. You can enable field access using `@JsonAutoDetect` annotation:

```java
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class Task {
    private int id;


    private String name;
    private String description;
    private Date date;

    // constructor
    // other methods
}
```







### `@RestController`

A **controller** is a part of the application that handles these API methods. A basic **REST-based controller** (server) is used for retrieving data through `GET` requests. 

```java
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskController { }
```

The `@RestController` annotation makes a class provide exact endpoints (URLs) to access the REST methods. The annotation is a wrapper of two different annotations:

1. `@Controller` contains handler methods for various requests. Since we opted for `@RestController`, the methods are related to REST requests.
2. `@ResponseBody` binds the return value of each handler method to a web response body. When we send a request, the HTTP response we receive is <u>in JSON format</u>. 







#### `@RequestMapping`

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







#### `GET`

##### `@GetMapping`

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





##### Returning a status code

By default, a method annotated with `@GetMapping` returns a response with the status code `200 OK` if a request was processed successfully and the status code `500` if there is an uncaught exception. 

However, we can change this default status code by returning an object of the `ResponseEntity<T>` class:

```java
@GetMapping("/tasks")
public ResponseEntity<List<Task>> getTasks() {
    return new ResponseEntity<>(taskList, HttpStatus.ACCEPTED);
}

// the code 202 (ACCEPTED) instead of 200 (OK) is returned 
```





##### `@PathVariable`

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







#### `POST`

With `POST` requests, users can add information by sending **values** they wish to upload. The `POST` requests are implemented using a `@PostMapping` annotation. 

If it works, the code `200 (OK)` is returned. If a `POST` parameter is either missing or invalid, a user receives a `400 (Bad Request)`.

We advise using a **thread-safe object** to work with data in a `@RestController`. The controller can get multiple requests simultaneously, which are processed by different threads. If the object is not thread-safe, multiple requests can lead to data loss and other unexpected errors.







##### `@RequestParam`

A `@RequestParam` is a variable provided by a user through the **query parameters**. It can be provided in two ways:

1. In the query parameters section of a REST request (in postman, `Params -> Query Params`).
2. In the URL path (`localhost:<port>/<api-path>?<param>=<value>&<param>=<value>`).

When we provide a parameter through the query parameters, we need to set a name and a value. The name and the type of the parameter should match the name and the type of the `@RequestParam`.

If a `@RequestParam` parameter is either missing or invalid, a user receives a `400 (Bad Request)`.







##### `@PostMapping`

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







##### `@RequestBody`

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







#### `PUT`

`PUT` requests allow users to  update or replace an existing resource with the request payload.



The **`@PutMapping`** annotation is used to execute `PUT` requests. 

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







#### `DELETE`

`DELETE` requests allow users to remove existing data from an application. 

They are implemented using a **`@DeleteMapping`** annotation:

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







### Exception handling

Here you will find two ways to return an error message in Spring Boot applications. You can either use the `ResponseStatusException` Spring class or create your own exception using the `@ResponseStatus` annotation. 







#### `ResponseStatusException`

The `ResponseStatusException` class is introduced in Spring 5 for basic error handling and is a part of `org.springframework.web.server` package.

It provides three constructors where `HttpStatus status` (mandatory), `java.lang.String reason` (optional) and `java.lang.Throwable cause` (optional) are specified. By default, Spring Boot doesn't include the `message` field in a response. To enable it, add `server.error.include-message=always` in the `application.properties` file.

The most common `HttpStatus` types are `200 OK`, `404 NOT_FOUND`, `400 BAD_REQUEST`, `403 FORBIDDEN`, and `500 INTERNAL_SERVER_ERROR`.

```java
@RestController
public class TaskController {
    private final List<Task> taskList = new ArrayList<>();
    
    // constructor
    //getters and setters 
    
    @GetMapping("/tasks/byId/{id}")
    public Task getTask(@PathVariable int id) {
        if (id >= taskList.size()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                String.format("The task with id=%d does not exist", id));

        }
        return taskList.get(id);
    }
}
```

```shell
http://localhost:8080/tasks/byId/666
```

```json
{
    "timestamp": "2023-07-23T13:00:45.788+00:00",
    "status": 400,
    "error": "Bad Request",
    "message": "The task with id=666 does not exist",
    "path": "/tasks/byId/666"
}
```

If the exception without a specified HTTP status is thrown (i.e. `RuntimeException` or `IllegalArgumentException`), it will be converted to `500 Internal Server Error`.







#### Custom exceptions

We can write a class that extends `RuntimeException` and add the `@ResponseStatus` annotation:

```java
@ResponseStatus(code = HttpStatus.BAD_REQUEST)
class TaskNotFoundException extends IllegalArgumentException {
    public TaskNotFoundException(String message) {
        super(message);
    }
}
```

```java
@RestController
public class TaskController {
    private final List<Task> taskList = new ArrayList<>();
    
    // constructor
    //getters and setters 
    
    @GetMapping("/tasks/byId/{id}")
    public Task getTask(@PathVariable int id) {
        if (id >= taskList.size()) {
            throw new TaskNotFoundException(
                String.format("The task with id=%d does not exist", id));
        }
        return taskList.get(id);
    }
}
```







#### Custom exception handler

 `@ExceptionHandler` annotation lets us customize error responses. 

`@ControllerAdvice` annotation allows to create a global class for intercepting various exceptions from different parts of an application. In the `@ControllerAdvice` class, we can handle not only custom exceptions but also standard exceptions thrown by Spring itself (i.e., `MethodArgumentNotValidException` invoked by `@Valid` annotation).



The method annotated with `@ExceptionHandler` can be put:

- inside a specific controller = the method can handle exceptions only from that controller;
- inside `@ControllerAdvice` class = the method will handle exceptions thrown from any controller within your application.





**Example**

The `ErrorResponse` class is used to generate a custom error response. It sets properties that will be shown in JSON format:

```java
public record ErrorResponse(LocalDateTime timestamp,
                            int statusCode,
                            String error) {}
```



```java
public class TaskNotFoundException extends RuntimeException {
    public TaskNotFoundException(String details) {
        super("The task with " + details + " does not exist");
    }
}



@ControllerAdvice
public class CustomExceptionHandler 
    extends ResponseEntityExceptionHandler {

    @ExceptionHandler(TaskNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleTaskNotFoundException(TaskNotFoundException e) {
        ErrorResponse response = new ErrorResponse(
                LocalDateTime.now(),
                HttpStatus.BAD_REQUEST.value(),
                e.getMessage()
        );
        
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        // return ResponseEntity.badRequest().body(response);
    }
}
```

The `CustomExceptionHandler` class intercept the thrown exception and gives it to the corresponding method. 



The example of the possible output: 

```json
{
    "timestamp": "2023-07-25T14:44:44.796423346",
    "statusCode": 400,
    "error": "The task with id=666 does not exist"
}
```









## Part II - Spring Security 

### Insecure cryptographic storage

**Insecure cryptographic storage** refers to the weak implementation of cryptographic techniques when storing sensitive data. This can result in data breaches, unauthorized disclosure of confidential information, and other security risks. 

One example of insecure cryptographic storage is storing data in **plain text** without any hashing or encryption.





#### What is salting?

**Salting** is the process of adding random strings to the data before it's hashed (the same input will produce different hash values). 

How does the salting work? For example, the user sets a password. The system generates a random and unique salt value. The salt is not kept secret and is usually stored alongside the hashed password. The combination of the user's password and the salt is then hashed. The hash value is stored in the database. 

When a user attempts to log in, they provide their password. The system retrieves the salt associated with that user's account from the database. The salt and the provided password are combined, and the resulting value is hashed using the same hash function. The newly generated hash value is then compared to the stored hash value in the database. 

The purpose of salting is to add randomness to each user's password before hashing it. This prevents attackers from using precomputed tables (rainbow tables) to quickly look up hash values for commonly used passwords. Even if two users have the same password, the salts make their hashed values different.





#### Weak hashing

Another example of insecure cryptographic storage is using **weak hashing** algorithms. Such algorithms as `MD5` and `SHA1` have been proven to be inadequate to hash sensitive information. These algorithms are designed to be **fast**, but they are **unsalted**, which means the same input will produce the same hash value.  As a result, attackers can use **rainbow table attacks** to quickly find matches for hashed values and reveal the original passwords.

Now, what is a random table attack? A **rainbow table** is a precomputed table containing a large number of hashes and their corresponding original passwords. The rainbow table is generated by hashing many possible passwords in advance and storing the password-hash pairs in a table. 

Attackers can use **rainbow table attacks** for unsalted algorithms. When an attacker gets hold of the hashed passwords from a compromised system, they can compare these hashes with the entries in a rainbow table to find matches quickly, effectively revealing the original passwords. 

To defend against rainbow table attacks, **salted** hashing algorithms like `Bcrypt` are used. In `Bcrypt` algorithm, the hash value varies every time it is computed because of the added salt, making it impractical to use a rainbow table attack. 

```txt
$2a$12$gIB2JLgILNgDIisKsi...  // possible result of `Bcrypt` hashing
// `$2a` means it's using bcrypt version 2a
// `$12` means its cost-factor is 12 rounds = 2^12 = 4096 iterations
```

`Bcrypt` is also designed to be slow. The speed can be adjusted with the cost factor.







#### Weak encryption

Encryption is another technique used for storing sensitive data, especially when the data needs to be **accessed in its original form**. Hashing is not intended to retrieve the original data but rather to confirm the original data matches the stored data's hash. 

Encryption uses a **key** to encode the original content into ciphertext. Without the proper key, it's impossible to decode the original data.

One of the attributes that makes encryption algorithms weak is **insufficient key size**. Such algorithms can be susceptible to **brute force attacks**, where attackers systematically try every possible key until they find the correct one.



To ensure secure cryptographic storage, it is crucial to use strong encryption algorithms with appropriate key sizes and follow best practices for key management. Additionally, a combination of hashing and encryption may be used to protect sensitive data, depending on the use case and security requirements.







### Spring Security Crypto

#### Encryption and hashing principles

One of the ways to protect personal data is **encryption**. There are two kinds of encryption: **symmetric** and **asymmetric**. The major difference between them is in the keys used to encrypt and decrypt data. 

The symmetric encryption uses the same key to encrypt and decrypt data. One of the most widely known and simple examples of symmetric encryption algorithms is **Caesar Cipher**. 

As for the passwords, in general, they should be **hashed**. Every time a user logs into the system, we will hash their password and compare it with the stored hash in the database. For this reason, in cases where the user forgets the password, they can only reset it, but not retrieve the original password from the system. 

Nevertheless, there is still the risk of the hashed passwords getting hacked through a **brute force** or **rainbow table attack**. To slow down the brute force, you can use a solid hashing algorithm, which makes it too time-consuming for hackers. As for the rainbow table, adding salt to the password before hashing protects against it.







#### Adding Spring Crypto to your project

Hashing, salting, and encrypting are very complex procedures. The **Spring Crypto** module includes encryptors, key generators, and password encoders, making it easier to use in your system.

If you are using Spring Boot Security starter, you don't need to add any additional dependencies to use Spring Crypto: they are already included.

```xml
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-security:2.7.2'
}        
```

You can also add Spring Crypto as a separate dependency, even without using the whole Spring Framework:

```xml
dependencies {
    implementation 'org.springframework.security:spring-security-crypto:5.7.2'
}   
```







#### Encryptors and key generators

For **key generators**, there are two easiest options:

- ```java
  String key = KeyGenerators.string().generateKey();
  ```

  Generates a random string with the length of 16 characters. The length is fixed. The generated string consists of uppercase and lowercase letters, numbers and special characters. 

- ```java
  byte[] key = KeyGenerators.secureRandom(16).generateKey();
  ```

  Generate a random key as a byte array. `16` means a random key of 16 bytes (128 bits) will be generated. 



When it comes to **encryptors**, Spring Crypto has two main interfaces for them:

- `BytesEncryptor` -- declares the encryption and decryption of the byte array
- `TextEncryptor` -- declares the encryption and decryption of the `string` objects.







##### `BytesEncryptor`

```java
	@Bean
	public static BytesEncryptor aesBytesEncryptor() {
		String password = "hackme"; // should be kept in a secure place and not be shared    
        byte[] salt = new byte[16]; // Generate a random 16-byte salt
        new SecureRandom().nextBytes(salt);
        return Encryptors.standard(password, salt);
	}
```

The `BytesEncryptor` instance returned by `Encryptors.standard(password, salt)` uses the randomly generated salt during the initialization phase to **derive an encryption key**. This derived encryption key is then used for the actual encryption and decryption operations:

```java
@SpringBootApplication
public class DemoApplication {
	public static void main(String[] args) throws JsonProcessingException {
		SpringApplication.run(DemoApplication.class);

		BytesEncryptor bytesEncryptor = aesBytesEncryptor();

		byte[] inputData = {104, 121, 112, 101, 114, 115, 107, 105, 108, 108};
		byte[] encryptedData = bytesEncryptor.encrypt(inputData);
		byte[] decryptedData = bytesEncryptor.decrypt(encryptedData);
		System.out.println("Input data: " + new String(inputData));
		System.out.println("Encrypted data: " + new String(encryptedData));
		System.out.println("Decrypted data: " + new String(decryptedData));
	}
}
```







##### `TextEncryptor`

Most of the time, data that needs to be encrypted can be represented as `String`. In that case, it's better to use `TextEncryptor`. It has two implementations:

- `NoOpTextEncryptor` -- leaves data as it is;
- `HexEncodingTextEncryptor` -- uses the previously discussed `BytesEncryptor` under the hood. The encrypted data will be hex-encoded, so it's easier to store it in a database.

```java
@Bean
public TextEncryptor hexEncodingTextEncryptor() {
    String password = "hackme"; // should be kept in a secure place and not be shared
    String salt = KeyGenerators.string().generateKey(); // Generate a random 16-byte salt
    return Encryptors.text(password, salt);
}
```







#### Passwords encoders

Hashing is done with the use of `PasswordEncoder`. This interface declares methods to encode input and match hash with raw password.

The most simple encoder implementation is `NoOpPasswordEncoder`:

```java
PasswordEncoder noOpEncoder = NoOpPasswordEncoder.getInstance();
```

It leaves data in plain text, which means it is deprecated. 



The recommended implementations of the strong password encoder:

- `BCryptPasswordEncoder`
- `PbkdfPasswordEncoder`
- `SCryptPasswordEncoder`







##### `BCryptPasswordEncoder`

`Bcrypt` is a salted hashing algorithm designed to be computationally expensive, making it more resistant to brute-force attacks. 

The cost factor represents the number of rounds the algorithm will perform to hash the password. The higher the cost factor, the more rounds the algorithm will execute, increasing the time and computational resources required to hash a password. Typically, the cost factor varies from 4 to 31. If the cost factor is $X$, then $2^X$ rounds will be performed. 

```java
@SpringBootApplication
public class DemoApplication {
	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class);

		int costFactor = 7;
		PasswordEncoder bCryptEncoder = new BCryptPasswordEncoder(costFactor);

		String rawPassword = "aboba";
		String firstEncodedPassword = bCryptEncoder.encode(rawPassword);
		String secondEncodedPassword = bCryptEncoder.encode(rawPassword);

		System.out.println("First encoded password: " + firstEncodedPassword);
		System.out.println("Second encoded password: " + secondEncodedPassword);
	}
}
```

The encoded passwords are different, since the algorithm is salted: 

```txt
First encoded password: $2a$07$ezNryhSQjgmzwGFU9PPuWuue7De1Lcytc2vCGNLnFcp1KyBVKD3Um
Second encoded password: $2a$07$sTwUnWVUkm9Q.fJFaHSy3OwAg/o6n6r7ZkKjt6BjcaIoMT60eVtiK
```



As you know, the **salt** should be stored in the system in order to get a correct hash value. The `BCryptPasswordEncoder` takes care of generating a random salt internally and includes it as part of the resulting hash value. The salt is then used during the authentication process to verify the password without the need for explicit salt storage:

```java
String firstPwd = "aboba";
String firstEncodedPwd = bCryptEncoder.encode(firstPwd);

String secondPwd = "aboba";
System.out.println(bCryptEncoder.matches(secondPwd, firstEncodedPwd)); // true
```


The bcrypt algorithm remains secure, even if the salt and hash value are stored together, due to several reasons. Some of them are:

1. **Computational Cost**: The cost factor makes it difficult and time-consuming for attackers to perform brute-force or dictionary attacks, even if they have access to both the salt and the hash value.
2. **Unique Salt for Each User**: Bcrypt uses a random salt. This means that if two users have the same password, their hashes will be different due to different salts. Having unique salts for each user prevents the use of rainbow tables to quickly look up hash values for commonly used passwords.
3. **Length of Hashed Value**: The output of bcrypt is a fixed-length string, regardless of the input password length. This ensures that an attacker cannot infer anything about the password's length from the hashed value.







##### `DelegatingPasswordEncoder`

There is one more implementation left, namely `DelegatingPasswordEncoder`. It acts as a facade to all password encoding algorithms and makes it possible to select an algorithm at runtime.

The algorithm that was used is stored with a password in the following format: `{id}encodedPassword`. 







### Web security, OWASP

**Web security** is a set of measures and protocols aimed at protecting data from viruses, spam, and other threats that can harm the system. 

Generally, users face the following threats:

- *Malware* (вредоносная программа) such as viruses or Trojans;
- *Dos attack* is a type of hacker attack on a system in which real users receive a denial of service;
- *Phishing* is a type of online fraud in which attackers gain access to confidential user information such as username and password. Two-step user authentication is used to reduce the likelihood of such an attack;
- *Application vulnerabilities*. If a site or program can be hacked, then it has a weak point, which is called a vulnerability.



**Web security vulnerabilities** are prioritized depending on exploitability, detectability, and impact on software.

- *Exploitability* is what hackers should do to exploit the security vulnerability. The high exploitability is when an attacker needs only a web browser, and the low one is when an attacker needs advanced programming and tools.
- *Detectability* answers the question of how easy it is to detect the threat. It is easy to detect if the information is displayed in the URL or error message. In this case, we get the highest detectability level. And if it is in the source code, then it is much more difficult to find. Then the level of detectability will be very low.
- *Impact or Damage* stands for the amount of damage that will be done if the security vulnerability is exposed or attacked. The highest impact will cause a complete system crash and the lowest one does nothing at all.



**OWASP** stands for an **Open Web Application Security Project**, an online community that publishes articles on the topic of web application security, as well as documentation, various tools, and technologies. 

There are many risks and weaknesses that may lead to vulnerabilities, the most frequent ones can be found in the [OWASP TOP-10 rating](https://owasp.org/Top10/), which is updated every three to four years.



Also, companies can hire people to search for vulnerabilities using the **Bug Bounty** program. Through it, people can be recognized and rewarded for finding bugs, especially those related to vulnerabilities. With these programs developers can detect and fix bugs before the general public knows about them, preventing hacking.

In general, they work like this: the company establishes the rules indicating what exactly one can try to break and get a reward for. These can be new features in the application, functional updates, integration with other services.

This approach gives the company the ability to constantly test its product and always know where a problem might arise.







### Authentication and Authorization

**Authentication** is the first step in any security process. It is about validating that users are who they claim to be.

The main types of authentication are as follows:

- *Passwords*. If a person enters the correct username and password, the system grants them access.
- *One-time pins* that grant access for only one session. This level of protection is more reliable than the first, but there is a chance that someone may intercept your one-time pin.
- *An authentication app*. First, the system fills in a password and username and then generates a long one-time access code that changes every 30 seconds making it difficult to intercept.
- *Biometrics*. A user presents a fingerprint or eye scan to gain access to the system. The advantage of biometric identification systems is that the characteristics used in these systems are an integral part of the personality so that it is impossible to lose, transfer, or forget them.

Authentication is always visible to the user so that they can pass it. Moreover, they can partially change it by replacing a password or their username, for example.

Often all the data during the authentication moves through an ID token, which is a formatted character string that contains information such as ID, username, account login time, ID Token expiration date.



**Authorization** often goes after authentication, when the system successfully "recognized" you. 

Authorization checks if you have the right to access the content or resources to which you have requested access. For example, the permission to download a particular file on a server or to provide individual users with administrative access to an application.

Unlike authentication, authorization is not visible to the user and there is no option to change it. That is because only the data owner can provide the permissions. 



|                                   | **Authentication**                                    | **Authorization**                             |
| --------------------------------- | ----------------------------------------------------- | --------------------------------------------- |
| **What does it do?**              | Verifies credentials                                  | Grants or denies permission                   |
| **How does it work?**             | Through passwords, biometrics, one-time pins, or apps | Through settings maintained by security teams |
| **Is it visible to the user?**    | Yes                                                   | No                                            |
| **Is it changeable by the user?** | Partially                                             | No                                            |
| **How does data move?**           | Through ID tokens                                     | Through access tokens                         |





















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
