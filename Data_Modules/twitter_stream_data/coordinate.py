import sys
import json
import unicodedata

def lines(fp):
    print str(len(fp))

def main():
	sent_file = open(sys.argv[1])
	tweet_file = open(sys.argv[2])
	outfile=open('Data/coordinate_data.txt','w')
	rawdata = tweet_file.readlines()
	mood = sent_file.readlines()
	for line in rawdata:
		sentiment=0
		l=json.loads(line)		
		message=l.get('text')
		coord=l.get('coordinates')
		if not (message is None):
		 if not (coord is None):
		  lat=coord['coordinates'][0]
		  lon=coord['coordinates'][1]
		  message=message.encode('utf-8')
		  outfile.write(str(lat)+'\t')
		  outfile.write(str(lon)+'\t')
#		  udata=message.decode("utf-8")
#		  asciidata=udata.encode("ascii","ignore")
		  outfile.write(message.replace('\n', '')+'\t')
		  for line2 in mood:
	           w=line2.split('\t',1)[0]
		   win=message.count(w)
		   if win>0:
		    score=int(line2.split('\t',1)[1])
	            sentiment=sentiment+score
		  outfile.write(str(sentiment)+'\n')		
	sent_file.close()
	tweet_file.close()
	outfile.close()
if __name__ == '__main__':
    main()

