# Token for sonarqube analysis
- First generate a sonarqube token to make a project analyzable

```text
SONARQUBE_TOKEN: sqp_e12d7f7d420495555679aaafa05e3c5f39800d3c
```

- Replace the places mentioned as SONARQUBE_TOKEN with the actual token in the following guide

# Utilizing the Sonar Scanner for gradle for performing analysis
1. Set up the build.gradle file

```build.gradle
plugins {
  id "org.sonarqube" version "4.2.1.3168"
}
```

2. Execute the following code in the cmd

```cmd
./gradlew sonar
  -Dsonar.projectKey=sonarqube-kotlin-project
  -Dsonar.host.url=http://localhost:9000
  -Dsonar.token=SONARQUBE_TOKEN
```

3. Alternatively you can set those in as a gradle task

```build.gradle
sonar {
    properties {
        property("sonar.projectKey", "sonarqube-kotlin-project")
        property("sonar.host.url", "http://localhost:9000")
    }
}
```

- then run the following command

```cmd
gradlew sonar -Dsonar.token=SONARQUBE_TOKEN
```

- OR

```cmd
set SONAR_TOKEN=SONARQUBE_TOKEN
gradlew sonar
```

## Notes regarding the gradle application plugin
1. this plugin automatically sets up the sonar properties required to
   do a proper analysis of code and send the results to the sonarQube server

2. without this plugin no scanning will work on its own

3. once executed, sonar scanner temporarily creates an analysis log that contains details
   of the scanners that are already coming ready with it, these analysers are the ones
   responsible for generating the reports that are then sent to sonarQube

# Utilizing the Sonar Scanner for performing analysis
1. Download the Sonar Scanner

2. Create a sonar-project.properties file in the root directory so that the scan will be triggered for the entire
   project

```properties
sonar.projectKey=sonarqube-kotlin-project
sonar.sources=.
sonar.host.url=http://localhost:9000
sonar.login=SONARQUBE_TOKEN
```

# Procedure for invoking scans for various language source files
## For Java/Kotlin/Scala source files:
1. Set up the Java/Kotlin/Scala plugins
```groovy
plugins {
  // For Java 
  id "application"
  // For Kotlin 
  id "org.jetbrains.kotlin.jvm" version "1.9.10"
  // For Scala 
  id 'scala'
}
```

2. Set up the Java/Kotlin/Scala dependencies
```groovy
dependencies {
    // For Running Kotlin files
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk8"

    // For Running Scala files
    implementation 'org.scala-lang:scala3-library_3:3.0.1'
}
```

3. Set up the sourceSets property (Specific to Scala)
```groovy
sourceSets {
    main {
        scala {
            srcDirs = ['src/main/scala']
        }
        java {
            srcDirs = ['src/main/java']
        }
    }
}
```

4. Set up Sonar Scanner for Gradle

5. Execute the gradle sonar command
```cmd
gradlew sonar
```

6. No further actions are required, and analysis results will be visible in SonarQube

## For Golang source files:
1. We cannot use the sonar scanner for gradle

2. We can only use the sonar-scanner approach for performing scans for Go Projects

3. This is because the gradle sonar scanner is unable to include go projects even when defined in the settings.gradle
   file

4. The go projects should be initiated within the root directory and not in a nested manner as the scanner is able to
   scan for go projects in the root level

5. Provide the following in the sonar-project.properties file:
```properties
sonar.tests=.
# Remove go tests files from being in sonar scans directly
sonar.exclusions=**/*_test.go

# Explicitly add go test files to be included in the sonar.test instead
sonar.test.inclusions=**/*_test.go

# Providing absolutely path for generated coverage report required before scans
sonar.go.coverage.reportPaths="C:\\Users\\Tharana Wanigaratne\\Desktop\\BalWorkFile\\SonarQube-scans-testing\\test-go-project\\coverage.out"

# Providing absolutely path for generated test report required before scans
sonar.go.tests.reportPaths="C:\\Users\\Tharana Wanigaratne\\Desktop\\BalWorkFile\\SonarQube-scans-testing\\test-go-project\\test-report.json"
```
6. Run the sonar scanner

7. No further actions are required, and analysis results will be visible in SonarQube

## For Ruby source files:
- To be tested

## For JS/Python source files:
1. Perform the sonar scan through any of the scanners provided (i.e: sonar scanner for gradle)

2. The analysis will be taken care of automatically without any further steps

# Debugging a SonarQube Project
## Initiating the debug from the scanner side:
### From sonar scanner (Recommended for non compiled languages) 
1. set the following sonar env variable with the debug option:
```cmd
set SONAR_SCANNER_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=8000"
```
   
2. Run the sonar-scanner
```cmd
sonar-scanner
```

### From sonar scanner for gradle (Suitable for sonar scanner for gradle projects)
1. Execute the following command
```cmd
gradlew sonar -Dorg.gradle.debug=true --no-daemon -Dorg.gradle.debug.port=8000
```

### Setting up debug points in the plugins:   
1. Create a breakpoint in the required java project class file with a java remote debug configuration set up

2. Click the debug icon, to start debugging

## Initiating the debug from the web server side:
- Steps to be added

## Initiating the debug from the compute engine side:
- Steps to be added