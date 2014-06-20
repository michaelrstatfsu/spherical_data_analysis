import cwiid
import time

print 'Press 1+2 on your Wiimote 2 now...'
wm1 = cwiid.Wiimote()
#time.sleep(.5)
wm1.rpt_mode = cwiid.RPT_BTN | cwiid.RPT_ACC
wm1.led = 1
wm1data = open('wm1data', 'w')

print 'Press 1+2 on your Wiimote 2 now...'
wm2 = cwiid.Wiimote()
#time.sleep(1)
wm2.rpt_mode = cwiid.RPT_BTN | cwiid.RPT_ACC
wm2.led = 2
wm2data = open('wm2data', 'w')


raw_input("Press Enter to continue...")
print '...get ready...'
time.sleep(1)

go=True
ind=1
print 'start'
while (ind<100):
    acc0=str(wm1.state['acc'][0])
    acc1=str(wm1.state['acc'][1])
    acc2=str(wm1.state['acc'][2])
    data=str(acc0+','+acc1+','+ acc2)
    wm1data.write( "%s\n" % data)
    acc0=str(wm2.state['acc'][0])
    acc1=str(wm2.state['acc'][1])
    acc2=str(wm2.state['acc'][2])
    data=str(acc0+','+acc1+','+ acc2)
    wm2data.write( "%s\n" % data)
    time.sleep(.2)
    ind=ind+1
    print ind

