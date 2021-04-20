cask 'graalvm-ce-java16' do
  version '21.1.0'
  sha256 'dafece9d03251304a6d9fc242862cfc08b85e2b8921d3b019a8a19b95af78e2c'

  JVMS_DIR = '/Library/Java/JavaVirtualMachines'.freeze
  MODIFIER = 'java16'.freeze
  TARGET_DIR = "#{JVMS_DIR}/graalvm-ce-#{MODIFIER}-#{version}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-#{version.downcase}/graalvm-ce-#{MODIFIER}-darwin-amd64-#{version.downcase}.tar.gz"
  appcast 'https://github.com/graalvm/graalvm-ce-builds/releases.atom'
  name 'GraalVM Community Edition'
  homepage 'https://www.graalvm.org/'

  artifact "graalvm-ce-#{MODIFIER}-#{version}", target: TARGET_DIR

  caveats <<~EOS
    Installing GraalVM CE in #{JVMS_DIR} requires root permissions.
    You may be asked to enter your password to proceed.

    To use GraalVM CE, you may want to change your `JAVA_HOME`:
      export JAVA_HOME=#{TARGET_DIR}/Contents/Home

    or you may want to add its `bin` directory to your `PATH`:
      export PATH=#{TARGET_DIR}/Contents/Home/bin:"$PATH"

    If you are using macOS Catalina and later you may need to remove
    the quarantine attribute from the bits before you can use them
    To do this, run the following:
      sudo xattr -r -d com.apple.quarantine #{TARGET_DIR}

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
