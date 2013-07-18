project 'JRuby Core' do

  model_version '4.0.0'
  id 'org.jruby:jruby-core:1.7.5.dev'
  inherit 'org.jruby:jruby-parent:1.7.5.dev'
  packaging 'jar'

  repository( 'file:${jruby.basedir}/localrepo',
              :id => 'localrepo' )
  repository( 'https://oss.sonatype.org/content/repositories/snapshots/',
              :id => 'sonatype' ) do
    releases 'false'
    snapshots 'true'
  end

  source_code( 'http://github.com/jruby/jruby',
               :connection => 'scm:git:git://github.com/jruby/jruby.git',
               :developer_connection => 'scm:git:ssh://git@github.com/jruby/jruby.git' )

  properties( 'tzdata.jar.version' => '2013c',
              'maven.build.timestamp.format' => 'yyyy-MM-dd',
              'jruby.basedir' => '${basedir}/..',
              'main.basedir' => '${project.parent.basedir}',
              'maven.test.skip' => 'true',
              'tzdata.scope' => 'provided',
              'unsafe.jar' => '${project.build.directory}/unsafe.jar',
              'build.date' => '${maven.build.timestamp}',
              'jruby.test.memory.permgen' => '512M',
              'tzdata.version' => '2012j',
              'jruby.test.memory' => '1024M',
              'Constants.java' => 'org/jruby/runtime/Constants.java',
              'anno.sources' => '${project.basedir}/target/generated-sources' )

  jar 'junit:junit'
  jar 'org.jruby.joni:joni:2.0.0'
  jar 'com.github.jnr:jnr-netdb:1.1.2'
  jar 'com.github.jnr:jnr-enxio:0.4'
  jar 'com.github.jnr:jnr-unixsocket:0.3'
  jar 'com.github.jnr:jnr-posix:3.0.1-SNAPSHOT'
  jar 'org.jruby.extras:bytelist:1.0.10'
  jar 'com.github.jnr:jnr-constants:0.8.4'
  jar 'org.jruby.jcodings:jcodings:1.0.10'
  jar 'com.github.jnr:jffi:1.2.7'
  jar 'com.github.jnr:jnr-ffi:1.0.4'
  jar 'org.yaml:snakeyaml:1.12'
  jar 'com.jcraft:jzlib:1.1.2'
  jar 'com.headius:invokebinder:1.2'
  jar( 'org.osgi:org.osgi.core:5.0.0',
       :scope => 'provided' )
  jar( 'org.apache.ant:ant:1.9.1',
       :scope => 'provided' )
  jar 'org.jruby:jay-yydebug:1.0'
  jar( 'bsf:bsf:2.4.0',
       :scope => 'provided' )
  jar 'com.martiansoftware:nailgun-server:0.9.1'
  jar( 'com.headius:coro-mock:1.0',
       :scope => 'provided' )
  jar( 'com.headius:unsafe-mock:8.0',
       :scope => 'provided' )
  jar( 'jsr292:jsr292-mock:1.0-SNAPSHOT',
       :scope => 'provided' )
  jar 'org.jruby:yecht:1.0'
  jar( 'commons-logging:commons-logging:1.1.3',
       :scope => 'test' )
  jar( 'org.livetribe:livetribe-jsr223:2.0.7',
       :scope => 'test' )
  jar( 'requireTest:requireTest:1.0',
       :scope => 'test' )
  jar( 'org.jruby:joda-timezones:${tzdata.jar.version}',
       :scope => '${tzdata.scope}' )
  jar 'joda-time:joda-time:2.2'

  overrides do
    plugin( 'org.eclipse.m2e:lifecycle-mapping:1.0.0',
            'lifecycleMappingMetadata' => {
              'pluginExecutions' => [ { 'pluginExecutionFilter' => {
                                          'groupId' =>  'org.codehaus.mojo',
                                          'artifactId' =>  'properties-maven-plugin',
                                          'versionRange' =>  '[1.0-alpha-2,)',
                                          'goals' => [ 'read-project-properties' ]
                                        },
                                        'action' => {
                                          'ignore' =>  ''
                                        } },
                                      { 'pluginExecutionFilter' => {
                                          'groupId' =>  'org.codehaus.mojo',
                                          'artifactId' =>  'build-helper-maven-plugin',
                                          'versionRange' =>  '[1.8,)',
                                          'goals' => [ 'add-source' ]
                                        },
                                        'action' => {
                                          'ignore' =>  ''
                                        } },
                                      { 'pluginExecutionFilter' => {
                                          'groupId' =>  'org.codehaus.mojo',
                                          'artifactId' =>  'exec-maven-plugin',
                                          'versionRange' =>  '[1.2.1,)',
                                          'goals' => [ 'exec' ]
                                        },
                                        'action' => {
                                          'ignore' =>  ''
                                        } },
                                      { 'pluginExecutionFilter' => {
                                          'groupId' =>  'org.apache.maven.plugins',
                                          'artifactId' =>  'maven-dependency-plugin',
                                          'versionRange' =>  '[2.8,)',
                                          'goals' => [ 'copy' ]
                                        },
                                        'action' => {
                                          'ignore' =>  ''
                                        } },
                                      { 'pluginExecutionFilter' => {
                                          'groupId' =>  'org.apache.maven.plugins',
                                          'artifactId' =>  'maven-clean-plugin',
                                          'versionRange' =>  '[2.5,)',
                                          'goals' => [ 'clean' ]
                                        },
                                        'action' => {
                                          'ignore' =>  ''
                                        } } ]
            } )
  end

  plugin 'org.codehaus.mojo:properties-maven-plugin:1.0-alpha-2' do
    execute_goals( 'read-project-properties',
                   :id => 'properties',
                   :phase => 'initialize',
                   'files' => [ '${jruby.basedir}/default.build.properties',
                                '${jruby.basedir}/build.properties' ],
                   'quiet' =>  'true' )
  end

  plugin 'org.codehaus.mojo:buildnumber-maven-plugin:1.2' do
    execute_goals( 'create',
                   :id => 'jruby-revision',
                   :phase => 'generate-sources',
                   'shortRevisionLength' =>  '7',
                   'buildNumberPropertyName' =>  'jruby.revision' )
  end

  plugin 'org.codehaus.mojo:build-helper-maven-plugin:1.8' do
    execute_goals( 'add-source',
                   :id => 'add-populators',
                   :phase => 'process-classes',
                   'sources' => [ '${anno.sources}' ] )
  end

  plugin 'org.codehaus.mojo:exec-maven-plugin:1.2.1' do
    execute_goals( 'exec',
                   :id => 'invoker-generator',
                   :phase => 'process-classes',
                   'arguments' => [ '-Djruby.bytecode.version=${base.java.version}',
                                    '-classpath',
                                    xml( '<classpath/>' ),
                                    'org.jruby.anno.InvokerGenerator',
                                    '${anno.sources}/annotated_classes.txt',
                                    '${project.build.outputDirectory}' ],
                   'executable' =>  'java',
                   'classpathScope' =>  'compile' )
  end

  plugin( :compiler,
          'encoding' =>  'utf-8',
          'debug' =>  'true',
          'verbose' =>  'true',
          'fork' =>  'true',
          'showWarnings' =>  'true',
          'showDeprecation' =>  'true',
          'source' =>  '${base.java.version}',
          'target' =>  '${base.java.version}',
          'useIncrementalCompilation' =>  'false' ) do
    execute_goals( 'compile',
                   :id => 'anno',
                   :phase => 'process-resources',
                   'includes' => [ 'org/jruby/anno/FrameField.java',
                                   'org/jruby/anno/AnnotationBinder.java',
                                   'org/jruby/anno/JRubyMethod.java',
                                   'org/jruby/anno/FrameField.java',
                                   'org/jruby/CompatVersion.java',
                                   'org/jruby/runtime/Visibility.java',
                                   'org/jruby/util/CodegenUtils.java',
                                   'org/jruby/util/SafePropertyAccessor.java' ] )
    execute_goals( 'compile',
                   :id => 'compile-constants',
                   :phase => 'process-resources',
                   'compilerArgs' => [ '-XDignore.symbol.file=true',
                                       '-J-Duser.language=en',
                                       '-J-Dfile.encoding=UTF-8' ],
                   'includes' => [ '${Constants.java}' ] )
    execute_goals( 'compile',
                   :id => 'default-compile',
                   :phase => 'compile',
                   'annotationProcessors' => [ 'org.jruby.anno.AnnotationBinder' ],
                   'compilerArgs' => [ '-XDignore.symbol.file=true',
                                       '-J-Duser.language=en',
                                       '-J-Dfile.encoding=UTF-8',
                                       '-J-Xbootclasspath/p:${unsafe.jar}',
                                       '-J-Xmx${jruby.compile.memory}' ],
                   'excludes' => [ '${Constants.java}' ] )
    execute_goals( 'compile',
                   :id => 'populators',
                   :phase => 'process-classes',
                   'compilerArgs' => [ '-XDignore.symbol.file=true',
                                       '-J-Duser.language=en',
                                       '-J-Dfile.encoding=UTF-8',
                                       '-J-Xbootclasspath/p:${unsafe.jar}',
                                       '-J-Xmx${jruby.compile.memory}' ],
                   'includes' => [ 'org/jruby/gen/**/*.java' ] )
    execute_goals( 'compile',
                   :id => 'eclipse-hack',
                   :phase => 'process-classes',
                   'skipMain' =>  'true',
                   'includes' => [ '**/*.java' ] )
  end

  plugin :dependency do
    jar 'biz.aQute:bnd:0.0.384'

    execute_goals( 'copy',
                   :id => 'copy jars',
                   :phase => 'process-resources',
                   'artifactItems' => [ { 'groupId' =>  'biz.aQute',
                                          'artifactId' =>  'bnd',
                                          'version' =>  '0.0.384',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  '${project.build.directory}',
                                          'destFileName' =>  'bnd.jar' },
                                        { 'groupId' =>  'com.headius',
                                          'artifactId' =>  'unsafe-mock',
                                          'version' =>  '8.0',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  '${project.build.directory}',
                                          'destFileName' =>  'unsafe.jar' } ] )
  end

  plugin :clean do
    execute_goals( 'clean',
                   :id => 'default-clean',
                   :phase => 'clean',
                   'filesets' => [ { 'directory' =>  '${project.build.sourceDirectory}',
                                     'includes' => [ '${Constants.java}' ] } ],
                   'failOnError' =>  'false' )
    execute_goals( 'clean',
                   :id => 'clean-anno-files',
                   :phase => 'process-classes',
                   'excludeDefaultDirectories' =>  'true',
                   'filesets' => [ { 'directory' =>  '${anno.sources}',
                                     'includes' => [ 'annotated_classes.txt' ] } ],
                   'failOnError' =>  'false' )
  end

  plugin :jar do
    execute_goals( 'jar',
                   :id => 'default-jar',
                   :phase => 'package' )
  end

  plugin :shade do
    execute_goals( 'shade',
                   :id => 'pack jruby.jar',
                   :phase => 'package',
                   'relocations' => [ { 'pattern' =>  'org.objectweb',
                                        'shadedPattern' =>  'org.jruby.org.objectweb' } ],
                   'outputFile' =>  '${jruby.basedir}/lib/jruby.jar',
                   'transformers' => [ { '@implementation' =>  'org.apache.maven.plugins.shade.resource.ManifestResourceTransformer',
                                         'mainClass' =>  'org.jruby.Main' } ] )
  end

  plugin :antrun do
    execute_goals( 'run',
                   :id => 'copy',
                   :phase => 'package',
                   'tasks' => {
                     'exec' => {
                       '@executable' =>  '/bin/sh',
                       '@osfamily' =>  'unix',
                       'arg' => {
                         '@line' =>  '-c \'test -f "${jruby.basedir}/bin/jruby" || cp "${jruby.basedir}/bin/jruby.bash" "${jruby.basedir}/bin/jruby"\''
                       }
                     },
                     'chmod' => {
                       '@file' =>  '${jruby.basedir}/bin/jruby',
                       '@perm' =>  '755'
                     }
                   } )
  end

  plugin( :surefire,
          'forkCount' =>  '1C',
          'reuseForks' =>  'false',
          'systemProperties' => {
            'jruby.compat.version' =>  '1.9',
            'jruby.home' =>  '${basedir}/..'
          },
          'testFailureIgnore' =>  'true',
          'argLine' => [ '-Xmx${jruby.test.memory}',
                         '-XX:MaxPermSize=${jruby.test.memory.permgen}',
                         '-Dfile.encoding=UTF-8',
                         '-Djruby.compile.mode=OFF' ],
          'includes' => [ 'org/jruby/test/MainTestSuite.java',
                          'org/jruby/embed/**/*Test*.java' ] )

  build do
    default_goal 'package'

    resource do
      directory 'src/main/ruby'
      includes '**/*rb'
      excludes 
    end

    resource do
      directory 'src/main/resources'
      includes 'META-INF/**/*'
      excludes 
    end

    resource do
      directory '${project.basedir}/src/main/resources'
      includes '${Constants.java}'
      excludes 
      target_path '${project.build.sourceDirectory}'
      filtering 'true'
    end
  end

  profile 'native' do

    activation do
      file( :missing => '../lib/jni' )
    end

    plugin :dependency do
      execute_goals( 'unpack',
                     :id => 'unzip native',
                     :phase => 'process-classes',
                     'excludes' =>  'META-INF,META-INF/*',
                     'artifactItems' => [ { 'groupId' =>  'com.github.jnr',
                                            'artifactId' =>  'jffi',
                                            'version' =>  '1.2.5',
                                            'type' =>  'jar',
                                            'classifier' =>  'native',
                                            'overWrite' =>  'false',
                                            'outputDirectory' =>  '${jruby.basedir}/lib' } ] )
    end

  end

  profile 'test' do

    properties( 'maven.test.skip' => 'false' )

  end

  profile 'default' do

  end

  profile 'tzdata' do

    activation do
      property( :name => 'tzdata.version' )
    end

    properties( 'tzdata.jar.version' => '${tzdata.version}',
                'tzdata.scope' => 'runtime' )

  end

end
