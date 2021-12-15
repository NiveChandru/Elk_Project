# Elk_Project
Elk Stack Deployment
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted in the below path

Path to Network Diagram: /Diagrams/Network_diagram.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml and config file may be used to install only certain pieces of it, such as Filebeat.

  Playbook File for Elk-VM installation : install-elk.yml
  Playbook File for Filebeat 		  : filebeat-playbook.yml
  Playbook File for Metricbeat          : metricbeat-playbook.yml
  Playbook File for Web servers 		  : pentest_web.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available , in addition to restricting traffic or access to the network.
- The load balancers protect the network from any DDos attacks (denial of service). It also helps to distribute the traffic over the network and not let one server take the whole load.
Jump Servers:
The Advantage of the Jump box is to act as a single access point between the our secure network and a non-secure network such as internet, so that we can audit and manage the traffic. This provides increased security.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the traffic and system resources using the system/application logs and other metrics in it.
- What does Filebeat watch for? Filebeat monitors the log files, collects log details, events or any changes to the files in the servers and sends the information to either Elasticsearch or Logstash for display.

- What does Metricbeat record? Metricbeat collects the metrics and statistics of the OS or the system applications and forwards it to Elasticsearch or Logstash.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name              | Function         | IP Address             | Operating System |
|-------------------|------------------|------------------------|------------------|
| Jump Box          | Gateway          | 10.0.0.6/52.170.250.38 | Linux            |
| Web-1             | Web Server(DVWA) | 10.0.0.8               | Linux            |
| Web-2             | Web Server(DVWA) | 10.0.0.7               | Linux            |
| Elk-VM            | Elk Server       | 10.1.0.4/52.161.65.211 | Linux            |
| Load Balancer     | Load Balancer    | 52.188.149.87          | Linux            |
| Local workstation | Laptop           | Public IP              | MacOS            |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Personal laptop Public IP address

Machines within the network can only be accessed by SSH.

- Which machine did you allow to access your ELK VM? What was its IP address? 

Jump-Box is the only machine allowed to access your Elk-VM.
The IP address of Jump-Box is 10.0.0.6/52.170.250.38

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses                                        |
|----------|---------------------|-------------------------------------------------------------|
| Jump Box | Yes                 | SSH from Personal laptop Public IP address                  |
| Web-1    | No                  | SSH through load balancer(52.188.149.87)                    |
| Web-2    | No                  | SSH through load balancer(52.188.149.87)                    |
| Elk-VM   | No                  | HTTP from Personal laptop Public IP address using port 5106 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- What is the main advantage of automating configuration with Ansible?
The main advantage of automating is to avoid any manual errors and also to easily deploy servers in less time without touching each server separately and also reuse the configuration if required later.

The playbook implements the following tasks:
- In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._

==> Installs docker.io, pip3 and docker python module
==> Increase memory using vm.max_map_count to value "262144"
==> download and launch a docker elk container with image "sebp/elk:761"
==> Start the  docker service on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

azureuser@Elk-VM:~$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED       STATUS       PORTS                                                                              NAMES
36e85bf7e325   sebp/elk:761   "/usr/local/bin/star…"   10 days ago   Up 5 hours   0.0.0.0:5044->5044/tcp, 0.0.0.0:5601->5601/tcp, 0.0.0.0:9200->9200/tcp, 9300/tcp   elk


### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 : 10.0.0.8
- Web-2 : 10.0.0.7

We have installed the following Beats on these machines:
- Specify which Beats you successfully installed_
==> filebeat
==> metricbeat

These Beats allow us to collect the following information from each machine:
-  In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

Filebeat is used to collect the logs of any changes to the files in the server or any specified files. This will be used to keep in track of changes made to any file.

Metricbeat is used to collect the statistics and metrics of the operating system or even the services running on the system and used for analysis.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install-elk.yml to /etc/ansible.
- Update the hosts file to include the Elk-VM IP under [elk].
- Run the playbook install-elk.yml, and navigate to http://52.161.65.211:5601/app/kibana to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it? install-elk.yml is the playbook and we copy it to /etc/ansible/
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
We update the /etc/ansible/hosts file to include 

[elk]
10.1.0.4 ansible_python_interpreter=/usr/bin/python3

The above addition is to make ansible run the install-elk.yml playbook on a specific elk machine

We update the /etc/ansible/files/filebeat-config.yml to include

hosts: ["10.1.0.4:9200"]
username: "elastic"
password: "changeme"

And 

setup.kibana:
  host: "10.1.0.4:5601"

Which will specify where the filbeat should be installed by specifying the Elk-VM IP.

- _Which URL do you navigate to in order to check that the ELK server is running?

http://52.161.65.211:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

==> SSH into the Jump-Box 52.170.250.38
==> sudo docker container list -a
==> sudo docker start pedantic_haslett
==> sudo docker attach pedantic_haslett
==> cd /etc/ansible
==> ansible-playbook install-elk.yml
==> cd /etc/ansible/roles
==> ansible-playbook filebeat-playbook.yml
==> ansible-playbook metricbeat-playbook.yml
==> Open the browser and check the "http://52.161.65.211:5601/app/kibana#/home" - Kibana web portal, where we can check system logs, metrics etc.
