#!/bin/sh
export NAME="sample-daemon"
export DESC="SampleDaemon service"

# The path to Jsvc
export EXEC="/usr/local/bin/jsvc-java11/jsvc"

# The path to the folder containing MyDaemon.jar
export FILE_PATH="~/sample-daemon"

# The path to the folder containing the java runtime
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# Our classpath including our jar file and the Apache Commons Daemon library
export CLASS_PATH="$FILE_PATH/try-commons-daemon-1.0.0-jar-with-dependencies.jar"

# The fully qualified name of the class to execute
export CLASS="my.trials.SampleDaemon"

#The user to run the daemon as
export USER="root"

# The file that will contain our process identification number (pid) for other scripts/programs that need to access it.
export PID="$FILE_PATH/$NAME.pid"

# System.out writes to this file...
LOG_OUT="$FILE_PATH/log/$NAME.out"

# System.err writes to this file...
LOG_ERR="$FILE_PATH/err/$NAME.err"

jsvc_exec()
{
  cd $FILE_PATH
  $EXEC -home $JAVA_HOME -cp $CLASS_PATH -user $USER -outfile $LOG_OUT -errfile $LOG_ERR -pidfile $PID $1 $CLASS
}

case "$1" in
  start)
    echo "Starting the $DESC..."

    # Start the service
    jsvc_exec

    echo "The $DESC has started."
  ;;
  stop)
    echo "Stopping the $DESC..."

    # Stop the service
    jsvc_exec "-stop"

    echo "The $DESC has stopped."
  ;;
  restart)
    if [ -f "$PID" ]; then

      echo "Restarting the $DESC..."

      # Stop the service
      jsvc_exec "-stop"

      # Start the service
      jsvc_exec

      echo "The $DESC has restarted."
    else
      echo "Daemon not running, no action taken"
      exit 1
    fi
  ;;
  *)
    echo "Usage: $NAME {start|stop|restart}" >&2
    exit 3
  ;;
esac
