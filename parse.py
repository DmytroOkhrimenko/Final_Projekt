import sys
import os
if len(sys.argv) != 2:
    print("Enter a phrase or word for search")
    sys.exit()
searchWord = sys.argv[1]
search_dir = '/home/ubuntu/aws_bucket'
f_list = [ x for x in os.listdir(search_dir) if '.txt' in x ]
def find_line(f_name, searchWord, path):
    with open(search_dir+"/"+f_name) as inp:
        result_list = []
        for line in inp:
            if searchWord in line:
                #print("Line is found. Stop")
                result_list.append(line)
    return result_list

def write_line(lines):
    out = 'epam.txt'
    with  open(out,'a') as output:
        for line in lines:
            output.write(line+'\n')

for f_ in f_list:
    line = find_line(f_,searchWord, search_dir)
    if line != None :
        write_line(line)
