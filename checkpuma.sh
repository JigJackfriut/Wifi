if pgrep -f cloudwifi | grep ruby >/dev/null
then
    echo "Puma is running."
else
    #echo "Puma is not running."
    sudo su ubuntu
    #echo "Change to cloudwifi directory" >> "/home/ubuntu/cloudwifi/cron.log"
    cd /home/ubuntu/cloudwifi
    #echo "Remove log"  >> "/home/ubuntu/cloudwifi/cron.log"
    rm log/development.log
    #echo "Start Rails"  >> "/home/ubuntu/cloudwifi/cron.log"
    export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/ubuntu/.local/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
    nohup rails s -b 0.0.0.0 &
    #echo "DONE!"  >> "/home/ubuntu/cloudwifi/cron.log"
fi
