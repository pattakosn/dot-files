# set vars
SERVERIPMI=192.168.0.2
SERVERUNSER=root
SERVERPASS=calvin
# enable manual mode 
ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x01 0x00
# enable 10% fan mode 
ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x02 0xff 0x05
# enable 20% fan mode 
#ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x02 0xff 0x14
# enable 30% fan mode 
#ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x02 0xff 0x1e
# enable 40% fan mode 
#ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x02 0xff 0x28
# enable 100% fan mode 
#ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x02 0xff 0x64
# enable 0% fan mode 
#ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x02 0xff 0x00
# enable AUTO fan mode 
#ipmitool -I lanplus -H $SERVERIPMI -U $SERVERUNSER -P $SERVERPASS raw 0x30 0x30 0x01 0x01

