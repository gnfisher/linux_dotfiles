if [[ `uname` == "Darwin" ]]; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 11.0)"
  # export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
fi

