FROM teenak/centos7-java8
MAINTAINER Taishun Nakatani <teenak77@gmail.com>

#copy cloudera CDH repo
COPY cloudera-cdh-5.7.repo /etc/yum.repos.d

RUN yum clean all \
 && yum install -y \
        sudo \
        hadoop-hdfs-namenode \
        hadoop-yarn-resourcemanager \
        hadoop-hdfs \
        hadoop-yarn \
 && rm -rf /var/cache/yum/

RUN mkdir -p /hadoop/tmp
RUN mkdir -p /hadoop/hdfs/cache/dfs/name
RUN mkdir -p /hadoop/yarn
RUN chown hdfs:hadoop /hadoop
RUN chown hdfs:hadoop /hadoop/tmp
RUN chown hdfs:hadoop /hadoop/hdfs
RUN chown hdfs:hadoop /hadoop/hdfs/cache
RUN chown hdfs:hadoop /hadoop/hdfs/cache/dfs
RUN chown hdfs:hadoop /hadoop/hdfs/cache/dfs/name
RUN chown yarn:hadoop /hadoop/yarn


ADD conf/core-site.xml /etc/hadoop/conf/core-site.xml
ADD conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
ADD conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml

# update boot script
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh


EXPOSE 8020 50070

#define HDFS volume to enable to persist namenode fsimage between restart
VOLUME /hadoop

ENTRYPOINT ["/etc/bootstrap.sh"]

