#!/bin/bash

#- Author : Dilshan Wijesooriya

script_path='/home/azureuser/Monitoring_Script'
cd $script_path

function start_stat_script {
  ./monitoring.sh >> vm-stat-report.log 2>&1 &
}

function stop_script {
  id=`pgrep -f monitoring.sh` ; kill -9 $id
}

function get_logs {
  echo ' '
  read -p 'Type a name for the saving folder: ' save_folder
  usflog=$(log=$(sudo docker ps | grep azureuser_usf_1 | cut -d ' ' -f1) ; sudo docker inspect --format='{{.LogPath}}' $log)
  usflogname=$(log=$(sudo docker ps | grep azureuser_usf_1 | cut -d ' ' -f1) ; sudo docker inspect --format='{{.LogPath}}' $log| cut -d '/' -f6)
  sudo cp -r $usflog $script_path
  sudo chown -R azureuser:azureuser *
  grep '/opt/usf/models/EPS/forecasting' *-json.log > saved_models.log
  grep -i 'started invoking algorithms for model name\|finished invoking algorithms for model name' *-json.log > model_building_times.log
  mv *-json.log usf-json.log
  mkdir $save_folder
  mv *.log $save_folder
  echo ' '
  echo "Type 'scp -r azureuser@172.18.128.21:/home/azureuser/Monitoring_Script/$save_folder' in seperate terminal to download the files"
  echo ' '
}

echo ' '
echo ' VM Stat & Report Generator'
echo ' '
echo '    1 : Start Stat Collecting Script'
echo '    2 : Stop Stat Collecting Script'
echo '    3 : Generate Logs'
echo ' '
read -p '    Enter the Selection: ' uinput

if [ $uinput = '1' ]
  then
    start_stat_script
    tail -f $script_path/vm-stat-report.log
elif [ $uinput = '2' ]
  then
   stop_script
 elif [ $uinput = '3' ]
   then
    get_logs
 else
    echo  'Incorrect Selection'
 fi
