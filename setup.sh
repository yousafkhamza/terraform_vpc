#!/bin/sh 

echo ""
echo "..................Welcome to the Script.................."
echo "Let's start to create a complete VPC through Terraform...."
echo ""

if [[ -d .terraform ]]; then 
echo "Provider and variable values are already configured."
echo ""
read -p 'Do you want to reconfigure the variables (Region,VPC_CIDR,ProjectName) file [y/N]: ' con4
case "$con4" in 
yes|YES|y|Y)
read -p "Please specify your region: " reconreg 
if [ -z $reconreg  ]; then
echo ""
echo "No region value entered so it will be take the previous value"
echo ""
else
	sed -i '/region/d'		./terraform.tfvars
	echo 'region 	= "-REGION-"'	>> ./terraform.tfvars
	sed -i "s/-REGION-/"$reconreg"/" ./terraform.tfvars
fi

read -p "Please specify your project name: " reconpname 
if [ -z $reconpname ]; then
echo ""
echo "No Project Name entered so it will be take the previous value"
echo ""
else
	sed -i '/project/d'	./terraform.tfvars
	echo 'project = "-PROJECTNAME-"'	>> ./terraform.tfvars
	sed -i "s/-PROJECTNAME-/"$reconpname"/" ./terraform.tfvars
fi


read -p "Please specify your vpc_cidr: " reconvcidr 
if [ -z $reconvcidr ]; then
echo ""
echo "No VPC CIDR value entered it will be take the previous value"
echo ""
else
	sed -i '/vpc_cidr/d'	./terraform.tfvars
	echo 'vpc_cidr 	= "-VPCCIDR-"'	>> ./terraform.tfvars
	sed -ie "s|-VPCCIDR-|"$reconvcidr"|g" ./terraform.tfvars
fi
;;
esac

else
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
echo "No Project Name entered"
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
fi

echo ""
echo "Creating Infrastructure..................."
sleep 1
echo "...................................."
echo "............................."
sleep 1
echo ".................."
echo "......."
sleep 1
echo ""
#Setup Terrafrom under the current working directory
if [[ -d .terraform ]]; then 
	echo ""
	echo "Terrafrom is already installed"
else
read -p 'Do you want to install Terraform on this current directory [y/N]: ' con1
case "$con1" in 
yes|YES|y|Y)
echo ""
wget https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip 2>&1
unzip terraform*.zip 2>&1
mv terraform /usr/bin/
rm -f terraform*.zip
echo ""
echo "Terraform downloading completed...................."
echo ""
sleep 2
echo "start to connect provider.tf to terraform.........."
echo ""
terraform init
;;
*)
	ehco ""
	echo "Please re-run the script or install terraform manually"
	exit 1
;; 
esac
fi

echo ""
read -p 'Do you need to run terraform validate/result preview with your mentioned values [y/N]: ' con2
case "$con2" in 
yes|YES|y|Y)
terraform validate
echo ""
echo "Validation is successfull."
echo""
sleep 1
echo "Let's run the terraform plan......"
sleep 1
terraform plan
;;
esac

echo ""
read -p 'Do you need to apply the values to your infrastructure [y/N]: ' con3
case "$con3" in 
yes|YES|y|Y)
terraform apply -auto-approve
sleep 2
echo ""
echo "Your VPC created successfull......................"
echo ""
echo "................Thank_you................"
echo "..............Yousaf K Hamza................"
echo "..........yousaf.k.hamza@gmail.com................"
;;
*)
echo "Please re-run the setup file or manualy handled through terraform"
exit
;;
esac
