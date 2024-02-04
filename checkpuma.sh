# Script to keep rails running in case it stops
# Mu edit the crontab in user mode:
# "crontab -e"
# then add line:
# * * * * * /home/skon/cloudwifi/checkpuma.sh
# Change "skon" to a user with sudo privilege in /etc/group
# and add to sudoers list
if pgrep -f cloudwifi | grep ruby >/dev/null
then
    echo "Puma is running."
else
    #echo "Puma is not running."
    sudo su skon
    #echo "Change to cloudwifi directory" >> "/home/ubuntu/cloudwifi/cron.log"
    cd /home/skon/cloudwifi
    #echo "Remove log"  >> "/home/skon/cloudwifi/cron.log"
    #rm log/development.log
    #echo "Start Rails"  >> "/home/skon/cloudwifi/cron.log"
    export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/skon/.local/bin:/home/skon/.rbenv/shims:/home/skon/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
    nohup rails s -b 0.0.0.0 &
    #echo "DONE!"  >> "/home/skon/cloudwifi/cron.log"
fi
