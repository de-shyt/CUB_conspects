# System Design

*Author: Daria Shutina*



[TOC]



## 24-02-01

### Architecture 

First, the system is decomposed into some components. We need to understand how the components interact with each other (e.g. how they share resources). Then we define structures that are necessary for the implementation. 

**Architecture** is the way system components are organized together. It is represented as a diagram with blocks and arrows. It is a tool for organizing the code, so it is important for the development team, not for the customer. 

In the real world, architecture is not a static image. It constantly changes in order to meet current requirements (customer preferences, time or performance constraints). 





### Requirements

<img src="./pics for conspects/SD/SD 24-02-01 1.png" alt="24-02-01 1" style="zoom:50%;" />









## 24-02-07

### Approaches to decomposition

- **Bottom-up:** you start with small components that solve a specific task. Then you build low-level logic between components. 

  The problem is there can be inconsistent components on the finish line (e.g. when implementation approach is modified). Also, you need a lot of testing code to check is the low-level logic works correctly. 

- **Top-down:** start from creating a prototype you want to achieve, ans then decompose it into components. 

  In this approach, you think about the interfaces first, so you have to encapsulate tasks in this modules. That way you limit the complexity for each component. 





### Basic principles of decomposition

<img src="./pics for conspects/SD/SD 24-02-07 1.png" alt="SD 24-02-07 1" style="zoom:50%;" />

<img src="./pics for conspects/SD/SD 24-02-07 2.png" alt="SD 24-02-07 2" style="zoom: 50%;" />



<img src="./pics for conspects/SD/SD 24-02-07 3.png" alt="SD 24-02-07 3" style="zoom: 50%;" />

**Cohesion** refers to the degree to which the elements <u>inside one module</u> belong together. 

The scheme shows how the cohesion changes depending on the state of the system. Logical cohesion is the worst option, and sequential cohesion (modules create a sequence) is the best one. 



<img src="./pics for conspects/SD/SD 24-02-07 4.png" alt="SD 24-02-07 4" style="zoom: 50%;" />

**Coupling** describes how strong connections <u>between modules</u> are. It shows how many other modules need changes if one module is changed. Ideally, none (none direct coupling is the best option). 

Content coupling is the worst option, when one module knows not only logic, but also internals (e.g. private fields) of the other module. 







### Principles of OO design

<img src="./pics for conspects/SD/SD 24-02-07 5.png" alt="SD 24-02-07 5" style="zoom: 50%;" />



<img src="./pics for conspects/SD/SD 24-02-07 6.png" alt="SD 24-02-07 6" style="zoom: 50%;" />

When constructing a house, do not think what color or material the door needs. 



<img src="./pics for conspects/SD/SD 24-02-07 7.png" alt="SD 24-02-07 7" style="zoom: 50%;" />

In the example, you can create a structure which describes a house, but you cannot understand from the structure what the house is made of. 



<img src="./pics for conspects/SD/SD 24-02-07 8.png" alt="SD 24-02-07 8" style="zoom: 50%;" />



<img src="./pics for conspects/SD/SD 24-02-07 9.png" alt="SD 24-02-07 9" style="zoom:50%;" />



<img src="./pics for conspects/SD/SD 24-02-07 10.png" alt="SD 24-02-07 10" style="zoom:50%;" />



<img src="./pics for conspects/SD/SD 24-02-07 11.png" alt="SD 24-02-07 11" style="zoom:50%;" />







### SOLID

<img src="./pics for conspects/SD/SD 24-02-07 12.png" alt="SD 24-02-07 12" style="zoom:50%;" />

<img src="./pics for conspects/SD/SD 24-02-07 13.png" alt="SD 24-02-07 13" style="zoom:50%;" />

If we want to add new features to the class, we need to extend it, not modify it. 

The optimal solution is to use interfaces, each interface is responsible for a specific feature. 



<img src="./pics for conspects/SD/SD 24-02-07 14.png" alt="SD 24-02-07 14" style="zoom:50%;" />

You should be able to take any subclass and put it where you expect the base class, and everything should work fine. 



<img src="./pics for conspects/SD/SD 24-02-07 15.png" alt="SD 24-02-07 15" style="zoom:50%;" />

Another example. We have interface `Payments` where there are some payment methods:

```java
public interface Payments {
    void payWebMoney();
    void payCreditCard();
    void payPhoneNumber();
}
```

