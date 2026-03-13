## Core Unix Commands

Most unix commands have super short names which makes them quick to type but annoying to learn. Major file systems related commands include:

pwd:	Print working directory
ls:	List files and directories
cd:	Change directory
mkdir:	Make a new directory
rm:	Remove files and directories (delete)
cp:	Copy files (source > destination)
mv:	Move files or directories (basically rename)
nano:	A wee text editor (very basic but always available)

curl:         Download files from web or ftp
wget:         Download files from the web
tar -zxvf:    UnTar (unpackage) Tar archive files
gunzip:       UnZip files
$PATH:        The places (dirs) to look for programs

## AWS EC2 Instance

Connect to my instance with:

ssh -i ~/Downloads/bimm143_mitch.pem ubuntu@ec2-35-91-97-0.us-west-2.compute.amazonaws.com

Secure Copy files between machines, in this case, from 

scp -i ~/Downloads/bimm143_mitch.pem ubuntu@ec2-35-91-97-0.us-west-2.compute.amazonaws.com:/home/ubuntu/work/bimm143_github/lecture16/results.txt .

## Class 17 Instance

ssh -i ~/Downloads/bimm143_mitch.pem ubuntu@ec2-35-162-124-144.us-west-2.compute.amazonaws.com

Let's save the arguments in variables:
export KEY=~/Downloads/bimm143_mitch.pem
export SERVER=ubuntu@ec2-35-162-124-144.us-west-2.compute.amazonaws.com

ssh -i $KEY $SERVER

scp -r -i $KEY $SERVER:~/*_quant .