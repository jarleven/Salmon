### Some info about the Google Coral TPU devboard

```

https://coral.ai/docs/dev-board/mdt/
https://coral.ai/docs/dev-board/serial-console/#connect-with-linux

```

#### The default username and password are both "mendel".


```

python3 -m pip install --user mendel-development-tool
echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bash_profile
source ~/.bash_profile

sudo usermod -aG plugdev,dialout <username>
sudo apt install screen -y

```

```
jarleven@ros2:~$ mdt shell
Waiting for a device...
Connecting to hopeful-yarn at 192.168.100.2
Key not present on hopeful-yarn -- pushing

Couldn't connect to keymaster on hopeful-yarn: [Errno 111] Connection refused.

Did you previously connect from a different machine? If so,
mdt-keymaster will not be running as it only accepts a single key.

You will need to either:
   1) Remove the key from /home/mendel/.ssh/authorized_keys on the
      device via the serial console

- or -

   2) Copy the mdt private key from your home directory on this host
      in ~/.config/mdt/keys/mdt.key to the first machine and use
      'mdt pushkey mdt.key' to add that key to the device's
      authorized_keys file.

Failed to push via keymaster -- will attempt password login as a fallback.
Can't login using default credentials: Bad authentication type; allowed types: ['publickey']
jarleven@ros2:~$ 


sudo usermod -aG plugdev,dialout <username>
sudo apt install screen -y

dmesg | grep ttyUSB

[ 6437.706335] usb 2-13.1: cp210x converter now attached to ttyUSB0
[ 6437.708049] usb 2-13.1: cp210x converter now attached to ttyUSB1

USE USB 0 in this case

screen /dev/ttyUSB0 115200

Hit reset button !

The default username and password are both "mendel".



vi /home/mendel/.ssh/authorized_keys

just hold "d" button   then "esc" button :wq and enter


```

