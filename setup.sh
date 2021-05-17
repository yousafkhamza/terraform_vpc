#!/bin/bash 

#terrform variable setting through customer input
echo "#############VPC CREATION THROUGH TERRAFORM##############"
rm -f ./terraform.tfvars

cat <<EOF >terraform.tfvars
region 		= "-REGION-"
access_key 	= "-ACCESSKEY-"
secret_key 	= "-SECREATKEY-"
project 	= "-PROJECTNAME-"
vpc_cidr 	= "-VPCCIDR-"
EOF
read -p "Please specify your region: " reg 
if [ -z $reg  ]; then
echo "No region value entered"
exit 1
else
	sed -i "s/-REGION-/"$reg"/" ./terraform.tfvars
fi

read -p "Please specify your access_key: " akey
if [ -z $akey ]; then 
echo "No Access_key entered"
exit 1
else
	sed -i "s/-ACCESSKEY-/"$akey"/" ./terraform.tfvars
fi

read -p "Please specify your secret_key: " skey
if [ -z $skey ]; then 
echo "No secreat key value entered"
exit 1
else
	sed -i "s/-SECREATKEY-/"$skey"/" ./terraform.tfvars
fi

read -p "Please specify your project name: " pname 
if [ -z $pname ]; then
echo "No ProjectName entered"
exit 1
else 
	sed -i "s/-PROJECTNAME-/"$pname"/" ./terraform.tfvars
fi

read -p "Please specify your vpc_cidr: " vcidr 
if [ -z $vcidr ]; then
echo "No VPC CIDR value entered"
exit 1
else
	sed -ie "s|-VPCCIDR-|"$vcidr"|g" ./terraform.tfvars
fi

#Setup Terrafrom under the current working directory
read -p 'Do you want to install Terraform under the current directory `pwd`. NB: Already installed directory please select NO [y/N]:' con1
if [[ "$con1" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
wget https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip
unzip terraform*.zip 2>/dev/null
mv terraform /usr/bin/

echo "Terraform downloading completed...................."
sleep 2
echo "start to connect provider.tf to terraform.........."
terraform init
fi

read -p 'Do you need to validate our VPC script with your mentioned values [y/N]:' con2
if [[ "$con2" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
terraform validate
echo "Your current values with -terrafrom plan- result is below:"
sleep 3
terraform plan
fi

read -p 'Do you need to apply the script your infrastructure [y/N]:' con3
if [[ "$con3" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
terraform apply -auto-approve
sleep 3
echo "Your VPC is created"
else
echo "Please re-run the file"
exit
fi
