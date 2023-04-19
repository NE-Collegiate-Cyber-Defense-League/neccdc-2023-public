for ip in 10.0.0.{4..5}
do
	echo $ip
	exit
	ssh ec2-user@$ip docker pull mongo:6.0.3
	ssh ec2-user@$ip docker pull rocket.chat:5.4.0
	ssh ec2-user@$ip docker pull mariadb:10.9.4
	ssh ec2-user@$ip docker pull nginx:1.23.3
	ssh ec2-user@$ip docker pull nextcloud:25.0.3
	ssh ec2-user@$ip sudo nmcli con mod eth0 ipv4.dns "10.0.2.4"
	ssh ec2-user@$ip sudo systemctl restart NetworkManager.service
done
