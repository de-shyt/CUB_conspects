# Kotlin Ecosystems

*Author: Daria Shutina*



[TOC]



## 23-02-01

### Org stuff 

#### Homeworks

If homework is given at date DATE, the sorft deadline is DATE + 2 weeks and the hard deadline is at DATE + 3 weeks. 

Some homewrks will be connected to each other, so it is bad to skip one of them. 

Homeworks will appear after lectures. `git push` to a seperate branch, then open a PR. 



#### Grade

To pass the course you have to score ≥ 45 points. 

To get A+ you have to score ≥ 95 points. 

There are 130 points you can score in this course: 74 for home assignments, 44 for quizzes, 12 for the test.









## 23-02-08

### Gradle

#### Settings

If there are several modules in a project, each module should have its own settings. The settings are saved in a directory `build.gradle.hts`. 

Data in `settings.gradle.kts` will be executed before other settings. 

To add a module, use `Project -> New -> Module`. 





#### Tasks

There are default  and custom tasks, tasks from plugins. Custom tasks can be defined in the build configuration. 

```kotlin
task.register("name") {
    group = "useless"
    dependsOn(tasks.named("othername"))
    println("${this.name}, configuration")
    doFirst {
        println("${this.name}, first in execution")
    }
}

task.register("othername") {
    println("${this.name}, configuration")
    doFirst {
        println("${this.name}, first in execution")
    }
    doLast {
        println("${this.name}, last in execution")
    }
}
```

 `dependsOn` means that tasks with the name `othername` will be executed before the `name` tasks. 

You can also play with tasks:

```kotlin
tasks
    .filter { task ->
        task.group?. let { it == "useless" } ?: false 
    }
    .forEach {
        it.dependsOn(task3)
    }
```





#### Throwback

`./gradlew build` will use all components. Use a flag `-x test` to exclude tests, for example. 





#### Plugins

Most useful features are added by plugins. 

There are binary plugins and script plugins. If you set up a plugin correctly, you will see additional tasks. 

Applying a community plugin:

```kotlin
plugins {
    kotlin("jvm") version "1.8.0"
    id("io.gitlab.arturbosch.detekt") version "1.21.0" apply false
}
```

`apply false` means the plugin will not be added in the beginning of the project build. By default, the value is `true`. 

























