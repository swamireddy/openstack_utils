# openstack_utils

quota_info.sh:
  - Prequivisits:
       -- Source the admin user openrc file to get all tenants quota related details
  - Run the scripts as below:
        > sh quota_info.sh
  -  Sample output:
  
  Tenant Name,,RAM(MBs),,,Cores,,,FloatingIps,,,Instances,,,Volumes,,,Gigabytes,,,Snapshots,,,Max,Used,Util %,Max,Used,Util %,Max,Used,Util %,Max,Used,Util%,Max,Used,Util %,Max,Used,Util %,Max,Used,Util %
                          ABC                          ,1024000,105728,10,200,57,28,100,0,0,500,26,5,100,10,10,10000,462,4,100,4,4
                       ABC1                       ,51200,0,0,100,0,0,100,0,0,100,0,0,10,0,0,1000,0,0,10,0,0
                          AB2                        ,51200,28736,56,100,15,15,100,0,0,100,11,11,20,13,65,1000,192,19,10,0,0


  - Limitations: Currently this script will display the output cvs format.
