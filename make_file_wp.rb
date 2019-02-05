$TOMCAT_COUNT = 5

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

  f.write("worker.myworker.balance_workers=")
  for i in 1..$TOMCAT_COUNT
    f.write("myworker#{i},")
  end
  f.write("\n")

  f.close
end
