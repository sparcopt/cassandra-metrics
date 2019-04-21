FROM cassandra:3.11

ENV JMX_EXPORTER_VERSION 0.11.0

RUN apt-get update
RUN apt-get install -y wget
RUN wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar -P /prometheus
RUN wget https://gist.githubusercontent.com/sparcopt/173a1664f4d2bee49faf1a00aa81b926/raw/393d9829096523dfbf90ce75a096705bec497c1c/cassandra.yml -P /prometheus
RUN echo 'JVM_OPTS="$JVM_OPTS -javaagent:'/prometheus/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar=7070:/prometheus/cassandra.yml'"' | tee -a /etc/cassandra/cassandra-env.sh
