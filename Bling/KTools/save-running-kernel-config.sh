KernelVersion=`uname -r`
echo Kernel Version Is: $KernelVersion
cat /lib/modules/$(uname -r)/build/.config > kernel.config
echo Kernel Config Saved.