We want to create a class `InternetPaymentService` -- a service which is responsible for the payment and it <u>does not accept</u> payments by phone. If we implement it from the `Payments` interface, the service will have to implement unnecessary methods:

```java
public class InternetPaymentService implements Payments{
    @Override
    public void payWebMoney() { ... }
    
    @Override
    public void payCreditCard() { ... }
    
    @Override
    public void payPhoneNumber() {
        // unnecessary method
    }
}
```

The better solution is to create three interfaces instead of `Payment`:

```java
public interface WebMoneyPayment {
    void payWebMoney();
}

public interface CreditCardPayment {
    void payCreditCard();
}

public interface PhoneNumberPayment {
    void payPhoneNumber();
}

// now only necessary methods will be implemented
public class InternetPaymentService implements WebMoneyPayment,
                                               CreditCardPayment {
    @Override
    public void payWebMoney() { ... }
                                                   
    @Override
    public void payCreditCard() { ... }
}
```



<img src="./pics for conspects/SD/SD 24-02-07 16.png" alt="SD 24-02-07 16" style="zoom:50%;" />









## Practice 1

<img src="./pics for conspects/SD/SD 24-02-08 1.png" alt="SD 24-02-08 1" style="zoom:50%;" />



<img src="./pics for conspects/SD/SD 24-02-08 2.png" alt="SD 24-02-08 2" style="zoom:50%;" />



### Interview part

- **Behavior**

  Besides common questions like who you are and what you expect, you will be asked about previous experience: deadlines, possible conflicts, motivation. 

  When answering this question, you can use **S.T.A.R. approach**.

  - situation - what was the context/background of the situation you were in? where did it occur and what happened? 
  - task - what was your role? what was the goal? what were the consequences if nothing happened? 
  - action - what did you personally own? how did you do it? who else was involved? <u>what obstacles</u> did you meet? 
  - result - what results did you achieve? what did you learn? how did you measure success of the project?

  

- **Coding**

  1. Most probably the interviewer explains the task verbally. So, clarify all moments you are unsure about, e.g. lower and upper bounds, types of elements (null?), whether the object has some specific attributes (array $\Rightarrow$​ is it sorted?). 

     Give some examples where the task is solved. Also, think about time and memory complexity. 

  2. When the interviewer is okay with your clarifications, start writing the code. Pay attention to formatting, names of variables. 

     You can also write some tests where, on each step of the implementation, it is explained what happens with the object. 

  <img src="./pics for conspects/SD/SD 24-02-08 3.png" alt="SD 24-02-08 3" style="zoom:80%;" />

  

- **System Deep Dive**

  Prepare a story about the project that you did or took part in. Explain what problem you had, then what architecture and what technologies you used to solve it.  

  

- **System Design**

  During the system design interview, you are given a task to design a system (it can be used for payments, reservations, etc). First of all, you clarify requirements, boundaries, discuss possible solutions. If it is okay for the interviewer, you can use [diagrams](https://excalidraw.com/) for that. 

  For example, you are asked to create a URL shortener: a user submits a long URL, and a service returns a short one. 

  *Numbers used below are mostly your assumptions.* 

  

  1. Functional requirements:

     It is a web service. No login, no registration - the service is open to everyone.

     The length of a short URL is 6 symbols. 26 lowercase letters + 10 digits can be used. 

     Use case #1. User sends a long URL, the service returns a short one. 

     Use case #2. User sends a short URL, the service returns the original one. 

     

  2. Non-functional requirements:

     Daily users? 10k per day.

     How many URLs can we store? 4 billions.

     4B / 10k = 400k; 365 < 400 $\Rightarrow$ We can store URLs for ~ 1000 years. Quite a lot. 

     Storage per row = (short URL, long URL, id) = (6 bytes, 5k bytes, 8 bytes) = 5 kilobytes per row

     All storage: 5 kilobytes * 4B $\approx$​ 16 TB

     

  3. API - HTTPS/REST is used.

     - Get short URL

       Request: `POST` 

       Body: `json { "url": "<long_url>" }`

       Response: `200 OK`

       Body: `json { "url": "<short_url" }`

       If there was a error, the response is `400 Bad Request`

     - Get original URL

       Request: `GET <short_url>`

       Response: `301 Redirect`

       Header: Original url

       In case of error, the response is `400 Bad Request`

       If the entry is not found, response with `404 Not Found`

     

  4. Draw diagrams describing how the API<img src="./pics for conspects/SD/SD 24-02-08 4.png" alt="SD 24-02-08 4" style="zoom:70%;" /> works. 







