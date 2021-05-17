#!/bin/sh 
#terrform variable setting through customer input
echo ""
echo "..................Welcome to the Script.................."
echo ".Let's start to create a complete VPC through Terraform."
echo ""
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

echo "#..................Creating Infrastructure..................."
echo ""
#Setup Terrafrom under the current working directory
if [[ -d .terraform ]]; then 
	echo "Terrafrom is already installed"
else
read -p 'Do you want to install Terraform on this current directory [y/N]:' con1
if [[ "$con1" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
wget https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip
unzip terraform*.zip 2>&1
mv terraform /usr/bin/

echo "Terraform downloading completed...................."
echo ""
sleep 2
echo "start to connect provider.tf to terraform.........."
echo ""
terraform init
else 
	echo "Please re-run the script or install terraform manually"
fi
fi

echo ""
read -p 'Do you need to validate our VPC script with your mentioned values [y/N]:' con2
if [[ "$con2" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
terraform validate
echo "Your current values with -terrafrom plan- result is below:"
sleep 3
terraform plan
fi

echo ""
read -p 'Do you need to apply the script to your infrastructure [y/N]:' con3
if [[ "$con3" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
terraform apply -auto-approve
sleep 3
echo ""
echo "Your VPC created successfully............"
echo ""
echo "................Thank_you................"
echo "................Yousaf K Hamza................"
echo "................yousaf.k.hamza@gmail.com................"
else
echo "Please re-run the file or manualy handled through terraform commands"
exit
fi
