Vagrant.configure("2") do |config|
	config.vm.box = "bento/centos-7.5"
	config.vm.provider "virtualbox" do |vb|
		vb.gui = false
		vb.memory = 256
		vb.cpus = 2
	end

  config.vm.define "frontserver1" do |server1|
  	server1.vm.hostname = "server1"
  	server1.vm.network "private_network", ip: "192.168.0.10"
    server1.vm.network "forwarded_port", guest: 80, host: 8400
  	server1.vm.provision "shell", inline: <<-SHELL
      yum install httpd -y -q
      systemctl enable httpd
      systemctl start httpd
  	SHELL
  end

  config.vm.define "inserver1" do |server2|
  	server2.vm.hostname = "server2"
  	server2.vm.network "private_network", ip: "192.168.0.11"
    server2.vm.network "forwarded_port", guest: 8080, host: 8401
  	server2.vm.provision "shell", inline: <<-SHELL
      yum install tomcat -y -q
      systemctl enable tomcat
      systemctl start tomcat
  	SHELL
  end

  config.vm.define "inserver2" do |server3|
  	server3.vm.hostname = "server2"
  	server3.vm.network "private_network", ip: "192.168.0.12"
    server3.vm.network "forwarded_port", guest: 8080, host: 8402
  	server3.vm.provision "shell", inline: <<-SHELL
      yum install tomcat -y -q
      systemctl enable tomcat
      systemctl start tomcat
  	SHELL
  end

config.vm.provision "shell", inline: <<-SHELL
	grep -q '192.168.0.[10-12]' '/etc/hosts' && echo "++++ hosts file is good" || echo "192.168.0.10 frontserver1\n192.168.0.11 inserver1\n192.168.0.11 inserver2\n" >> /etc/hosts;
SHELL

end
