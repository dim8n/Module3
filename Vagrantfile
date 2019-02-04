$TOMCAT_COUNT = 3

Vagrant.configure("2") do |config|
	config.vm.box = "bento/centos-7.5"
	config.vm.box_check_update=false
	config.vm.provider "virtualbox" do |vb|
		vb.gui = false
		vb.memory = 256
		vb.cpus = 2
		vb.check_guest_additions=false
	end

  config.vm.define "frontserver1" do |server1|
  	server1.vm.hostname = "frontserver1"
  	server1.vm.network "private_network", ip: "192.168.0.10"
    server1.vm.network "forwarded_port", guest: 80, host: 8400
  	server1.vm.provision "shell", inline: <<-SHELL
      yum install httpd -y -q
      systemctl enable httpd
      systemctl start httpd
  	SHELL
  end

	(1..$TOMCAT_COUNT).each do |i|
	    config.vm.define "inserver#{i}" do |node|
					node.vm.hostname = "inserver#{i}"
	        node.vm.network "public_network", ip: "192.168.0.#{10+i}"
					nede.vm.network "forwarded_port", guest: 8080, host: 8400+i
					node.vm.provision "shell", inline: <<-SHELL
						yum install tomcat tomcat-webapps tomcat-admin-webapps -y -q
						systemctl enable tomcat
						systemctl start tomcat
					SHELL
	    end
	end

config.vm.provision "shell", inline: <<-SHELL
	grep -q '192.168.0.[10-12]' '/etc/hosts' && echo "++++ hosts file is good" || echo "192.168.0.10 frontserver1\n192.168.0.11 inserver1\n192.168.0.11 inserver2\n" >> /etc/hosts;
SHELL

end
