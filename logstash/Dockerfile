FROM logstash:5

COPY jvm.options /etc/logstash/jvm.options

#COPY logstash.conf /

CMD ["-f","/logstash.conf","--config.reload.automatic"]

# COPY logstash.conf /some/config-dir/

