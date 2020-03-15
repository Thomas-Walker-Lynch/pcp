#!/usr/bin/python3

import sys
import os

def test_2_t0():
  tn = "test_2_t0"
  print(tn)
  flags = []
 
  f1 = open("f1","w")
  f1.write("I am file1")
  f1.close()

  f2 = open("f2","w")
  f2.write("I am file2")
  f2.close()

  flags.append(os.system("touch dest") == 0)
  flags.append(os.system("../pcp a f1 f2 dest") != 0) # should print error message
  os.system("rm f1 f2")

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0

def test_2_t1():
  tn ="test_2_t1"
  print(tn)
  flags = []
 
  f1 = open("f1","w")
  f1.write("I am file1")
  f1.close()

  f2 = open("f2","w")
  f2.write("I am file2")
  f2.close()

  flags.append(os.system("touch dest") == 0)
  flags.append(os.system("../pcp a b f2 dest") != 0) # should print error message
  os.system("rm f1 f2")

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0


def test_4_1_1():
  tn = "test_4_1_1"
  print(tn)
  flags = []

  f = open("file","w")
  f.write("hello!\n")
  f.close()

  flags.append(os.system("../pcp file new") == 0)
  flags.append(os.system("diff -rq file new") == 0) # no output from diff

  os.system("rm file")

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0

def test_4_1_2():
  tn = "test_4_1_2"
  print(tn)
  flags = []

  f1 = open("file1","w")
  f1.write("file1 contents")
  f1.close

  f2 = open("file2","w")
  f1.write("file2 contents")
  f2.close

  flags.append(os.system("../pcp file1 file2")==0)
  flags.append(os.system("diff -rq file1 file2")==0)

  os.system("rm file1 file2")

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0


def test_4_1_3():
  tn = "test_4_1_3"
  print(tn)
  flags=[]

  f1 = open("file1","w")
  f1.write("I am file1")
  f1.close()
  os.system("mkdir dst1")
  os.system("../pcp file1 dst1")

  flags.append(os.system("../pcp file1 dst1")==0)
  flags.append(os.system("diff -rq file1 dst1/file1")==0)
             
  os.system("rm -r file1 dst1")

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0

#dat/t1 pre-exists
def test_4_2_1():
  tn = "test_4_2_1"
  print(tn)
  flags=[]

  os.system("rm -rf dat/t1_copy")

  flags.append( os.system("../pcp dat/t1 dat/t1_copy") ==0)
  flags.append( os.system("diff -rq dat/t1 dat/t1_copy") ==0)

  os.system("rm -r dat/t1_copy")

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0

def test_4_2_2():
  tn = "test_4_2_2"
  print(tn)
  flags=[]

  flags.append( os.system("../pcp dat/t1 dat/f1") !=0)

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0

def test_4_2_3():
  tn = "test_4_2_3"
  print(tn)
  flags=[]

  flags.append( os.system("../pcp dat/t1 dat/t2") ==0)
  flags.append( os.system("diff -qr dat/t1 dat/t2/t1") ==0)
  os.system("rm -r dat/t2/t1")

  #print(tn, " ", flags)
  if not all(flags):
    print("failed: ", tn)
    return 1
  return 0



def test():
  i = 0
  fail_cnt = 0

  # fail_cnt += test_2_t0()
  # i+=1
  # fail_cnt += test_2_t1()
  # i+=1
  # fail_cnt += test_4_1_1()
  # i+=1
  # fail_cnt += test_4_1_2()
  # i+=1
  # fail_cnt += test_4_1_3()
  # i+=1
  # fail_cnt += test_4_2_1()
  # i+=1
  # fail_cnt += test_4_2_2()
  # i+=1
  fail_cnt += test_4_2_3()
  i+=1

  print("tests total: ", i)
  print("tests failed: ", fail_cnt)
  return fail_cnt

test()
