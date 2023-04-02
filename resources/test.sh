#!/bin/bash
# test the hadoop cluster by running wordcount
# create input files
mkdir input
echo "Hello World" >input/file1.txt
echo "Hello Hadoop" >input/file2.txt
# create input directory on HDFS
hadoop fs -mkdir -p input1
# put input files to HDFS
hdfs dfs -put ./input/* input1
# run wordcount
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-3.3.4-sources.jar org.apache.hadoop.examples.WordCount input1 output1
# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat input1/file1.txt
echo -e "\ninput file2.txt:"
hdfs dfs -cat input1/file2.txt
# print the output of wordcount
echo -e "\nwordcount output:"
hdfs dfs -cat output1/part-r-00000 