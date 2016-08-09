FROM teenak/centos7-java8
MAINTAINER Taishun Nakatani <teenak77@gmail.com>

#copy cloudera CDH repo
COPY cloudera-cdh-5.7.repo /etc/yum.repos.d

RUN yum clean all && \
    yum install -y hadoop-hdfs hadoop-yarn

