import serial.tools.list_ports
import random
import time
import  sys
import firebase_admin
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

SmartHomeDB = firestore.client()
def getPort():
    ports = serial.tools.list_ports.comports()
    N = len(ports)
    commPort = "None"
    for i in range(0, N):
        port = ports[i]
        strPort = str(port)
        if "USB Serial Device" in strPort:
            splitPort = strPort.split(" ")
            commPort = (splitPort[0])
    return commPort

isMicrobitConnected = False
if getPort() != "None":
    ser = serial.Serial(port=getPort(), baudrate=115200)
    isMicrobitConnected = True

def processData(data):
    data = data.replace("!", "")
    data = data.replace("#", "")
    splitData = data.split(":")
    print(splitData)
    if splitData[1] == "TIMELED":
        time_led = time.time()
        day = time.ctime(time_led).split(" ")
        SmartHomeDB.collection('Led').add({'day': day[0], 'date': day[2], 'month': day[1],'time' : splitData[2]})
    if splitData[1] == "TIMEFAN":
        time_led = time.time()
        day = time.ctime(time_led).split(" ")
        SmartHomeDB.collection('Fan').add({'day': day[0], 'date': day[2], 'month': day[1],'time' : splitData[2]})
mess = ""
def readSerial():
    bytesToRead = ser.inWaiting()
    if (bytesToRead > 0):
        global mess
        mess = mess + ser.read(bytesToRead).decode("UTF-8")
        while ("#" in mess) and ("!" in mess):
            start = mess.find("!")
            end = mess.find("#")
            processData(mess[start:end + 1])
            if (end == len(mess)):
                mess = ""
            else:
                mess = mess[end+1:]
while True:
    if isMicrobitConnected:
        readSerial()
    time.sleep(1)