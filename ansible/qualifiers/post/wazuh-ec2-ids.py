import boto3
import csv


session = boto3.session.Session(
  region_name = 'us-east-2',
  profile_name = 'neccdl'
)

ec2 = session.client('ec2')
    
response = ec2.describe_instances(
  Filters = [{
    'Name': 'tag:Service', 
    'Values': ['Wazuh']
  }]
)

with open("team-wazuh-ids.csv", "w") as file:
  fieldnames = ['Team Number', 'ID']
  writer = csv.DictWriter(file, fieldnames=fieldnames)
  writer.writeheader()

  for instance in response['Reservations'][0]['Instances']:
    writer.writerow({"Team Number": instance['PrivateIpAddress'].split('.')[1], "ID": instance['InstanceId']})
