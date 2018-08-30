# Broken Maven Java 10 Lombok Jigsaw Sample

This is to expose a compile error I am getting when using the lombok plugin on

```
openjdk version "10.0.2" 2018-07-17
OpenJDK Runtime Environment (build 10.0.2+13-Ubuntu-1ubuntu0.18.04.1)
OpenJDK 64-Bit Server VM (build 10.0.2+13-Ubuntu-1ubuntu0.18.04.1, mixed mode)
```

### Reproduce the issue

* clone this repository and cd into it
* run `sudo expose-issue.sh` and see the output (this will run it reproducible in a docker container). Alternative just run `./mvnw clean install` - it will probably result in the same


### Details
When running `./mvnw clean install` on this problem, the output looks like this:

```
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Build Order:
[INFO]
[INFO] maven-lombok-jigsaw-sample                                         [pom]
[INFO] module-a                                                           [jar]
[INFO] module-b                                                           [jar]
[INFO]
[INFO] ---------------< de.newcron:maven-lombok-jigsaw-sample >----------------
[INFO] Building maven-lombok-jigsaw-sample 1.0-SNAPSHOT                   [1/3]
[INFO] --------------------------------[ pom ]---------------------------------
[INFO]
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ maven-lombok-jigsaw-sample ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ maven-lombok-jigsaw-sample ---
[INFO] Installing /home/matthias/dev/mavenlombokjigsawsample/pom.xml to /home/matthias/.m2/repository/de/newcron/maven-lombok-jigsaw-sample/1.0-SNAPSHOT/maven-lombok-jigsaw-sample-1.0-SNAPSHOT.pom
[INFO]
[INFO] ------------------------< de.newcron:module-a >-------------------------
[INFO] Building module-a 1.0-SNAPSHOT                                     [2/3]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ module-a ---
[INFO] Deleting /home/matthias/dev/mavenlombokjigsawsample/module-a/target
[INFO]
[INFO] --- lombok-maven-plugin:1.18.0.0:delombok (default) @ module-a ---
[WARNING] Unable to detect tools.jar; java.home is /usr/lib/jvm/java-11-openjdk-amd64
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by lombok.javac.JavacTreeMaker$TypeTag to method com.sun.tools.javac.code.Type.getTag()
WARNING: Please consider reporting this to the maintainers of lombok.javac.JavacTreeMaker$TypeTag
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
/home/matthias/dev/mavenlombokjigsawsample/module-a/src/main/java/module-info.java:2: error: module not found: lombok
    requires static lombok;
                    ^
/home/matthias/dev/mavenlombokjigsawsample/module-a/src/main/java/de/newcron/mavenlombokjigsawsample/modulea/Person.java:3: error: package lombok does not exist
import lombok.AllArgsConstructor;
             ^
/home/matthias/dev/mavenlombokjigsawsample/module-a/src/main/java/de/newcron/mavenlombokjigsawsample/modulea/Person.java:5: error: cannot find symbol
@AllArgsConstructor
 ^
  symbol: class AllArgsConstructor
[INFO] Delombok complete.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ module-a ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.8.0:compile (default-compile) @ module-a ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 2 source files to /home/matthias/dev/mavenlombokjigsawsample/module-a/target/classes
[INFO] -------------------------------------------------------------
[ERROR] COMPILATION ERROR :
[INFO] -------------------------------------------------------------
[ERROR] /home/matthias/dev/mavenlombokjigsawsample/module-a/src/main/java/de/newcron/mavenlombokjigsawsample/modulea/Person.java:[7,26] variable firstname not initialized in the default constructor
[ERROR] /home/matthias/dev/mavenlombokjigsawsample/module-a/src/main/java/de/newcron/mavenlombokjigsawsample/modulea/Person.java:[7,37] variable lastname not initialized in the default constructor
[INFO] 2 errors
[INFO] -------------------------------------------------------------
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO]
[INFO] maven-lombok-jigsaw-sample 1.0-SNAPSHOT ............ SUCCESS [  0.363 s]
[INFO] module-a ........................................... FAILURE [  1.408 s]
[INFO] module-b 1.0-SNAPSHOT .............................. SKIPPED
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1.902 s
[INFO] Finished at: 2018-08-30T19:33:01+02:00
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.8.0:compile (default-compile) on project module-a: Compilation failure: Compilation failure:
[ERROR] /home/matthias/dev/mavenlombokjigsawsample/module-a/src/main/java/de/newcron/mavenlombokjigsawsample/modulea/Person.java:[7,26] variable firstname not initialized in the default constructor
[ERROR] /home/matthias/dev/mavenlombokjigsawsample/module-a/src/main/java/de/newcron/mavenlombokjigsawsample/modulea/Person.java:[7,37] variable lastname not initialized in the default constructor
[ERROR] -> [Help 1]
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException
[ERROR]
[ERROR] After correcting the problems, you can resume the build with the command
[ERROR]   mvn <goals> -rf :module-a
```