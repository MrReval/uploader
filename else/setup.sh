#!/usr/bin/env bash

echo 'Install prerequisites (step 1)'
apt update && apt install python3-pip python3-venv redis git -y
if [ $? == 0 ]; then
  echo 'Successfully installed'
else
  echo 'An error occurred while installing the prerequisites'
  exit
fi

echo 'start redis service'
systemctl start redis.service
if [ $? == 0 ]; then
  echo 'redis servie started'
else
  echo 'service starting failed'
  exit
fi

echo "Creating uploader directory (step 2)"
mkdir -p /var/www/uploader && cd /var/www/uploader

echo 'Pulling the repository (step 3)'
git init
git remote add origin https://github.com/MrReval/uploader.git
git pull origin main
if [ $? != 0 ]; then
  echo 'could not clone the repository'
  exit
fi

echo 'Create virtual env (step 4)'
python3 -m venv /var/www/uploader/venv
if [ $? != 0 ]; then
  echo "VENV didn't created"
fi

echo 'Installing project dependencies (step 5)'
cd /var/www/uploader && source /var/www/uploader/venv/bin/activate && pip install wheel && pip install uploader_core/ uploader_menu/ && deactivate
if [ $? != 0 ]; then
  echo "Dependencies doesn't installed correctly"
  exit
fi

echo 'Create uploader service (step 6)'
ln -s /var/www/uploader/else/uploader.service /etc/systemd/system/
if [ $? != 0 ]; then
  echo 'Creating service was failed'
  exit
fi

echo 'Reload services and start uploader.service (step 7)'
systemctl daemon-reload
sudo systemctl enable uploader.service
sudo systemctl start uploader.service
if [ $? != 0 ]; then
  echo "uploader service didn't started"
  exit
fi

echo "make uploader as a command (step 8)"
ln -s /var/www/uploader/else/uploader /usr/local/bin/ && chmod +x /usr/local/bin/uploader
if [ $? != 0 ]; then
  echo "failed to add uploader to PATH environment variables"
  exit
fi

echo "activate source (step 9)"
source /var/www/uploader/venv/bin/activate
if [ $? != 0 ]; then
  echo "failed to activate source"
  exit
fi

echo "make sure setuptool installed (step 10)"
pip install setuptools
if [ $? != 0 ]; then
  echo "failed to install setuptool"
  exit
fi
