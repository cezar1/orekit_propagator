#~/bin/bash
APP="Example1"
echo $APP
SESSION=$APP
OREKIT_LIB="../../orekit-main/target/orekit-7.2.jar"
MATH_LIB="$HOME/.m2/repository/org/apache/commons/commons-math3/3.6.1/commons-math3-3.6.1.jar"
tmux has-session -t $SESSION 2>/dev/null

if [ "$?" -eq 1 ] ; then

tmux -2 new-session -d -s $SESSION

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n 'JAVA'
tmux send-keys "cd src" C-m
tmux send-keys "ls -lah" C-m
tmux send-keys "javac -cp \"$OREKIT_LIB:$MATH_LIB\" fr/cs/examples/Autoconfiguration.java fr/cs/examples/propagation/SlaveMode.java" C-m
tmux send-keys "java -cp \"$OREKIT_LIB:$MATH_LIB:.\" fr.cs.examples.propagation.SlaveMode" C-m
fi
# Attach to session

tmux -u -2 attach-session -t $SESSION
