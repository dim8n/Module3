$TOMCAT_COUNT = 25
$subnetwork_net = "192.168.0."

File.open("workers.properties", "w") do |f|
  f.write("worker.list=myworker\n")
  f.write("\n")
  for i in 1..$TOMCAT_COUNT
    f.write("worker.myworker#{i}.port=8009\n")
    f.write("worker.myworker#{i}.host=inserver#{i}\n")
    f.write("worker.myworker#{i}.type=ajp13\n")
    f.write("\n")
  end
  f.write("worker.myworker.type=lb\n")
  f.write("\n")
  f.write("worker.myworker.balance_workers=myworker1")
  for i in 2..$TOMCAT_COUNT
    f.write(",myworker#{i}")
  end
  f.write("\n")
  f.close
end

File.open("hosts", "w") do |f|
  f.write("127.0.0.1 localhost\n")
  f.write("#{$subnetwork_net}10 frontserver1\n")
  for i in 1..$TOMCAT_COUNT
    f.write("#{$subnetwork_net}#{10+i} inserver#{i}\n")
  end
  f.write("\n")
  f.close
end
