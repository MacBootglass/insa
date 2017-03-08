if [ $# -eq 1 ]
then
  javac -classpath ./classes -sourcepath ./src -d ./classes ./src/$1/*/*.java
fi
