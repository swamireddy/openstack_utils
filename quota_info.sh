#!/bin/bash


if [ "$OS_USERNAME" != "admin" ] && [ "$OS_TENANT_NAME" != "admin" ]
then
  echo "**************************************************"
  echo "****Error: Not sourced the \"admin\" user openrc **"
  echo "**source openrc for admin tenant and re-run as below"
  echo "sh $0"
  echo "****************************************************"
fi

# Create a tmp dir to place the log the file in current working directory
mkdir tmp  

keystone tenant-list > ./tmp/t_list

TENANT_ID=`cat  ./tmp/t_list | awk -F'|' '{print $2}'`

NVARS="RAM Cores FloatingIps Instances"
CVARS="volumes gigabytes snapshots"

echo "Tenant Name,,RAM(MBs),,,Cores,,,FloatingIps,,,Instances,,,Volumes,,,Gigabytes,,,Snapshots,,"
echo ",Max,Used,Util %,Max,Used,Util %,Max,Used,Util %,Max,Used,Util%,Max,Used,Util %,Max,Used,Util %,Max,Used,Util %"

for t in  $TENANT_ID
do
  if [ "$t" != "id" ]
  then
  echo -n "`cat ./tmp/t_list | grep $t | awk -F'|' '{print $3}'`"
  nova --insecure absolute-limits  --tenant $t > ./tmp/nova_limits.$t
  for i in $NVARS
  do
    Max=`cat ./tmp/nova_limits.$t  |grep $i | grep max | awk '{print $4}'`
    Used=`cat ./tmp/nova_limits.$t |grep $i | grep Used | awk '{print $4}'`
    PER=`expr  100 \* $Used \/ $Max`
    echo -n ",$Max,$Used,$PER"
  done

  #From Cinder
  cinder --insecure quota-usage $t > ./tmp/cinder_limits.$t
  for i in $CVARS
  do
    Used=`cat ./tmp/cinder_limits.$t |grep $i | grep -v $i\_ | awk '{print $4}'`
    Max=`cat ./tmp/cinder_limits.$t |grep $i | grep -v $i\_ | awk '{print $8}'`
    PER=`expr  100 \* $Used \/ $Max`
    echo -n ",$Max,$Used,$PER"
  done
  echo  " "
fi
done
